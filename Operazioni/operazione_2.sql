USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `Operazione2`;
DELIMITER //
CREATE PROCEDURE `Operazione2`(IN film_id INT, IN codice_utente VARCHAR(100))
BEGIN

    DECLARE lista_generi VARCHAR(400);
    DECLARE generi_disabilitati INT;

    SET lista_generi := (
        SELECT
            GROUP_CONCAT(`Genere`)
        FROM `GenereFilm`
        WHERE `Film` = film_id
        GROUP BY `Film`
    );

    SET generi_disabilitati := (
        SELECT
            COUNT(*)
        FROM GenereFilm GF
        INNER JOIN Esclusione E
        USING(Genere)
        INNER JOIN Utente U
        USING (Abbonamento)
        WHERE U.Codice = Codice
        AND GF.Film = film_id
    );

    IF generi_disabilitati > 0 THEN
        SELECT lista_generi, 'Non Abilitato' AS Abilitazione;
    ELSE
        SELECT lista_generi, 'Abilitato' AS Abilitazione;
    END IF;

END
//
DELIMITER ;

CALL Operazione1(1);