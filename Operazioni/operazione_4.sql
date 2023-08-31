USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `FilmEsclusiAbbonamento`;

DELIMITER //

CREATE PROCEDURE `FilmEsclusiAbbonamento`(
    IN TipoAbbonamento VARCHAR(50),
    OUT NumeroFilm INT)
BEGIN

    -- Film esclusi perche' il genere e' escluso
    WITH `FilmEsclusiGenere` AS (
        SELECT DISTINCT GF.`Film`
        FROM `Esclusione` E
            INNER JOIN `GenereFilm` GF USING(`Genere`)
        WHERE E.`Abbonamento` = TipoAbbonamento
    ), 
    
    `FileVisualizzabili` AS (
        SELECT F.`ID`, F.`Edizione`
        FROM `File` F
            INNER JOIN `Abbonamento` A ON A.`Definizione` IS NULL OR A.`Definizione` > F.`Risoluzione`
        WHERE A.`ID` = TipoAbbonamento
    ), 
    -- Film esclusi perche' presenti solo in qualita' maggiore dalla massima disponibile con l'abbonamento
    `FilmEsclusiRisoluzione` AS (
        SELECT DISTINCT F.`ID` AS "Film"
        FROM `Film` F
            INNER JOIN `Edizione` E ON E.`Film` = F.`ID`
        WHERE NOT EXISTS (
            SELECT *
            FROM `FileVisualizzabili` 
            WHERE `FileVisualizzabili`.`Edizione` = E.`ID`
        )
    )
    -- UNION senza ALL rimuovera' in automatico gli ID duplicati
    SELECT COUNT(*) INTO NumeroFilm
    FROM (
        SELECT * FROM `FilmEsclusiGenere`

        UNION

        SELECT * FROM `FilmEsclusiRisoluzione`
    );
END ; //

DELIMITER ;