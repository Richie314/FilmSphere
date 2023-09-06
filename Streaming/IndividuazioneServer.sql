USE `FilmSphere`;

DROP PROCEDURE IF EXISTS `MigliorServer`;
DROP FUNCTION IF EXISTS `MathMap`;
DROP FUNCTION IF EXISTS `StrListContains`;

DELIMITER $$

CREATE PROCEDURE `MigliorServer` (
    IN id_utente VARCHAR(100),
    IN id_edizione INT,
    IN ip_connessione INT,
    IN inizio_connessione TIMESTAMP,
    
    IN MaxBitRate FLOAT,
    IN MaxRisoluz BIGINT,

    IN AcceptedVideoEncodings VARCHAR(256),
    IN AcceptedAudioEncodings VARCHAR(256)

    OUT FileID INT,
    OUT ServerID INT
)
BEGIN
    DECLARE paese_utente CHAR(2) DEFAULT '??';
    DECLARE abbonamento_utente VARCHAR(50) DEFAULT NULL;
    DECLARE max_definizione BIGINT DEFAULT NULL;
    DECLARE wRis FLOAT DEFAULT 5;
    DECLARE wRate FLOAT DEFAULT 3;
    DECLARE wPos FLOAT DEFAULT 12;
    DECLARE wCarico FLOAT DEFAULT 10;

    IF id_utente IS NULL OR id_edizione IS NULL THEN
         SIGNAL SQLSTATE 45000 
            SET MESSAGE_TEXT = 'Parametri NULL non consentiti';
    END IF;


    SELECT A.`Tipo`, A.`Definizione`
        INTO abbonamento_utente, MaxDefinizione
    FROM `Abbonamento` A
        INNER JOIN `Utente` ON `Utente`.`Abbonamento` = A.`Tipo`
    WHERE A.`Codice` = id_utente;

    IF abbonamento_utente IS NULL THEN
         SIGNAL SQLSTATE 45000 
            SET MESSAGE_TEXT = 'Utente non trovato';
    END IF;

    IF EXISTS (
        SELECT *
        FROM `Esclusione`
            INNER JOIN `GenereFilm` USING (`Genere`)
            INNER JOIN `Edizone` USING (`Film`)
        WHERE `ID` = id_edizione AND `Abbonamento` = abbonamento_utente) THEN
        
        SIGNAL SQLSTATE 45000
            SET MESSAGE_TEXT = 'Contenuto non disponibile nel tuo piano di abbonamento!';
    END IF;

    -- Calcolo il Paese dai Range
    SET paese_utente = Ip2Paese(ip_connessione);

    IF EXISTS (
        SELECT *
        FROM `Restrizione` r
        WHERE r.`Edizione` = id_edizione AND r.`Paese` = paese_utente) THEN
        
        SIGNAL SQLSTATE 45000
            SET MESSAGE_TEXT = 'Contenuto non disponibile nella tua regione!';
    END IF;

    -- Prima di calcolare il Server migliore individuo le caratteristiche che deve avere il File
    IF max_definizione IS NOT NULL THEN
        max_definizione = LEAST(max_definizione, MaxDefinizione);
    END IF;

    WITH `FileDisponibili` AS (
        SELECT 
            F.`ID`, 
            CalcolaDelta(max_definizione, F.`Risoluzione`) AS "DeltaRis", 
            CalcolaDelta(MaxBitRate, F.`BitRate`) AS "DeltaRate"
        FROM `File` F
            INNER JOIN Edizione E ON E.`ID` = F.`Edizione`
        WHERE 
            E.`ID` = id_edizione AND 
            StrListContains(AcceptedAudioEncodings, F.`FamigliaAudio`) AND
            StrListContains(AcceptedVideoEncodings, F.`FamigliaVideo`)
    ), `FileServerScore` AS (
        SELECT 
            F.`ID`,
            D.`Server`,
            MathMap(F.`DeltaRis`, 0.0, MAX_RIS, 0, wRis) AS "ScoreRis",
            MathMap(F.`DeltaRate`, 0.0, MAX_RATE, 0, wRate) AS "ScoreRate",
            MathMap(D.`ValoreDistanza`, 0.0, MAX_DIST, 0, wPos) AS "ScoreDistanza",
            MathMap(S.`CaricoAttuale`, 0.0, S.`MaxConnessioni`, 0, wCarico) AS "ScoreCarico"
        FROM `FileDisponibili` F
            INNER JOIN `PoP` P ON P.`File` = F.`ID`
            INNER JOIN `DistanzaPrecalcolata` D USING(`Server`)
            INNER JOIN `Server` S ON `Server`.`ID` = P.`Server`
        WHERE D.`Paese` = paese_utente
    ), `Scelta` AS (
        SELECT 
            F.`ID`, f.`Server`,
            (F.ScoreRis + F.ScoreRate + F.ScoreDistanza + F.ScoreCarico) AS "Score"
        FROM `FileServerScore` F
        ORDER BY "Score" DESC
        LIMIT 1
    )
    SELECT S.ID, F.Server INTO FileID, ServerID
    FROM `Scelta` S;
END $$

CREATE FUNCTION `MathMap`(
    X FLOAT,
    inMin FLOAT,
    inMax FLOAT,
    outMin FLOAT,
    outMax FLOAT
)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN outMin + (outMax - outMin) * (x - inMin) / (inMax - inMin);
END $$

CREATE FUNCTION `CalcolaDelta`(
    Max FLOAT,
    Valore FLOAT
)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN IF (
        Max > Valore,
        Max - Valore,
        2.0 * (Valore - Max)
    );
END $$

CREATE FUNCTION `StrListContains` (
    `Pagliaio` VARCHAR(256)
    `Ago` VARCHAR(10)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE PagliaioRidotto VARCHAR(256);
    SET PagliaioRidotto = Pagliaio;

    WHILE PagliaioRidotto <> '' DO

        IF TRIM(LOWER(SUBSTRING_INDEX(PagliaioRidotto, ',', 1))) = TRIM(LOWER(`Ago`)) THEN
            -- Ignoro gli spazi e il CASE della stringa: gli spazi creare dei falsi negativi, 
            -- mentre la stringa Ago potrebbe venire inviata con case dipendenti dalla piattaforma del client
            RETURN TRUE;
        END IF;
        
        
        
        IF LOCATE(',', PagliaioRidotto) > 0 THEN
            SET PagliaioRidotto = SUBSTRING(PagliaioRidotto, LOCATE(',', PagliaioRidotto) + 1);
        ELSE
            SET PagliaioRidotto = '';
        END IF;
    END WHILE;

    RETURNS FALSE;
END $$
DELIMITER ;