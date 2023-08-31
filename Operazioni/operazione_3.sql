USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `FileMiglioreQualita`;

DELIMITER $$

CREATE PROCEDURE `FileMiglioreQualita`(IN film_id INT, OUT file_id INT)
BEGIN

    WITH
        `FileRisoluzione` AS (
            SELECT `ID`, `Risoluzione`
            FROM `Edizione`
                INNER JOIN `File` ON `Edizione`.`ID` = `File`.`Edizione`
            WHERE `Film` = film_id
        )
    SELECT f1.`ID` INTO file_id
    FROM `FileRisoluzione` f1
    WHERE `Risoluzione` = (
        SELECT MAX(f2.`Risoluzione`) FROM `FileRisoluzione` f2
    )
    LIMIT 1;

END ; $$

DELIMITER ;