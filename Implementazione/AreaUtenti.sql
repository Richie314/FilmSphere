/*!SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0*/;
/*!SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0*/;
/*!SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'*/;

CREATE DATABASE IF NOT EXISTS `FilmSphere`
    CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; 

USE `FilmSphere`;

-- ----------------------------
-- Formato
-- Contenuti
-- ----------------------------

-- ----------------------------
-- AREA UTENTE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `Utente` (
  `Codice` VARCHAR(100) NOT NULL PRIMARY KEY,
  `Nome` VARCHAR(50),
  `Cognome` VARCHAR(50),
  `Email` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(100) NOT NULL,
  `Abbonamento` VARCHAR(50),
  `DataInizioAbbonamento` DATE,
  
  CHECK( `Email` REGEXP '[A-Za-z0-9]{1,}[\.\-A-Za-z0-9]{0,}[a-zA-Z0-9]@[a-z]{1}[\.\-\_a-z0-9]{0,}\.[a-z]{1,10}')
) Engine=InnoDB;


CREATE TABLE IF NOT EXISTS `Recensione` (
  `Film` INT NOT NULL,
  `Utente` VARCHAR(100) NOT NULL, 
  `Voto` FLOAT,

  PRIMARY KEY(`Film`, `Utente`),
  FOREIGN KEY(`Film`) REFERENCES `Film` (`ID`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(`Utente`) REFERENCES `Utente` (`Codice`)
    ON UPDATE CASCADE ON DELETE CASCADE,

  CHECK(`Voto` BETWEEN 0.0 AND 5.0)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS `Connessione` (
  `Utente` VARCHAR(100) NOT NULL,
  `IP` INT(4) NOT NULL,
  `Inizio` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fine` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `Hardware` VARCHAR(128),

  PRIMARY KEY(`Utente`, `IP`, `Inizio`),
  FOREIGN KEY (`Utente`) REFERENCES `Utente` (`Codice`)
    ON UPDATE CASCADE ON DELETE CASCADE,

  CHECK (`Fine` >= `Inizio`)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS `Visualizzazione` (
    `Timestamp` TIMESTAMP NOT NULL,
    `Edizione` INT NOT NULL,
    `Utente` VARCHAR(100) NOT NULL,
    `IP` INT(4) NOT NULL,
    `InizioConnessione` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(`Timestamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`),
    FOREIGN KEY (`Utente`, `IP`, `InizioConnessione`) REFERENCES `Connessione` (`Utente`, `IP`, `Inizio`)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Edizione`) REFERENCES `Edizione` (`ID`)
      ON DELETE CASCADE ON UPDATE CASCADE
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `Abbonamento` (
    `Tipo` VARCHAR(50) NOT NULL PRIMARY KEY,
    `Tariffa` INT NOT NULL,
    `Durata` INT NOT NULL,
    `Definizione` BIGINT UNSIGNED NOT NULL,
    `Offline` BOOLEAN DEFAULT FALSE,
    `MaxOre` INT,
    `GBMensili` INT,
    CHECK (`Tariffa` >= 0),
    CHECK (`Durata` > 0),
    CHECK (`Definizione` > 0),
    CHECK (`GBMensili` > 0)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS `Esclusione` (
    `Abbonamento` VARCHAR(50) NOT NULL,
    `Genere` VARCHAR(50) NOT NULL,

    PRIMARY KEY(`Abbonamento`, `Genere`),
    FOREIGN KEY (`Abbonamento`) REFERENCES `Abbonamento` (`Tipo`)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Genere`) REFERENCES `Genere` (`Nome`)
      ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `CartaDiCredito` (
    `PAN` BIGINT NOT NULL PRIMARY KEY,
    `Scadenza` DATE,
    `CVV` SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Fattura` (
    `ID` INT NOT NULL PRIMARY KEY,
    `Utente` VARCHAR(50) NOT NULL,
    `DataEmissione` DATE,
    `DataPagamento` DATE,
    `CartaDiCredito` BIGINT NOT NULL,
    CHECK (`DataPagamento` >= `DataEmissione`)
);


/*!SET SQL_MODE=@OLD_SQL_MODE*/;
/*!SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS*/;
/*!SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS*/;
