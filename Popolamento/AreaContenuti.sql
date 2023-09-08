USE `FilmSphere`;

REPLACE INTO Lingua
VALUES ('Afrikaans'),
       ('Albanese'),
       ('Arabo'),
       ('Armeno'),
       ('Bielorusso'),
       ('Bislamo'),
       ('Bodo'),
       ('Bosniaco'),
       ('Bulgaro'),
       ('Caroliniano'),
       ('Catalano'),
       ('Ceco'),
       ('Chamorro'),
       ('Chichewa'),
       ('Chuukese'),
       ('Comoriano'),
       ('Coreano'),
       ('Creolo'),
       ('Croato'),
       ('Curdo'),
       ('Danese'),
       ('Ebraico'),
       ('Estone'),
       ('Faroese'),
       ('Figiano'),
       ('Filippino'),
       ('Finlandese'),
       ('Francese'),
       ('Georgiano'),
       ('Giapponese'),
       ('Giavanese'),
       ('Gilbertese'),
       ('Greco'),
       ('Groenlandese'),
       ('Guaraní'),
       ('Gujarati'),
       ('Hawaiano'),
       ('Hindi'),
       ('Indonesiano'),
       ('Inglese'),
       ('Irlandese'),
       ('Islandese'),
       ('Italiano'),
       ('Kannada'),
       ('Kashmiri'),
       ('Kosraese'),
       ('Ladino'),
       ('Lao'),
       ('Latino'),
       ('Lettone'),
       ('Lituano'),
       ('Lussemburghese'),
       ('Macedone'),
       ('Maithili'),
       ('Malayalam'),
       ('Malese'),
       ('Malgascio'),
       ('Maltese'),
       ('Mandarino'),
       ('Manipuri'),
       ('Maori'),
       ('Marathi'),
       ('Marshallese'),
       ('Mirandese'),
       ('Moldavo'),
       ('Monegasco'),
       ('Mongolo'),
       ('Nauruana'),
       ('Nepalese'),
       ('Norvegese'),
       ('Occitano'),
       ('Olandese'),
       ('Oriya'),
       ('Pashto'),
       ('Palauano'),
       ('Papiamento'),
       ('Persiano'),
       ('Pohnpeiano'),
       ('Polacco'),
       ('Portoghese'),
       ('Punjabi'),
       ('Romancio'),
       ('Romaní'),
       ('Rumeno'),
       ('Russo'),
       ('Ruteno'),
       ('Shona'),
       ('Somalo'),
       ('Sindhi'),
       ('Singalese'),
       ('Slovacco'),
       ('Spagnolo'),
       ('Svedese'),
       ('Swahili'),
       ('Tamil'),
       ('Tataro'),
       ('Tedesco'),
       ('Telugu'),
       ('Tetum'),
       ('Thai'),
       ('Tosco'),
       ('Tsonga'),
       ('Tswana'),
       ('Turco'),
       ('Turkmeno'),
       ('Ucraino'),
       ('Ungherese'),
       ('Urdu'),
       ('Uzbeko'),
       ('Venda'),
       ('Xhosa'),
       ('Yapese'),
       ('Yiddish'),
       ('Yorube'),
       ('Yue'),
       ('Zulu');



REPLACE INTO Paese VALUES
('AD', 'Andorra', POINT(1.601554,42.546245)),
('AE', 'United Arab Emirates', POINT(53.847818,23.424076)),
('AF', 'Afghanistan', POINT(67.709953,33.93911)),
('AG', 'Antigua and Barbuda', POINT(-61.796428,17.060816)),
('AI', 'Anguilla', POINT(-63.068615,18.220554)),
('AL', 'Albania', POINT(20.168331,41.153332)),
('AM', 'Armenia', POINT(45.038189,40.069099)),
('AO', 'Angola', POINT(17.873887,-11.202692)),
('AQ', 'Antarctica', POINT(-0.071389,-75.250973)),
('AR', 'Argentina', POINT(-63.616672,-38.416097)),
('AT', 'Austria', POINT(14.550072,47.516231)),
('AU', 'Australia', POINT(133.775136,-25.274398)),
('AZ', 'Azerbaijan', POINT(47.576927,40.143105)),
('BA', 'Bosnia and Herzegovina', POINT(17.679076,43.915886)),
('BB', 'Barbados', POINT(-59.543198,13.193887)),
('BD', 'Bangladesh', POINT(90.356331,23.684994)),
('BE', 'Belgium', POINT(4.469936,50.503887)),
('BF', 'Burkina Faso', POINT(-1.561593,12.238333)),
('BG', 'Bulgaria', POINT(25.48583,42.733883)),
('BO', 'Bolivia', POINT(-63.588653,-16.290154)),
('BR', 'Brazil', POINT(-51.92528,-14.235004)),
('BS', 'Bahamas', POINT(-77.39628,25.03428)),
('BT', 'Bhutan', POINT(90.433601,27.514162)),
('BV', 'Bouvet Island', POINT(3.413194,-54.423199)),
('BW', 'Botswana', POINT(24.684866,-22.328474)),
('BY', 'Belarus', POINT(27.953389,53.709807)),
('BZ', 'Belize', POINT(-88.49765,17.189877)),
('CA', 'Canada', POINT(-106.346771,56.130366)),
('CF', 'Central African Republic', POINT(20.939444,6.611111)),
('CH', 'Switzerland', POINT(8.227512,46.818188)),
('CK', 'Cook Islands', POINT(-159.777671,-21.236736)),
('CL', 'Chile', POINT(-71.542969,-35.675147)),
('CM', 'Cameroon', POINT(12.354722,7.369722)),
('CN', 'China', POINT(104.195397,35.86166)),
('CO', 'Colombia', POINT(-74.297333,4.570868)),
('CR', 'Costa Rica', POINT(-83.753428,9.748917)),
('CU', 'Cuba', POINT(-77.781167,21.521757)),
('CY', 'Cyprus', POINT(33.429859,35.126413)),
('CZ', 'Czech Republic', POINT(15.472962,49.817492)),
('DE', 'Germany', POINT(10.451526,51.165691)),
('DZ', 'Algeria', POINT(1.659626,28.033886)),
('EC', 'Ecuador', POINT(-78.183406,-1.831239)),
('EE', 'Estonia', POINT(25.013607,58.595272)),
('EG', 'Egypt', POINT(30.802498,26.820553)),
('ER', 'Eritrea', POINT(39.782334,15.179384)),
('ES', 'Spain', POINT(-3.74922,40.463667)),
('ET', 'Ethiopia', POINT(40.489673,9.145)),
('FI', 'Finland', POINT(25.748151,61.92411)),
('FO', 'Faroe Islands', POINT(-6.911806,61.892635)),
('FR', 'France', POINT(2.213749,46.227638)),
('GA', 'Gabon', POINT(11.609444,-0.803689)),
('GB', 'United Kingdom', POINT(-3.435973,55.378051)),
('GD', 'Grenada', POINT(-61.604171,12.262776)),
('GE', 'Georgia', POINT(43.356892,42.315407)),
('GF', 'French Guiana', POINT(-53.125782,3.933889)),
('GG', 'Guernsey', POINT(-2.585278,49.465691)),
('GH', 'Ghana', POINT(-1.023194,7.946527)),
('GI', 'Gibraltar', POINT(-5.345374,36.137741)),
('GL', 'Greenland', POINT(-42.604303,71.706936)),
('GM', 'Gambia', POINT(-15.310139,13.443182)),
('GR', 'Greece', POINT(21.824312,39.074208)),
('GY', 'Guyana', POINT(-58.93018,4.860416)),
('GZ', 'Gaza Strip', POINT(34.308825,31.354676)),
('HK', 'Hong Kong', POINT(114.109497,22.396428)),
('ID', 'Indonesia', POINT(113.921327,-0.789275)),
('IE', 'Ireland', POINT(-8.24389,53.41291)),
('IL', 'Israel', POINT(34.851612,31.046051)),
('IQ', 'Iraq', POINT(43.679291,33.223191)),
('IR', 'Iran', POINT(53.688046,32.427908)),
('IS', 'Iceland', POINT(-19.020835,64.963051)),
('IT', 'Italy', POINT(12.56738,41.87194)),
('KH', 'Cambodia', POINT(104.990963,12.565679)),
('KP', 'North Korea', POINT(127.510093,40.339852)),
('KR', 'South Korea', POINT(127.766922,35.907757)),
('KW', 'Kuwait', POINT(47.481766,29.31166)),
('KZ', 'Kazakhstan', POINT(66.923684,48.019573)),
('LA', 'Laos', POINT(102.495496,19.85627)),
('LB', 'Lebanon', POINT(35.862285,33.854721)),
('LI', 'Liechtenstein', POINT(9.555373,47.166)),
('LK', 'Sri Lanka', POINT(80.771797,7.873054)),
('LR', 'Liberia', POINT(-9.429499,6.428055)),
('LS', 'Lesotho', POINT(28.233608,-29.609988)),
('LT', 'Lithuania', POINT(23.881275,55.169438)),
('LU', 'Luxembourg', POINT(6.129583,49.815273)),
('LV', 'Latvia', POINT(24.603189,56.879635)),
('LY', 'Libya', POINT(17.228331,26.3351)),
('MA', 'Morocco', POINT(-7.09262,31.791702)),
('MC', 'Monaco', POINT(7.412841,43.750298)),
('MD', 'Moldova', POINT(28.369885,47.411631)),
('ME', 'Montenegro', POINT(19.37439,42.708678)),
('MG', 'Madagascar', POINT(46.869107,-18.766947)),
('MH', 'Marshall Islands', POINT(171.184478,7.131474)),
('MK', 'Macedonia', POINT(21.745275,41.608635)),
('ML', 'Mali', POINT(-3.996166,17.570692)),
('MM', 'Myanmar', POINT(95.956223,21.913965)),
('MN', 'Mongolia', POINT(103.846656,46.862496)),
('MY', 'Malaysia', POINT(101.975766,4.210484)),
('MZ', 'Mozambique', POINT(35.529562,-18.665695)),
('NI', 'Nicaragua', POINT(-85.207229,12.865416)),
('NL', 'Netherlands', POINT(5.291266,52.132633)),
('NO', 'Norway', POINT(8.468946,60.472024)),
('NP', 'Nepal', POINT(84.124008,28.394857)),
('NR', 'Nauru', POINT(166.931503,-0.522778)),
('NU', 'Niue', POINT(-169.867233,-19.054445)),
('NZ', 'New Zealand', POINT(174.885971,-40.900557)),
('OM', 'Oman', POINT(55.923255,21.512583)),
('PA', 'Panama', POINT(-80.782127,8.537981)),
('PE', 'Peru', POINT(-75.015152,-9.189967)),
('PF', 'French Polynesia', POINT(-149.406843,-17.679742)),
('PG', 'Papua New Guinea', POINT(143.95555,-6.314993)),
('PH', 'Philippines', POINT(121.774017,12.879721)),
('PK', 'Pakistan', POINT(69.345116,30.375321)),
('PL', 'Poland', POINT(19.145136,51.919438)),
('PY', 'Paraguay', POINT(-58.443832,-23.442503)),
('QA', 'Qatar', POINT(51.183884,25.354826)),
('RE', 'Réunion', POINT(55.536384,-21.115141)),
('RO', 'Romania', POINT(24.96676,45.943161)),
('RS', 'Serbia', POINT(21.005859,44.016521)),
('RU', 'Russia', POINT(105.318756,61.52401)),
('RW', 'Rwanda', POINT(29.873888,-1.940278)),
('SA', 'Saudi Arabia', POINT(45.079162,23.885942)),
('SB', 'Solomon Islands', POINT(160.156194,-9.64571)),
('SC', 'Seychelles', POINT(55.491977,-4.679574)),
('SD', 'Sudan', POINT(30.217636,12.862807)),
('SE', 'Sweden', POINT(18.643501,60.128161)),
('SG', 'Singapore', POINT(103.819836,1.352083)),
('SH', 'Saint Helena', POINT(-10.030696,-24.143474)),
('SI', 'Slovenia', POINT(14.995463,46.151241)),
('SK', 'Slovakia', POINT(19.699024,48.669026)),
('SL', 'Sierra Leone', POINT(-11.779889,8.460555)),
('SN', 'Senegal', POINT(-14.452362,14.497401)),
('SO', 'Somalia', POINT(46.199616,5.152149)),
('SR', 'Suriname', POINT(-56.027783,3.919305)),
('TR', 'Turkey', POINT(35.243322,38.963745)),
('UA', 'Ukraine', POINT(31.16558,48.379433)),
('UG', 'Uganda', POINT(32.290275,1.373333)),
('US', 'United States', POINT(-95.712891,37.09024)),
('UY', 'Uruguay', POINT(-55.765835,-32.522779)),
('UZ', 'Uzbekistan', POINT(64.585262,41.377491)),
('VA', 'Vatican City', POINT(12.453389,41.902916)),
('VC', 'Saint Vincent and the Grenadines', POINT(-61.287228,12.984305)),
('VE', 'Venezuela', POINT(-66.58973,6.42375)),
('VG', 'British Virgin Islands', POINT(-64.639968,18.420695)),
('VI', 'U.S. Virgin Islands', POINT(-64.896335,18.335765)),
('VN', 'Vietnam', POINT(108.277199,14.058324)),
('VU', 'Vanuatu', POINT(166.959158,-15.376706)),
('WF', 'Wallis and Futuna', POINT(-177.156097,-13.768752)),
('WS', 'Samoa', POINT(-172.104629,-13.759029)),
('XK', 'Kosovo', POINT(20.902977,42.602636)),
('YE', 'Yemen', POINT(48.516388,15.552727)),
('YT', 'Mayotte', POINT(45.166244,-12.8275)),
('ZA', 'South Africa', POINT(22.937506,-30.559482)),
('ZM', 'Zambia', POINT(27.849332,-13.133897)),
('ZW', 'Zimbabwe', POINT(29.154857,-19.015438));


REPLACE INTO Artista VALUES
 ('Vincenzino', 'Fiore', 8.43),
('Fernando', 'De Simone', 3.79),
('Sara', 'Scognamiglio', 8.84),
('Giulio', 'Esposito', 9.12),
('Luca', 'Zannelli', 2.1),
('Luca', 'Fiore', 3.15),
('Loris', 'Zannelli', 5.55),
('Sara', 'Della Valle', 2.33),
('Jasmine', 'Gallo', 4.48),
('Giada', 'Della Valle', 7.67),
('Giacomo', 'Rossi', 1.66),
('Gianmarco', 'Fabbricatore', 0.58),
('Pasquale', 'Fabbricatore', 6.24),
('Jacopo', 'Fabbricatore', 2.88),
('Antonio', 'Scognamiglio', 5.84),
('Alessio', 'Gallo', 7.21),
('Lorenzo', 'Fiore', 6.48),
('Costanza', 'Gallo', 3.68),
('Lorenza', 'Fiore', 8.0),
('Diego', 'Scognamiglio', 8.32),
('Tom', 'Rossi', 1.28),
('Tom', 'Fabbricatore', 7.18),
('Vincenzino', 'Esposito', 9.05),
('Lorenzo', 'Zannelli', 1.65),
('Alessio', 'Zannelli', 3.09),
('Jasmine', 'Zannelli', 2.87),
('Boris', 'Esposito', 7.47),
('Giulio', 'Fabbricatore', 5.01),
('Giacomo', 'Zannelli', 0.16),
('Carmen', 'Zannelli', 6.18),
('Alessio', 'Fabbricatore', 9.97),
('Guido', 'Bianchi', 6.92),
('Costanza', 'Esposito', 0.48),
('Gabriele', 'Fabbricatore', 7.66),
('Guido', 'Fabbricatore', 4.18),
('Gabriele', 'Rossi', 0.17),
('Simone', 'Bianchi', 4.17),
('Letizia', 'De Simone', 2.74),
('Lorenza', 'Bianchi', 3.58),
('Michele', 'Fiore', 2.78),
('Giacomo', 'Fabbricatore', 8.53),
('Jasmine', 'Esposito', 3.13),
('Yarov', 'Gallo', 7.84),
('Lorenzo', 'De Simone', 1.92),
('Lorenza', 'Della Valle', 1.56),
('Costanza', 'Della Valle', 4.96),
('Antonino', 'Rossi', 1.19),
('Diego', 'Della Valle', 9.53),
('Michele', 'Scognamiglio', 5.84),
('Carmen', 'Bianchi', 4.71),
('Michele', 'Fabbricatore', 3.89),
('Antonio', 'De Simone', 7.3),
('Christian', 'Zannelli', 6.62),
('Gabriele', 'Della Valle', 0.8),
('Luca', 'Esposito', 1.96),
('Giuseppe', 'Della Valle', 7.42),
('Federico', 'Gallo', 6.31),
('Tom', 'Bianchi', 2.32),
('John', 'Gallo', 0.77),
('Letizia', 'Scognamiglio', 1.17),
('Fernando', 'Zannelli', 1.51),
('Costanza', 'Fiore', 7.72),
('Jim', 'De Simone', 7.34),
('Riccardo', 'Scognamiglio', 9.54),
('John', 'De Simone', 7.01),
('Antonio', 'Della Valle', 2.88),
('Giuseppe', 'De Simone', 8.93),
('Gabriele', 'Gallo', 4.05),
('Yarov', 'Fiore', 5.57),
('Lorenzo', 'Della Valle', 5.16),
('Diego', 'Fabbricatore', 4.21),
('Gabriele', 'Gallo', 0.54),
('Vincenzo', 'Fabbricatore', 2.8),
('Boris', 'De Simone', 2.62),
('Federico', 'Della Valle', 7.03),
('Jacopo', 'Zannelli', 1.38),
('Luca', 'Fabbricatore', 7.64),
('Federico', 'Fiore', 6.48),
('Gabriele', 'Zannelli', 0.7),
('Giulio', 'Scognamiglio', 3.61),
('Riccardo', 'Esposito', 5.0),
('Lorenza', 'Zannelli', 4.08),
('Carmen', 'De Simone', 0.04),
('Gianmarco', 'Fiore', 6.2),
('Fernando', 'Esposito', 4.05),
('Letizia', 'Bianchi', 4.67),
('Costanza', 'Bianchi', 8.02),
('Pasquale', 'Zannelli', 6.6),
('Vincenzo', 'De Simone', 0.55),
('Simone', 'Zannelli', 4.92),
('Simone', 'Della Valle', 4.6),
('Loris', 'Fabbricatore', 7.9),
('Marcello', 'De Simone', 3.13),
('Sara', 'Rossi', 0.16),
('Guido', 'Della Valle', 7.73),
('Jim', 'Scognamiglio', 3.51),
('Jim', 'Esposito', 4.55),
('Michele', 'Esposito', 2.15),
('Gianmarco', 'Bianchi', 0.42),
('Antonino', 'Scognamiglio', 2.02),
('Alessandro', 'Gallo', 6.25),
('Carmen', 'Della Valle', 2.48),
('Diego', 'Rossi', 9.82),
('Christian', 'Scognamiglio', 4.88),
('Gabriele', 'Della Valle', 9.38),
('Marcello', 'Gallo', 8.33),
('Sara', 'Zannelli', 5.61),
('Giulia', 'Esposito', 0.93),
('Giacomo', 'De Simone', 9.3),
('Pasquale', 'Della Valle', 6.68),
('Vincenzo', 'Della Valle', 3.69),
('Jacopo', 'Esposito', 5.81),
('Pasquale', 'Fiore', 2.18),
('Fernando', 'Gallo', 3.4),
('Giuseppe', 'Rossi', 8.36),
('Tom', 'Gallo', 4.11),
('Lorenzo', 'Bianchi', 5.5),
('Giada', 'Gallo', 6.41),
('Michele', 'Zannelli', 2.32),
('Carmen', 'Fiore', 4.09),
('Michele', 'De Simone', 4.26),
('Boris', 'Gallo', 0.67),
('Alessio', 'Rossi', 3.61),
('Imma', 'Della Valle', 3.53),
('Alessandro', 'Esposito', 9.12),
('Pasquale', 'De Simone', 7.77),
('Antonino', 'Esposito', 3.31),
('Jim', 'Fabbricatore', 2.43),
('Christian', 'Della Valle', 2.47),
('Simone', 'Fabbricatore', 1.59),
('Giulio', 'Rossi', 0.45),
('Federico', 'De Simone', 4.81),
('Pasquale', 'Rossi', 5.04),
('Michele', 'Gallo', 5.57),
('Luca', 'Scognamiglio', 5.88),
('Antonino', 'Della Valle', 7.2),
('Lorenzo', 'Rossi', 2.36),
('Giulia', 'Bianchi', 3.97),
('John', 'Fiore', 4.14),
('Giuseppe', 'Esposito', 6.11),
('Tom', 'Fiore', 8.05),
('Vincenzino', 'Gallo', 0.49),
('Giada', 'Fiore', 7.5),
('Giulia', 'Fiore', 4.0),
('Loris', 'Rossi', 4.35),
('Riccardo', 'Zannelli', 2.6),
('Letizia', 'Zannelli', 4.38),
('Diego', 'Bianchi', 7.27),
('Sara', 'Bianchi', 7.33),
('Antonio', 'Gallo', 6.18),
('Gabriele', 'Fiore', 1.57),
('Jacopo', 'De Simone', 0.63),
('Guido', 'Scognamiglio', 0.26),
('Pasquale', 'Esposito', 0.85),
('Giuseppe', 'Zannelli', 4.6),
('Lorenza', 'Scognamiglio', 1.36),
('Letizia', 'Fiore', 5.7),
('Vincenzino', 'Fabbricatore', 2.7),
('Jacopo', 'Bianchi', 4.85),
('Alessandro', 'Scognamiglio', 1.29),
('Jasmine', 'De Simone', 2.0),
('Marcello', 'Bianchi', 0.44),
('Giacomo', 'Esposito', 3.53),
('Giada', 'Bianchi', 1.34),
('Antonino', 'Fabbricatore', 2.12),
('Gianmarco', 'De Simone', 7.2),
('Alessandro', 'Della Valle', 7.63),
('Sara', 'De Simone', 6.15),
('Riccardo', 'Fiore', 2.34),
('Marcello', 'Fiore', 9.86),
('Giulia', 'Della Valle', 1.09),
('Jim', 'Bianchi', 0.4),
('Giulia', 'Rossi', 3.18),
('Marcello', 'Esposito', 4.74),
('Jim', 'Fiore', 6.19),
('Alessio', 'Bianchi', 5.99),
('John', 'Bianchi', 4.92),
('Jasmine', 'Scognamiglio', 5.41),
('Luca', 'De Simone', 2.74),
('Christian', 'De Simone', 5.86),
('Boris', 'Bianchi', 1.86),
('Giacomo', 'Della Valle', 8.7),
('Gabriele', 'De Simone', 0.67),
('Fernando', 'Fabbricatore', 0.3),
('Antonino', 'Gallo', 7.79),
('Tom', 'De Simone', 7.81),
('Jacopo', 'Rossi', 2.11),
('Tom', 'Esposito', 1.63),
('Alessio', 'Esposito', 3.87),
('Loris', 'De Simone', 1.11),
('Costanza', 'Fabbricatore', 7.55),
('Christian', 'Fabbricatore', 3.98),
('Loris', 'Bianchi', 9.78),
('Guido', 'Rossi', 2.88),
('Federico', 'Rossi', 0.47),
('Marcello', 'Zannelli', 9.73),
('Federico', 'Zannelli', 5.72),
('Alessandro', 'Fiore', 4.37),
('Carmen', 'Fabbricatore', 7.43),
('Jasmine', 'Bianchi', 0.02),
('Antonio', 'Esposito', 3.56),
('Antonino', 'Fiore', 6.84),
('Giulio', 'Bianchi', 1.65),
('John', 'Rossi', 5.03),
('Lorenza', 'Esposito', 1.54),
('Jacopo', 'Della Valle', 8.45),
('Luca', 'Della Valle', 3.33),
('Simone', 'De Simone', 8.77),
('Vincenzo', 'Fiore', 7.39),
('Simone', 'Gallo', 8.55),
('Yarov', 'Zannelli', 8.95),
('Carmen', 'Gallo', 9.84),
('John', 'Esposito', 9.34),
('Vincenzo', 'Gallo', 9.52),
('Jacopo', 'Fiore', 5.72),
('Antonio', 'Bianchi', 9.0),
('Loris', 'Esposito', 7.96),
('Michele', 'Bianchi', 5.62),
('Boris', 'Zannelli', 4.29),
('Carmen', 'Esposito', 5.5),
('Gabriele', 'Scognamiglio', 7.8),
('Luca', 'Gallo', 5.71),
('Federico', 'Bianchi', 5.59),
('Alessio', 'De Simone', 2.44),
('Fernando', 'Della Valle', 6.57),
('Letizia', 'Esposito', 7.6),
('Giada', 'Zannelli', 2.7),
('Diego', 'De Simone', 0.4),
('Sara', 'Fiore', 0.29),
('Riccardo', 'Della Valle', 2.71),
('Simone', 'Esposito', 4.98),
('Vincenzino', 'Bianchi', 4.73),
('Loris', 'Scognamiglio', 6.25),
('Gabriele', 'Fabbricatore', 2.02),
('Vincenzo', 'Bianchi', 9.29),
('Federico', 'Fabbricatore', 2.42),
('Federico', 'Scognamiglio', 9.12),
('Christian', 'Bianchi', 7.59),
('Antonino', 'De Simone', 4.27),
('Imma', 'Fiore', 6.48),
('Riccardo', 'Rossi', 0.07),
('Riccardo', 'Gallo', 0.27),
('Vincenzo', 'Rossi', 5.44),
('Christian', 'Rossi', 4.04),
('Giulio', 'Zannelli', 5.76),
('Lorenzo', 'Gallo', 1.6),
('Marcello', 'Rossi', 4.5),
('Simone', 'Fiore', 3.63),
('Guido', 'Gallo', 2.39),
('Loris', 'Gallo', 0.39),
('Costanza', 'Scognamiglio', 2.95),
('Lorenzo', 'Esposito', 9.2),
('Vincenzino', 'Rossi', 3.61),
('Alessio', 'Scognamiglio', 6.36),
('Diego', 'Zannelli', 5.63),
('Riccardo', 'Bianchi', 5.67),
('Letizia', 'Della Valle', 8.4),
('Vincenzino', 'Della Valle', 4.38),
('Pasquale', 'Gallo', 2.64),
('Luca', 'Rossi', 1.86),
('Giada', 'Scognamiglio', 8.54),
('Giulio', 'Gallo', 2.2),
('Gianmarco', 'Zannelli', 0.8),
('Jacopo', 'Scognamiglio', 1.57),
('Giuseppe', 'Scognamiglio', 8.08),
('Imma', 'Bianchi', 4.76),
('Letizia', 'Fabbricatore', 0.3),
('Vincenzo', 'Zannelli', 7.94),
('Vincenzo', 'Esposito', 8.8),
('Alessio', 'Fiore', 6.08),
('Christian', 'Fiore', 0.4),
('Gabriele', 'Bianchi', 5.29),
('Giacomo', 'Bianchi', 0.1),
('Costanza', 'De Simone', 5.95),
('Fernando', 'Rossi', 3.53),
('John', 'Della Valle', 2.88),
('Giada', 'De Simone', 4.52),
('Jasmine', 'Della Valle', 6.37),
('Lorenza', 'Rossi', 4.0),
('Lorenzo', 'Scognamiglio', 2.74),
('Guido', 'Zannelli', 0.29),
('Jasmine', 'Fabbricatore', 8.93),
('Diego', 'Gallo', 3.46),
('Giuseppe', 'Gallo', 4.38),
('Jim', 'Gallo', 3.5),
('Jasmine', 'Rossi', 1.15),
('Jim', 'Zannelli', 4.48),
('Marcello', 'Della Valle', 1.29),
('Vincenzo', 'Scognamiglio', 1.95),
('Imma', 'Scognamiglio', 7.6),
('Sara', 'Gallo', 1.04),
('Guido', 'Esposito', 3.13),
('Letizia', 'Gallo', 4.43),
('Costanza', 'Zannelli', 1.47),
('Loris', 'Fiore', 8.9),
('Giacomo', 'Gallo', 2.16),
('Vincenzino', 'Zannelli', 5.22),
('Antonio', 'Fiore', 6.0),
('Antonino', 'Bianchi', 3.91),
('Giulio', 'Fiore', 2.29),
('Simone', 'Scognamiglio', 2.9),
('Loris', 'Della Valle', 4.66),
('Giuseppe', 'Fabbricatore', 5.93),
('Luca', 'Bianchi', 2.94),
('Riccardo', 'De Simone', 9.96),
('Imma', 'Fabbricatore', 3.87),
('Gabriele', 'Bianchi', 6.95),
('Gianmarco', 'Esposito', 6.18),
('Yarov', 'Bianchi', 3.17),
('Gabriele', 'Rossi', 5.26),
('Imma', 'Zannelli', 9.68),
('Giacomo', 'Fiore', 2.27),
('Tom', 'Della Valle', 6.64),
('Yarov', 'Scognamiglio', 5.37),
('Fernando', 'Scognamiglio', 2.75),
('Tom', 'Zannelli', 6.48),
('Vincenzino', 'Scognamiglio', 6.59),
('Carmen', 'Rossi', 4.86),
('Giulio', 'De Simone', 5.99),
('Gabriele', 'Esposito', 0.83),
('Jim', 'Della Valle', 0.73),
('Diego', 'Esposito', 4.15),
('Antonio', 'Rossi', 3.47),
('Marcello', 'Scognamiglio', 1.24),
('Lorenza', 'Gallo', 8.32),
('Gabriele', 'De Simone', 0.81),
('Boris', 'Scognamiglio', 7.19),
('Tom', 'Scognamiglio', 0.24),
('Gianmarco', 'Rossi', 9.96),
('Yarov', 'De Simone', 8.62),
('Alessio', 'Della Valle', 5.76),
('Antonio', 'Zannelli', 8.6),
('Gabriele', 'Scognamiglio', 6.99),
('Antonino', 'Zannelli', 4.33),
('Yarov', 'Fabbricatore', 7.26),
('Federico', 'Esposito', 9.86),
('Imma', 'Esposito', 6.16),
('John', 'Fabbricatore', 8.67),
('Lorenza', 'Fabbricatore', 7.71),
('Imma', 'Gallo', 0.73),
('Vincenzino', 'De Simone', 3.58),
('Giulia', 'Zannelli', 5.77),
('Lorenza', 'De Simone', 1.96),
('Giada', 'Esposito', 1.3),
('Jim', 'Rossi', 0.95),
('Alessandro', 'Fabbricatore', 0.34),
('Pasquale', 'Bianchi', 6.8),
('Boris', 'Fabbricatore', 1.66),
('Alessandro', 'Bianchi', 4.61),
('Sara', 'Esposito', 0.72),
('Giacomo', 'Scognamiglio', 9.95),
('Yarov', 'Esposito', 7.57),
('Jacopo', 'Gallo', 4.24),
('Alessandro', 'Rossi', 8.51),
('Yarov', 'Della Valle', 2.86),
('Michele', 'Rossi', 5.23),
('Guido', 'Fiore', 5.46),
('Boris', 'Della Valle', 3.44),
('Fernando', 'Fiore', 4.85),
('Boris', 'Fiore', 0.06),
('Imma', 'Rossi', 4.86),
('John', 'Scognamiglio', 7.1),
('Riccardo', 'Fabbricatore', 2.01),
('Gabriele', 'Zannelli', 4.59),
('Gianmarco', 'Scognamiglio', 0.52),
('Fernando', 'Bianchi', 7.02),
('Letizia', 'Rossi', 0.49),
('Christian', 'Esposito', 5.08),
('Giulia', 'Gallo', 9.78),
('Marcello', 'Fabbricatore', 3.21),
('Gabriele', 'Fiore', 4.82),
('Simone', 'Rossi', 1.05),
('Lorenzo', 'Fabbricatore', 1.76),
('Diego', 'Fiore', 0.36),
('Giuseppe', 'Bianchi', 6.61),
('Sara', 'Fabbricatore', 1.99),
('Giada', 'Rossi', 1.88),
('Michele', 'Della Valle', 4.44),
('Pasquale', 'Scognamiglio', 2.36),
('Alessandro', 'Zannelli', 9.05),
('Giada', 'Fabbricatore', 3.85),
('Giulio', 'Della Valle', 7.38),
('Giulia', 'De Simone', 9.67),
('Giulia', 'Scognamiglio', 4.94),
('Giulia', 'Fabbricatore', 7.84),
('Boris', 'Rossi', 0.91),
('Jasmine', 'Fiore', 4.64),
('Alessandro', 'De Simone', 7.93),
('Costanza', 'Rossi', 1.2),
('Carmen', 'Scognamiglio', 4.68),
('Imma', 'De Simone', 2.12),
('Christian', 'Gallo', 9.53),
('Guido', 'De Simone', 1.12),
('Gianmarco', 'Della Valle', 6.35),
('Antonio', 'Fabbricatore', 7.19),
('Gianmarco', 'Gallo', 2.91),
('Gabriele', 'Esposito', 2.42),
('Yarov', 'Rossi', 9.74),
('John', 'Zannelli', 3.55),
('Giuseppe', 'Fiore', 9.14);