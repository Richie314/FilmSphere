USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `Operazione1`;
DELIMITER //
CREATE PROCEDURE `Operazione1`(IN film_id INT)
BEGIN

    SELECT `Macrotipo`, `Microtipo`, `Data`
    FROM `VincitaPremio`
    WHERE `Film` = film_id;

END
//
DELIMITER ;

CALL Operazione1(1);
