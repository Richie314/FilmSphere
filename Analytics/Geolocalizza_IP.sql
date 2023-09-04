USE `FilmSphere`;

DROP FUNCTION IF EXISTS `GeolocalizzaIP`;
DELIMITER //
CREATE FUNCTION IF NOT EXISTS `GeolocalizzaIP`(
    `IP` INT(4) UNSIGNED,
    `Data` TIMESTAMP
)
RETURNS CHAR(2) DETERMINISTIC
BEGIN

    /*
     *    \/\/\/\/\/\/\/
     *  > Vai Richie314 <
     *    /\/\/\/\/\/\/\
     */

    RETURN '??';

END //