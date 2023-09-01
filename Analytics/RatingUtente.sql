USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `RatingUtente`;
DELIMITER //
CREATE PROCEDURE `RatingUtente`(
    IN id_film INT,
    IN id_utente VARCHAR(100),
    OUT rating FLOAT
)
BEGIN

    DECLARE G1 VARCHAR(50);
    DECLARE G2 VARCHAR(50);
    DECLARE A1_Nome VARCHAR(50);
    DECLARE A1_Cognome VARCHAR(50);
    DECLARE A2_Nome VARCHAR(50);
    DECLARE A2_Cognome VARCHAR(50);
    DECLARE A3_Nome VARCHAR(50);
    DECLARE A3_Cognome VARCHAR(50);
    DECLARE L1 VARCHAR(50);
    DECLARE L2 VARCHAR(50);
    DECLARE R_Nome VARCHAR(50);
    DECLARE R_Cognome VARCHAR(50);
    DECLARE RA INT;

    DECLARE G1 TINYINT;
    DECLARE G2 TINYINT;
    DECLARE A1 TINYINT;
    DECLARE A2 TINYINT;
    DECLARE A3 TINYINT;
    DECLARE L1 TINYINT;
    DECLARE L2 TINYINT;
    DECLARE R TINYINT;
    DECLARE RA TINYINT;


END
//
DELIMITER ;