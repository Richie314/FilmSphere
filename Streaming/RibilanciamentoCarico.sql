USE `FilmSphere`;

CREATE OR REPLACE VIEW `ServerConCarico` AS
    SELECT S.*, (S.`CaricoAttuale` / S.`MaxConnessioni` AS "CaricoPercentuale")
    FROM `Server` S;


DROP PROCEDURE IF EXISTS `RibilanciamentoCarico`;

DELIMITER $$

CREATE PROCEDURE `RibilanciamentoCarico` ()
ribilancia_body:BEGIN
    -- Variables declaration
    DECLARE `MediaCarichi` FLOAT DEFAULT NULL;
    DECLARE fetching BOOLEAN DEFAULT TRUE;

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
        SELECT E.*, C.ListaAudioEncodings, C.ListaVideoEncodings, C.MaxBitRate, C.MaxRisoluz
        FROM `ErogazioniNonAlTermine`
            INNER JOIN `Connessione` C USING (`Utente`, `IP`, `Inizio`);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET fetching = FALSE;

    -- Actual operations
    SELECT AVG(`CaricoPercentuale`) INTO `MediaCarichi`
    FROM `ServerConCarico`;

    IF `MediaCarichi` IS NULL OR `MediaCarichi` < 0.7 THEN
        LEAVE ribilancia_body;
    END IF;

    
    OPEN cur;

    ciclo:LOOP
        -- FETCH cur INTO data;
        IF NOT fetching THEN
            LEAVE ciclo;
        END IF;

    END LOOP;

    CLOSE cur;
END ; $$

DELIMITER ;