-- Temporarily Disabling Unique and Foreign Key Checking will make Data Manipulation faster at the cost of integrity
-- Ho usato dei commenti "speciali", il loro contenuto viene eseguito solo le script runna su MySql (o almeno credo) (https://dev.mysql.com/doc/refman/8.1/en/comments.html)
-- Le Modalita' di Default di MySQL sono ONLY_FULL_GROUP_BY, STRICT_TRANS_TABLES, NO_ZERO_IN_DATE, NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO and NO_ENGINE_SUBSTITUTION.
-- Non so perche' Tau e Trains non vogliano ONLY_FULL_GROUP_BY (https://dev.mysql.com/doc/refman/8.1/en/sql-mode.html#sqlmode_strict_trans_tables)

/*!SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0*/;
/*!SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0*/;
/*!SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'*/;

-- -----------------------------
-- CREAZIONE DATABASE
-- -----------------------------
DROP DATABASE IF EXISTS `FilmSphere`; -- Riccardo, Simone
CREATE DATABASE IF NOT EXISTS `FilmSphere`
CHARACTER SET utf8mb4           -- UNICODE UTF-8 USED (https://dev.mysql.com/doc/refman/8.0/en/charset.html)
COLLATE utf8mb4_0900_ai_ci;     -- COLLATION selected (How characters are sorted)

-- ----------------------------
-- FK
-- ----------------------------

-- ----------------------------
-- AREA CONTENUTI
-- ----------------------------

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Paese` (
  `Codice` CHAR(2) NOT NULL,
  `Nome` VARCHAR(50),
  `Posizione` POINT,
  PRIMARY KEY(`Codice`)
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Artista` (
  `Nome` VARCHAR(50) NOT NULL,
  `Cognome` VARCHAR(50) NOT NULL,
  `Popolarita` FLOAT,    
  PRIMARY KEY(`Nome`, `Cognome`),
  CHECK(Popolarita >= 0 AND Popolarita <= 10)
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`CasaProduzione` (
  `Nome` VARCHAR(50) NOT NULL,
  `Paese` CHAR(2),
  PRIMARY KEY(`Nome`),
  FOREIGN KEY (`Paese`)
  REFERENCES `FilmSphere`.`Paese` (`Codice`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
) Engine = InnoDB;


CREATE TABLE IF NOT EXISTS `FilmSphere`.`Film` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Titolo` VARCHAR(100),
  `Descrizione` VARCHAR(500),
  `Anno` YEAR,
  `CasaProduzione` VARCHAR(50) NOT NULL,  
  `NomeRegista` VARCHAR(50) NOT NULL, 
  `CognomeRegista` VARCHAR(50) NOT NULL,  
  `MediaRecensioni` FLOAT,
  `NumeroRecensioni` INT,
  PRIMARY KEY (`ID`),
  CHECK(`MediaRecensioni` >= 0 AND `MediaRecensioni` <= 5),
  CHECK(`NumeroRecensioni` >= 0),
  FOREIGN KEY (`CasaProduzione`)
  REFERENCES `FilmSphere`.`CasaProduzione` (`Nome`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (`NomeRegista`, `CognomeRegista`)
  REFERENCES `FilmSphere`.`Artista` (`Nome`, `Cognome`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`VincitaPremio` (
  `Macrotipo` VARCHAR(50) NOT NULL,
  `Microtipo` VARCHAR(50) NOT NULL,
  `Data` DATE NOT NULL,
  `Film` INT NOT NULL,
  `NomeArtista` VARCHAR(50),
  `CognomeArtista` VARCHAR(50),
  PRIMARY KEY(`Macrotipo`, `Microtipo`, `Data`),
  FOREIGN KEY(`Film`)
  REFERENCES `FilmSphere`.`Film` (`ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY(`NomeArtista`, `CognomeArtista`)
  REFERENCES `FilmSphere`.`Artista` (`Nome`, `Cognome`)
  ON UPDATE CASCADE 
  ON DELETE CASCADE 
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Recitazione` (
  `Film` INT NOT NULL,
  `NomeAttore` VARCHAR(50) NOT NULL,
  `CognomeAttore` VARCHAR(50) NOT NULL,
  PRIMARY KEY(`Film`, `NomeAttore`, `CognomeAttore`),
  FOREIGN KEY(`Film`)
  REFERENCES `FilmSphere`.`Film` (`ID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY(`NomeAttore`, `CognomeAttore`)
  REFERENCES `FilmSphere`.`Artista` (`Nome`, `Cognome`)
  ON UPDATE CASCADE 
  ON DELETE CASCADE 
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Critico` (
  `Codice` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50),
  `Cognome` VARCHAR(50),
  PRIMARY KEY(`Codice`)
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Critica` (
  `Critico` INT NOT NULL,
  `Film` INT NOT NULL,
  `Testo` VARCHAR(500),
  `Data` DATE,
  `Voto` FLOAT,
  PRIMARY KEY(`Critico`, `Film`),
  FOREIGN KEY(`Film`)
  REFERENCES `FilmSphere`.`Film` (`ID`)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(`Critico`)
  REFERENCES `FilmSphere`.`Critico` (`Codice`)
  ON UPDATE CASCADE 
  ON DELETE CASCADE, 
  CHECK(`Voto` >= 0 AND `Voto` <= 5)
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Genere` (
  `Nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY(`Nome`)
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`GenereFilm` (
  `Genere` VARCHAR(50) NOT NULL,
  `Film` INT NOT NULL,
  PRIMARY KEY(`Genere`, `Film`),
  FOREIGN KEY(`Film`)
  REFERENCES `FilmSphere`.`Film` (`ID`)
  ON UPDATE CASCADE 
  ON DELETE CASCADE,
  FOREIGN KEY(`Genere`)
  REFERENCES `FilmSphere`.`Genere` (`Nome`)
  ON UPDATE CASCADE 
  ON DELETE CASCADE 
) Engine = InnoDB;


/*!SET SQL_MODE=@OLD_SQL_MODE*/;
/*!SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS*/;
/*!SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS*/;

