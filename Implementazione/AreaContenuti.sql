-- Temporarily Disabling Unique and Foreign Key Checking will make Data Manipulation faster at the cost of integrity
-- Ho usato dei commenti "speciali", il loro contenuto viene eseguito solo le script runna su MySql (o almeno credo) (https://dev.mysql.com/doc/refman/8.1/en/comments.html)
-- Le Modalita' di Default di MySQL sono ONLY_FULL_GROUP_BY, STRICT_TRANS_TABLES, NO_ZERO_IN_DATE, NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO and NO_ENGINE_SUBSTITUTION.
-- Non so perche' Tau e Trains non vogliano ONLY_FULL_GROUP_BY (https://dev.mysql.com/doc/refman/8.1/en/sql-mode.html#sqlmode_strict_trans_tables)

/*!SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0*/;
/*!SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0*/;
/*!SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'*/;

DROP DATABASE IF EXISTS `RS`; -- Riccardo, Simone
CREATE DATABASE IF NOT EXISTS `RS`
CHARACTER SET utf8mb4           -- UNICODE UTF-8 USED (https://dev.mysql.com/doc/refman/8.0/en/charset.html)
COLLATE utf8mb4_0900_ai_ci;     -- COLLATION selected (How characters are sorted)


/*!SET SQL_MODE=@OLD_SQL_MODE*/;
/*!SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS*/;
/*!SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS*/;
