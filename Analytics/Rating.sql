USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `RatingFilm`;
DELIMITER //
CREATE PROCEDURE `RatingFilm`(
    IN id_film INT,
    OUT rating FLOAT
)
BEGIN

    DECLARE RU FLOAT;
    DECLARE RC FLOAT;
    DECLARE PA FLOAT;
    DECLARE PR FLOAT;
    DECLARE PV FLOAT;
    DECLARE RMU FLOAT;

    SET RU := (
        SELECT
            MediaRecensioni
        FROM Film
        WHERE ID = id_film
    );

    SET RC := (
        SELECT
            AVG(Voto)
        FROM Critica
        WHERE Film = id_film
    );

    SET PA := (
        SELECT
            AVG(Popolarita)
        FROM Artista A
        INNER JOIN Recitazione R
        ON A.Nome = R.NomeAttore AND A.Cognome = R.CognomeAttore
        WHERE Film = id_film
    );

    SET PR := (
        SELECT
            Popolarita
        FROM Artista A
        INNER JOIN Film F
        ON F.NomeRegista = A.Nome AND F.CognomeRegista = A.Cognome
        WHERE ID = id_film
    );

    SET PV := (
        SELECT
            COUNT(*)
        FROM VincitaPremio
        WHERE Film = id_film
    );

    SET RMU := (
        SELECT
            MAX(F2.MediaRecensioni)
        FROM Film F1
        INNER JOIN GenereFilm GF1
        ON GF1.Film = F1.ID
        INNER JOIN GenereFilm GF2
        ON GF2.Genere = GF1.Genere
        INNER JOIN Film F2
        ON GF2.Film = F2.ID
        WHERE F1.ID = id_film
    );

    SELECT FLOOR(0.5 * (RU + RC) + 0.1 * (PA + PR) + 0.1 * PV + (RU/RMU)) / 2
    INTO rating;

END
//
DELIMITER ;