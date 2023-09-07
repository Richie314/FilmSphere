USE `FilmSphere`;

CREATE OR REPLACE VIEW `ServerConCarico` AS
    SELECT S.*, (S.`CaricoAttuale` / S.`MaxConnessioni` AS "CaricoPercentuale")
    FROM `Server` S;

-- Materialized view che contiene i suggerimenti di Erogazioni da spostare e dove spostarle
-- Non è presente nell'ER perché i suoi volumi sono talmente piccoli da essere insignificante in confronto alle altre
-- La tabella è vista più come un sistema di comunicazione tra il DBMS che individua i client da spostare e i server (fisici)\
-- che devono sapere chi spostare
CREATE TABLE IF NOT EXISTS `ModificaErogazioni`
(
    -- Riferimenti a Erogazione
    `Server` INT NOT NULL, 
    `Utente` VARCHAR(100) NOT NULL, 
    `Edizione` INT NOT NULL,
    `TimeStamp` TIMESTAMP NOT NULL,
    `InizioConnessione` TIMESTAMP NOT NULL,
    `IP` INT NOT NULL,

    -- Alternativa
    `Alternativa` INT NOT NULL, 
    `File` INT NOT NULL, 
    `Punteggio` FLOAT NOT NULL,

    PRIMARY KEY(`Server`),
    FOREIGN KEY (`TimeStamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`)
        REFERENCES `Erogazione`(`TimeStamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`) 
            ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY(`Server`) REFERENCES `Server`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(`Alternativa`) REFERENCES `Server`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(`File`) REFERENCES `File`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE
) Engine=InnoDB;


DROP PROCEDURE IF EXISTS `RibilanciamentoCarico`;
DROP EVENT IF EXISTS `RibilanciamentoCaricoEvent`;

DELIMITER $$

CREATE PROCEDURE `RibilanciamentoCarico` ()
ribilancia_body:BEGIN
    -- Variables declaration
    DECLARE `MediaCarichi` FLOAT DEFAULT NULL;
    DECLARE fetching BOOLEAN DEFAULT TRUE;

    -- Utente, Server e Visualizzazione
    DECLARE server_id INT DEFAULT NULL;
    DECLARE edizione_id INT DEFAULT NULL;
    DECLARE ip_utente INT DEFAULT NULL;
    DECLARE paese_utente CHAR(2) DEFAULT '??';
    DECLARE codice_utente VARCHAR(100) DEFAULT NULL;
    DECLARE max_definiz BIGINT DEFAULT 0;
    DECLARE timestamp_vis TIMESTAMP NULL DEFAULT NULL;
    DECLARE timestamp_conn TIMESTAMP NULL DEFAULT NULL;

    -- Caratteritiche del dispositivo utente
    DECLARE audio_accettati VARCHAR(256) DEFAULT NULL;
    DECLARE video_accettati VARCHAR(256) DEFAULT NULL;
    DECLARE max_bitrate FLOAT DEFAULT NULL;
    DECLARE max_risoluz BIGINT DEFAULT NULL;

    -- Server da escludere (perche' carichi)
    DECLARE server_da_escludere VARCHAR(32) DEFAULT NULL;

    -- Cursor declaration
    DECLARE cur CURSOR FOR
        WITH `ServerPiuCarichi` AS (
            SELECT S.`ID`
            FROM `ServerConCarico` S
            WHERE S.`CaricoPercentuale` >= `MediaCarichi`
            ORDER BY S.`CaricoPercentuale` DESC
            LIMIT 3
        ), `ServerErogazioni` AS (
            SELECT E.*
            FROM `ServerPiuCarichi` S
                INNER JOIN `Erogazione` E ON S.`ID` = E.`Server`
            WHERE S.`InizioErogazione` <= CURRENT_TIMESTAMP - INTERVAL 29 MINUTE
        ), `ErogazioniNonAlTermine` AS (
            SELECT E.*, E.`InizioConnessione` AS "Inizio"
            FROM `ServerErogazioni` E
                INNER JOIN `Edizione` Ed ON E.`Edizione` = E.`ID`
                -- Calcolo quanto dovrebbe mancare al termine della visione e controllo che sia sotto i 10 min
            HAVING Ed.`Lunghezza` - TIMESTAMPDIFF(SECOND, CURRENT_TIMESTAMP, E.`TimeStamp`) <= 600
        )
        /*, `ErogazioneConnessione` AS (
            SELECT E.*, 
        )*/
        /*
        SELECT 
            E.`Server`, E.`Edizione`, E.`IP`, 
            E.`Utente`, A.`Definizione`,
            C.ListaAudioEncodings, C.ListaVideoEncodings, 
            C.MaxBitRate, C.MaxRisoluz,
            GROUP_CONCAT(S.`ID` SEPARATOR ',') AS "ServerDaEscludere"
        FROM `ErogazioniNonAlTermine` E
            INNER JOIN `Connessione` C USING (`Utente`, `IP`, `Inizio`)
            INNER JOIN `Utente` U ON U.`Codice` = C.`Utente`
            INNER JOIN `Abbonamento` A ON A.`Tipo` = U.`Abbonamento`
            CROSS JOIN `ServerPiuCarichi` S;
        */
        SELECT 
            E.`Server`, E.`Edizione`, E.`IP`,
            E.`Utente`, A.`Definizione`,
            E.`TimeStamp`, E.`InizioConnessione`,
            NULL, NULL, NULL, NULL,
            GROUP_CONCAT(S.`ID` SEPARATOR ',') AS "ServerDaEscludere"
        FROM `ErogazioniNonAlTermine` E
            INNER JOIN `Utente` U ON U.`Codice` = E.`Utente`
            INNER JOIN `Abbonamento` A ON A.`Tipo` = U.`Abbonamento`
            CROSS JOIN `ServerPiuCarichi` S;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET fetching = FALSE;

    CREATE TEMPORARY TABLE IF NOT EXISTS `AlternativaErogazioni`
    (
        -- Riferimenti a Erogazione
        `Server` INT NOT NULL, 
        `Utente` VARCHAR(100) NOT NULL, 
        `Edizione` INT NOT NULL,
        `TimeStamp` TIMESTAMP NOT NULL,
        `InizioConnessione` TIMESTAMP NOT NULL,
        `IP` INT NOT NULL,

        -- Alternativa
        `Alternativa` INT NOT NULL, 
        `File` INT NOT NULL, 
        `Punteggio` FLOAT NOT NULL,

        PRIMARY KEY(`TimeStamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`),
        FOREIGN KEY (`TimeStamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`)
            REFERENCES `Erogazione`(`TimeStamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`) 
                ON UPDATE CASCADE ON DELETE CASCADE,

        FOREIGN KEY(`Server`) REFERENCES `Server`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY(`Alternativa`) REFERENCES `Server`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY(`File`) REFERENCES `File`(`ID`) ON UPDATE CASCADE ON DELETE CASCADE
    ) Engine=InnoDB;

    -- Actual operations
    SELECT AVG(`CaricoPercentuale`) INTO `MediaCarichi`
    FROM `ServerConCarico`;

    IF `MediaCarichi` IS NULL OR `MediaCarichi` < 0.7 THEN
        LEAVE ribilancia_body;
    END IF;

    TRUNCATE `AlternativaErogazioni`;
    
    OPEN cur;

    ciclo:LOOP
        FETCH cur INTO 
            server_id, edizione_id, 
            ip_utente, codice_utente, max_definiz,
            timestamp_vis, timestamp_conn,
            audio_accettati, video_accettati, 
            max_bitrate, max_risoluz,
            server_da_escludere;
        
        IF NOT fetching THEN
            LEAVE ciclo;
        END IF;

        SET paese_utente = Ip2Paese(ip_utente);

        CALL `TrovaMigliorServer`(
            id_edizione, paese_utente, max_definiz, 
            max_bitrate, max_risoluz,
            video_accettati, audio_accettati,
            server_da_escludere,
            @FileID, @ServerID, @Punteggio);

        INSERT INTO `AlternativaErogazioni` (
            `Server`, `Utente`, `Edizione`,
            `TimeStamp`, `InizioConnessione`, `IP`,
            `Alternativa`, `File`, `Punteggio`) VALUES (
                server_id, codice_utente, edizione_id,
                timestamp_vis, timestamp_conn, ip_utente,
                @ServerID, @FileID, @Punteggio);
    END LOOP;

    CLOSE cur;

    -- Prepariamo la tabella per i nuovi suggerimenti
    DELETE
    FROM `ModificaErogazioni`;

    IF (SELECT COUNT(*) FROM `AlternativaErogazioni`) = 0 THEN
        -- Non ci sono opzioni, esco
        LEAVE ribilancia_body;
    END IF;

    INSERT INTO `ModificaErogazioni`
        WITH `ConClassifica` AS (
            SELECT A.*, RANK(
                PARTITION BY A.`Server`
                ORDER BY A.`Punteggio` ASC
            ) Classifica
            FROM `AlternativaErogazioni` A
        ) 
        SELECT 
            A.`Server`, A.`Utente`, A.`Edizione`, 
            A.`TimeStamp`, A.`InizioConnessione`,
            A.`IP`, A.`Alternativa`, A.`File`, A.`Punteggio`
        FROM `ConClassifica` A
            INNER JOIN `Server` S ON A.`Server` = S.`ID`
        WHERE A.`Classifica` <= FLOOR(S.`MaxConnessioni` / 20); -- Per ogni Server sposto al massimo il 5% del suo MaxConnessioni

END ; $$

CREATE EVENT `RibilanciamentoCaricoEvent`
ON SCHEDULE EVERY 10 MINUTE
DO
    CALL `RibilanciamentoCarico`();
$$

DELIMITER ;