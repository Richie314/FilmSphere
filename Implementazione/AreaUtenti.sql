/*!SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0*/;
/*!SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0*/;
/*!SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'*/;


-- ----------------------------
-- Formato
-- Contenuti
-- ----------------------------

-- ----------------------------
-- AREA UTENTE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Utente` (
  `Codice` VARCHAR(100) NOT NULL,
  `Nome` VARCHAR(50),
  `Cognome` VARCHAR(50),
  `Email` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(100) NOT NULL,
  `Abbonamento` VARCHAR(50),
  `DataInizioAbbonamento` DATE,
  PRIMARY KEY(`Codice`),
  CHECK( `Email` REGEXP '[A-Za-z0-9]{1,}[\.\-A-Za-z0-9]{0,}[a-zA-Z0-9]@[a-z]{1}[\.\-\_a-z0-9]{0,}\.[a-z]{1,10}')
) Engine = InnoDB;


CREATE TABLE IF NOT EXISTS `FilmSphere`.`Recensione` (
  `Utente` INT NOT NULL, -- Aggiungi Fk
  `Film` INT NOT NULL,
  `Voto` FLOAT,
  PRIMARY KEY(`Utente`, `Film`),
  CHECK(`Voto` >= 0 AND `Voto` <= 5),
  FOREIGN KEY(`Film`)
  REFERENCES `FilmSphere`.`Film` (`ID`)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(`Utente`)
  REFERENCES `FilmSphere`.`Utente` (`Codice`)
  ON UPDATE CASCADE
  ON DELETE CASCADE
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Connessione` (
  `Utente` VARCHAR(100) NOT NULL,
  `IP` INT(4) NOT NULL,
  `Inizio` TIMESTAMP NOT NULL,
  `Fine` TIMESTAMP,
  `Hardware` VARCHAR(128),
  PRIMARY KEY(`Utente`, `IP`, `Inizio`),
  FOREIGN KEY (`Utente`)
  REFERENCES `FilmSphere`.`Utente` (`Codice`)
  ON UPDATE CASCADE
  ON DELETE CASCADE
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Visualizzazione` (
    `Timestamp` TIMESTAMP NOT NULL,
    `Edizione` INT NOT NULL,
    `Utente` NVARCHAR(100) NOT NULL,
    `IP` INT(4) NOT NULL,
    `InizioConnessione` TIMESTAMP NOT NULL,
    PRIMARY KEY(`Timestamp`, `Edizione`, `Utente`, `IP`, `InizioConnessione`),
    FOREIGN KEY (`Utente`, `IP`, `InizioConnessione`)
    REFERENCES `FilmSphere`.`Connessione` (`Utente`, `IP`, `Inizio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`Edizione`)
    REFERENCES `FilmSphere`.`Edizione` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Abbonamento` (
    `Tipo` VARCHAR(50) NOT NULL,
    `Tariffa` INT NOT NULL,
    `Durata` INT NOT NULL,
    `Definizione` BIGINT UNSIGNED NOT NULL,
    `Offline` BOOLEAN,
    `MaxOre` INT,
    `GBMensili` INT,
    PRIMARY KEY(`Tipo`),
    CHECK (
        `Tariffa` >= 0 AND
        `Durata` > 0 AND
        `Definizione` > 0 AND
        `MaxOre` > 0 AND
        `GBMensili` > 0
    )
) Engine = InnoDB;

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Esclusione` (
    `Abbonamento` VARCHAR(50) NOT NULL,
    `Genere` VARCHAR(50) NOT NULL,
    PRIMARY KEY(`Abbonamento`, `Genere`),
    FOREIGN KEY (`Abbonamento`)
    REFERENCES `FilmSphere`.`Abbonamento` (`Tipo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`Genere`)
    REFERENCES `FilmSphere`.`Genere` (`Nome`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `FilmSphere`.`CartaDiCredito` (
    `PAN` BIGINT NOT NULL,
    `Scadenza` DATE,
    `CVV` SMALLINT NOT NULL,
    PRIMARY KEY(`PAN`)
);

CREATE TABLE IF NOT EXISTS `FilmSphere`.`Fattura` (
    `ID` INT NOT NULL,
    `Utente` VARCHAR(50) NOT NULL,
    `DataEmissione` DATE,
    `DataPagamento` DATE,
    `CartaDiCredito` BIGINT NOT NULL,
    PRIMARY KEY (`ID`)
);


/*!SET SQL_MODE=@OLD_SQL_MODE*/;
/*!SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS*/;
/*!SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS*/;
