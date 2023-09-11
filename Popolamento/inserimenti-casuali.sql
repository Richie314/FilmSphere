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
        WITH `FilmCasuale` AS (
            SELECT `Edizione`.`Film` AS "ID"
            FROM `Edizione`
            ORDER BY RAND()
            LIMIT 1
        )
        SELECT F.`ID`, utente, RAND() * 5
        FROM `FilmCasuale` F;
END $$

DROP PROCEDURE IF EXISTS `VisualizzazioneCasuale` $$

CREATE PROCEDURE `VisualizzazioneCasuale`(IN utente VARCHAR(100), IN IP INT UNSIGNED, IN Inizio TIMESTAMP)
BEGIN
    REPLACE INTO `Visualizzazione` (`Timestamp`, `Utente`, `IP`, `InizioConnessione`, `Edizione`)
        WITH `RandEdizione` AS (
            SELECT E.`ID`
            FROM `Edizione` E
            ORDER BY RAND()
            LIMIT 1
        )
        SELECT TIMESTAMPADD(SECOND, FLOOR(RAND() * 1024), Inizio), utente, IP, Inizio, E.`ID`
        FROM `RandEdizione` E;
END $$

DROP PROCEDURE IF EXISTS `RandPoP` $$

CREATE PROCEDURE `RandPoP`()
BEGIN
    DECLARE `FileMaxID` INT DEFAULT 0;
    SELECT MAX(`ID`) INTO `FileMaxID` FROM `File`;

    WHILE `FileMaxID` >= 1 DO
        REPLACE INTO `PoP` (`Server`, `File`)
            WITH `RandServer` AS (
                SELECT S.`ID`
                FROM `Server` S
                ORDER BY RAND()
                LIMIT 3
            )
            SELECT S.`ID`, `FileMaxID`
            FROM `RandServer` S;
        SET `FileMaxID` = `FileMaxID` - 1;
    END WHILE;
END $$

DROP PROCEDURE IF EXISTS `AggiungiErogazioni` $$

CREATE PROCEDURE `AggiungiErogazioni`()
BEGIN
    REPLACE INTO `Erogazione` (`Timestamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`, `InizioErogazione`, `Server`)
        WITH `VisualizzazioniInCorso` AS (
            SELECT V.`Timestamp`, V.`Edizione`, V.`Utente`, V.`IP`, V.`InizioConnessione`
            FROM `Visualizzazione` V
                INNER JOIN `Edizione` E ON E.`ID` = V.`Edizione`
            WHERE TIMESTAMPDIFF(SECOND, CURRENT_TIMESTAMP, `Timestamp`) <= E.`Lunghezza`
        )
        SELECT V.*, V.`TimeStamp`, `PoP`.`Server`
        FROM `VisualizzazioniInCorso` V
            INNER JOIN `File` F USING(`Edizione`)
            INNER JOIN `PoP` ON `PoP`.`File` = F.`ID`;
END $$

DROP PROCEDURE IF EXISTS `AggiungiGeneri` $$

CREATE PROCEDURE `AggiungiGeneri`()
BEGIN
    REPLACE INTO `GenereFilm` (`Film`, `Genere`)
        WITH `RandGenere` AS (
            SELECT `Nome`
            FROM `Genere`
            ORDER BY RAND()
        )
        SELECT F.`ID`, G.`Nome`
        FROM `Film` F
            INNER JOIN `RandGenere` G ON RAND() > 0.82
        ORDER BY F.`ID`;

END $$

DELIMITER ;