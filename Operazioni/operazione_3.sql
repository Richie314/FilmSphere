USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `Operazione3`;
DELIMITER //
CREATE PROCEDURE `Operazione3`(IN film_id INT)
BEGIN

    -- Decidiamo come gestire i pari merito
    -- Decidiamo se "ritornare" una tabella o un valore in output

    WITH
        `FileRisoluzione` AS (
            SELECT `ID`, `Risoluzione`
            FROM `Edizione`
            INNER JOIN `File`
            ON `Edizione`.`ID` = `File`.`Edizione`
            WHERE `Film` = film_id
        )
    SELECT ID
    FROM `FileRisoluzione`
    WHERE `Risoluzione` = (
        SELECT MAX(`Risoluzione`) FROM `FileRisoluzione`
    );

END
//
DELIMITER ;

