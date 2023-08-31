USE `FilmSphere`;

CREATE OR REPLACE VIEW `FilmMiglioriRecensioni` AS
    SELECT f.`Titolo`, f.`ID`, f.`MediaRecensoni`
    FROM `Film` f
    WHERE f.`MediaRecensioni` > (
        SELECT AVG(f2.`MediaRecensoni`)
        FROM `Film` f2)
    ORDER BY f.`MediaRecensoni` DESC
    LIMIT 20;
    
-- SELECT * FROM `FilmMiglioriRecensioni`;