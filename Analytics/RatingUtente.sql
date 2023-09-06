USE `FilmSphere`;

DROP FUNCTION IF EXISTS `RatingUtente`;
DELIMITER //
CREATE FUNCTION `RatingUtente`(
    id_film INT,
    id_utente VARCHAR(100)
)
RETURNS FLOAT 
NOT DETERMINISTIC
READS SQL DATA
BEGIN

    -- Forse si puo' migliorare con le Temporary Table

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

    DECLARE G1_b TINYINT;
    DECLARE G2_b TINYINT;
    DECLARE A1_b TINYINT;
    DECLARE A2_b TINYINT;
    DECLARE A3_b TINYINT;
    DECLARE L1_b TINYINT;
    DECLARE L2_b TINYINT;
    DECLARE R_b TINYINT;
    DECLARE RA_b TINYINT;

    -- ------------------------
    -- Determino i Preferiti
    -- ------------------------

    -- L'idea e' di creare delle classifica come Temporary Table
    -- per poi andare a selezionare l'i-esimo preferito

    CREATE TEMPORARY TABLE GeneriClassifica
    WITH
        GenereVisualizzazioni AS (
            SELECT
                Genere,
                COUNT(*) AS N
            FROM Visualizzazione V
            INNER JOIN Edizione E
                ON E.ID = V.Edizione
            INNER JOIN GenereFilm GF
                ON GF.Film = E.Film
            WHERE V.Utente = id_utente
            GROUP BY Genere
        )
    SELECT
        Genere,
        RANK() OVER (ORDER BY N DESC, Genere) as Rk
    FROM GenereVisualizzazioni;

    SET G1 := (
        SELECT
            Genere
        FROM GeneriClassifica
        WHERE rk = 1
    );

    SET G2 := (
        SELECT
            Genere
        FROM GeneriClassifica
        WHERE rk = 2
    );

    CREATE TEMPORARY TABLE AttoriClassifica
        WITH
            AttoriVisualizzazioni AS (
                SELECT
                    R.NomeAttore,
                    R.CognomeAttore,
                    COUNT(*) AS N
                FROM Visualizzazione V
                INNER JOIN Edizione E
                    ON E.ID = V.Edizione
                INNER JOIN Recitazione R
                    ON R.Film = E.Film
                WHERE V.Utente = id_utente
                GROUP BY R.NomeAttore, R.CognomeAttore
            )
        SELECT
            NomeAttore, CognomeAttore,
            RANK() OVER(ORDER BY N DESC, NomeAttore, CognomeAttore) AS rk
        FROM AttoriVisualizzazioni;

    SET A1_Nome := (
        SELECT
            NomeAttore
        FROM AttoriClassifica
        WHERE rk = 1
    );

    SET A1_Cognome := (
        SELECT
            CognomeAttore
        FROM AttoriClassifica
        WHERE rk = 1
    );

    SET A2_Nome := (
        SELECT
            NomeAttore
        FROM AttoriClassifica
        WHERE rk = 2
    );

    SET A2_Cognome := (
        SELECT
            CognomeAttore
        FROM AttoriClassifica
        WHERE rk = 2
    );

    SET A3_Nome := (
        SELECT
            NomeAttore
        FROM AttoriClassifica
        WHERE rk = 3
    );

    SET A3_Cognome := (
        SELECT
            CognomeAttore
        FROM AttoriClassifica
        WHERE rk = 3
    );

    CREATE TEMPORARY TABLE LinguaClassifica
        WITH
            LinguaVisualizzazioni AS (
                SELECT
                    D.Lingua,
                    COUNT(*) AS N
                FROM Visualizzazione V
                INNER JOIN File F
                    ON F.Edizione = V.Edizione
                INNER JOIN Doppiaggio D
                    ON D.File = F.ID
                WHERE V.Utente = id_utente
                GROUP BY D.Lingua
            )
        SELECT
            Lingua,
            RANK() OVER(ORDER BY N DESC, Lingua) AS rk
        FROM LinguaVisualizzazioni;

    SET L1 := (
        SELECT
            Lingua
        FROM LinguaClassifica
        WHERE rk = 1
    );

    SET L2 := (
        SELECT
            Lingua
        FROM LinguaClassifica
        WHERE rk = 2
    );

    CREATE TEMPORARY TABLE RegistaUtente
        WITH
            RegistaVisualizzazioni AS (
                SELECT
                    F.NomeRegista,
                    F.CognomeRegista,
                    COUNT(*) AS N
                FROM Visualizzazione V
                INNER JOIN Edizione E
                    ON V.Edizione = E.ID
                INNER JOIN Film F
                    ON F.ID = E.Film
                WHERE V.Utente = id_utente
                GROUP BY F.NomeRegista, F.CognomeRegista
            )
        SELECT
            NomeRegista,
            CognomeRegista
        FROM RegistaVisualizzazioni
        ORDER BY N DESC, CognomeRegista, NomeRegista
        LIMIT 1;

    SET R_Nome := (
        SELECT NomeRegista
        FROM RegistaUtente
    );

    SET R_Cognome := (
        SELECT NomeRegista
        FROM RegistaUtente
    );

    SET RA := (
        WITH
            RapportoAspettoVisualizzazioni AS (
                SELECT
                    E.RapportoAspetto,
                    COUNT(*) AS N
                FROM Visualizzazione V
                INNER JOIN Edizione E
                    ON E.ID = V.Edizione
                WHERE V.Utente = id_utente
                GROUP BY E.RapportoAspetto
            )
        SELECT
            RapportoAspetto
        FROM RapportoAspettoVisualizzazioni
        ORDER BY N DESC, RapportoAspetto
        LIMIT 1
    );


    -- -------------------------------
    -- Determino i Valori Booleani
    -- -------------------------------

    -- L'idea e' di creare delle Temporay Table contenente i vari parametri di interesse del
    -- film (e.g. Generi) per poi andare a determinare quali preferenze sono soddisfatte

    CREATE TEMPORARY TABLE GeneriFilm
        SELECT Genere
        FROM GenereFilm
        WHERE Film = id_film;

    CREATE TEMPORARY TABLE AttoriFilm
        SELECT
            NomeAttore,
            CognomeAttore
        FROM Recitazione
        WHERE Film = id_film;

    CREATE TEMPORARY TABLE LingueFilm
        SELECT DISTINCT
            D.Lingua
        FROM Edizione E
        INNER JOIN File F
            ON F.Edizione = E.ID
        INNER JOIN Doppiaggio D
            ON D.File = F.ID
        WHERE E.Film = id_film;

    SET G1_b = (
        SELECT COUNT(*)
        FROM GeneriFilm
        WHERE Genere = G1
    );

    SET G2_b = (
        SELECT COUNT(*)
        FROM GeneriFilm
        WHERE Genere = G2
    );

    SET A1_b = (
        SELECT COUNT(*)
        FROM AttoriFilm
        WHERE NomeAttore = A1_Nome
        AND CognomeAttore = A1_Cognome
    );

    SET A2_b = (
        SELECT COUNT(*)
        FROM AttoriFilm
        WHERE NomeAttore = A2_Nome
        AND CognomeAttore = A2_Cognome
    );

    SET A3_b = (
        SELECT COUNT(*)
        FROM AttoriFilm
        WHERE NomeAttore = A3_Nome
        AND CognomeAttore = A3_Cognome
    );

    SET L1_b = (
        SELECT COUNT(*)
        FROM LingueFilm
        WHERE Lingua = L1
    );

    SET L2_b = (
        SELECT COUNT(*)
        FROM LingueFilm
        WHERE Lingua = L2
    );

    SET R_b = (
        SELECT COUNT(*)
        FROM Film
        WHERE ID = id_film
        AND NomeRegista = R_Nome
        AND CognomeRegista = R_Cognome
    );

    SET RA_b = (
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT
                RapportoAspetto
            FROM Edizione
            WHERE Film = id_film
        ) AS T
    );

    RETURN FLOOR(2 * G1_b + G2_b + 1.5 * A1_b + A2_b + 0.5 * A3_b + L1_b + L2_b + R_b + RA_b) / 2;

END
//
DELIMITER ;