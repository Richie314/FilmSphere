USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `Operazione4`;
DELIMITER //
CREATE PROCEDURE `Operazione4`(IN tipo_abbonamento VARCHAR(50))
BEGIN

    -- Decidiamo se "ritornare" una tabella o un valore in output

    SELECT COUNT(*)
    FROM Esclusione E
    INNER JOIN GenereFilm GF
    ON GF.Genere = E.Genere
    WHERE E.Abbonamento = tipo_abbonamento;

END
//
DELIMITER ;