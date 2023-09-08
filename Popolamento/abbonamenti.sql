REPLACE INTO `Abbonamento`(`Tipo`, `Tariffa`, `Durata`, `Definizione`, `Offline`, `MaxOre`, `GBMensili`) VALUES
('Basic', 5.99, 30, 1080, FALSE, 8, 32),
('Premium', 9.99, 30, 2160, FALSE, 8, 96),
('Pro', 13.49, 30, 4096, FALSE, 28, 0),
('Deluxe', 24.99, 60, 4096, FALSE, 28, 0),
('Ultimate', 39.99, 90, 16384, TRUE, 28, 0);

CALL `EsclusioneCasuale`('Basic');

CALL `EsclusioneCasuale`('Premium');
CALL `EsclusioneCasuale`('Premium');