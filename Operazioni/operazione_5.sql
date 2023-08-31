USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `Operazione5`;
DELIMITER //
CREATE PROCEDURE `Operazione5`(IN lingua VARCHAR(50))
BEGIN


    SELECT DISTINCT
        FI.ID, FI.Titolo
    FROM Doppiaggio D
    INNER JOIN File F ON D.File = F.ID
    INNER JOIN Edizione E ON E.ID = F.Edizione
    INNER JOIN Film FI ON FI.ID = E.Film
    WHERE D.Lingua = lingua;

END
//
DELIMITER ;