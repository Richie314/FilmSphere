USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `FilmEsclusiAbbonamento`;

DELIMITER //

CREATE PROCEDURE `FilmEsclusiAbbonamento`(
    IN TipoAbbonamento VARCHAR(50),
    OUT NumeroFilm INT)
BEGIN

    SELECT COUNT(*) INTO NumeroFilm
    FROM `Esclusione` E
        INNER JOIN `GenereFilm` GF ON GF.Genere = E.Genere
    WHERE E.`Abbonamento` = TipoAbbonamento;

    -- Film con solo alta qualita'???

END ; //

DELIMITER ;