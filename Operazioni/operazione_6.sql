USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `FilmPiuVistiRecentemente`;
DELIMITER //
CREATE PROCEDURE `FilmPiuVistiRecentemente`(IN numero_film INT)
BEGIN

    WITH
        TitoloVisualizzazione AS (
            SELECT
                F.Titolo,
                COUNT(*) Visualizzazioni
            FROM Visualizzazione V
            INNER JOIN Edizione E
                ON E.ID = V.Edizione
            INNER JOIN Film F
                ON F.ID = E.Film
            GROUP BY F.Titolo
        )
    SELECT
        Titolo
    FROM TitoloVisualizzazione
    ORDER BY Visualizzazioni DESC,
        Titolo ASC
    LIMIT numero_film;

END
//
DELIMITER ;