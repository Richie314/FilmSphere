USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `Operazione2`;
DELIMITER //
CREATE PROCEDURE `Operazione2`(IN film_id INT)
BEGIN

    SELECT `Genere`
    FROM `GenereFilm`
    WHERE `Film` = film_id;

END
//
DELIMITER ;

CALL Operazione1(1);