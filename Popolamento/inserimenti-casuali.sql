-- Procedure chiamate dagli scirpt di inserimento per inserire relazioni tra tabelle

DELIMITER $$

DROP PROCEDURE IF EXISTS `EsclusioneCasuale` $$

CREATE PROCEDURE `EsclusioneCasuale`(IN abb VARCHAR(50))
BEGIN
    REPLACE INTO `Esclusione` (`Genere`, `Abbonamento`)
        SELECT `Genere`.`Nome`, abb
        FROM `Genere`
        ORDER BY RAND()
        LIMIT 1;
END $$

DROP PROCEDURE IF EXISTS `RecensioneCasuale` $$

CREATE PROCEDURE `RecensioneCasuale`(IN utente VARCHAR(100))
BEGIN
    REPLACE INTO `Recensione` (`Film`, `Utente`, `Voto`)
        SELECT `Film`.`ID`, utente, RAND() * 5
        FROM `Film`
        ORDER BY RAND()
        LIMIT 1;
END $$

DROP PROCEDURE IF EXISTS `VisualizzazioneCasuale` $$

CREATE PROCEDURE `VisualizzazioneCasuale`(IN utente VARCHAR(100), IN ip INT, IN Inizio TIMESTAMP)
BEGIN
    REPLACE INTO `Visualizzazione` (`Timestamp`, `Utente`, `IP`, `InizioConnessione`, `Edizione`)
        WITH `RandEdizione` AS (
            SELECT E.`ID`, FLOOR(E.`Lunghezza` * RAND()) AS "Delta"
            FROM `Edizione` E
            ORDER BY RAND()
            LIMIT 1
        )
        SELECT TIMESTAMPADD(SECOND, E.`Delta` * (-1), inizio), utente, ip, inizio, E.`ID`
        FROM `RandEdizione` E;
END $$

DROP PROCEDURE IF EXISTS `RandPoP` $$

CREATE PROCEDURE `RandPoP`(IN server_id INT)
BEGIN
    REPLACE INTO `Pop` (`File`, `Server`)
        WITH `RandFile` AS (
            SELECT F.`ID`
            FROM `File` F
            ORDER BY RAND()
            LIMIT 1
        )
        SELECT F.`ID`, server_id
        FROM `RandFile` F;
END $$

DROP PROCEDURE IF EXISTS `AggiungiErogazioni` $$

CREATE PROCEDURE `AggiungiErogazioni`()
BEGIN
    REPLACE INTO `Erogazione` (`Timestamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`, `InizioErogazione`, `Server`)
        WITH `VisualizzazioniInCorso` AS (
            SELECT V.*
            FROM `Visualizzazione` V
                INNER JOIN `Edizione` E ON E.`ID` = V.`Edizione`
            WHERE TIMESTAMPDIFF(SECOND, CURRENT_TIMESTAMP, `Timestamp`) <= E.`Lunghezza`
        )
        SELECT V.*, V.`TimeStamp`, `PoP`.`Server`
        FROM `VisualizzazioniInCorso` V
            INNER JOIN `File` F USING(`Edizione`)
            INNER JOIN `PoP` ON `PoP`.`File` = `File`.`ID`;
END $$

DROP PROCEDURE IF EXISTS `AggiungiGeneri` $$

CREATE PROCEDURE `AggiungiGeneri`()
BEGIN
    -- Viene fatto 2 volte perche' cosi' un Film ha in media 2 generi
    REPLACE INTO `GenereFilm` (`Film`, `Genere`)
        WITH `RandGenere` AS (
            SELECT `Nome`
            FROM `Genere`
            ORDER BY RAND()
            LIMIT 1
        )
        SELECT F.`ID`, G.`Nome`
        FROM `Film` F
            CROSS JOIN `RandGenere` G;

    REPLACE INTO `GenereFilm` (`Film`, `Genere`)
        WITH `RandGenere` AS (
            SELECT `Nome`
            FROM `Genere`
            ORDER BY RAND()
            LIMIT 1
        )
        SELECT F.`ID`, G.`Nome`
        FROM `Film` F
            CROSS JOIN `RandGenere` G;

END $$

DELIMITER ;