USE `FilmSphere`;

-- Procedure chiamate dagli scirpt di inserimento per inserire relazioni tra tabelle

DROP PROCEDURE IF EXISTS `EsclusioneCasuale`;
DROP PROCEDURE IF EXISTS `RecensioneCasuale`;

DELIMITER $$

CREATE PROCEDURE `EsclusioneCasuale`(IN abb VARCHAR(50))
BEGIN
    REPLACE INTO `Esclusione` (`Genere`, `Abbonamento`)
        SELECT `Genere`.`Nome`, abb
        FROM `Genere`
        ORDER BY RAND()
        LIMIT 1;
END $$

CREATE PROCEDURE `RecensioneCasuale`(IN utente VARCHAR(100))
BEGIN
    REPLACE INTO `Recensione` (`Film`, `Utente`, `Voto`)
        SELECT `Film`.`ID`, utente, RAND() * 5
        FROM `Film`
        ORDER BY RAND()
        LIMIT 1;
END $$

DELIMITER ;