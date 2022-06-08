------------------------------------------------------------------
-- TP#03 Manipulation de la base de données (BD)
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Insertion de tuples
------------------------------------------------------------------

-- 1 

INSERT INTO Region
VALUES ('155', 'Western Europe', NULL, 'Europe');

INSERT INTO Country 
VALUES ('FRA', 'FR', 'France', 'Paris', 64990511, 5515, 81.9, '155', 'Europe');

INSERT INTO Border
VALUES ('FRA', 'AND', 56.6);
INSERT INTO Border
VALUES ('AND', 'FRA', 56.6);

INSERT INTO Border
VALUES ('FRA', 'BEL', 620);
INSERT INTO Border
VALUES ('BEL', 'FRA', 620);

INSERT INTO Border
VALUES ('FRA', 'BRA', 673);
INSERT INTO Border
VALUES ('BRA', 'FRA', 673);

INSERT INTO Border
VALUES ('FRA', 'CHE', 573);
INSERT INTO Border
VALUES ('CHE', 'FRA', 573);

INSERT INTO Border
VALUES ('FRA', 'DEU', 451);
INSERT INTO Border
VALUES ('DEU', 'FRA', 451);

INSERT INTO Border
VALUES ('FRA', 'ESP', 623);
INSERT INTO Border
VALUES ('ESP', 'FRA', 623);

INSERT INTO Border
VALUES ('FRA', 'ITA', 488);
INSERT INTO Border
VALUES ('ITA', 'FRA', 488);

INSERT INTO Border
VALUES ('FRA', 'LUX', 73);
INSERT INTO Border
VALUES ('LUX', 'FRA', 73);

INSERT INTO Border
VALUES ('FRA', 'MCO', 4.4);
INSERT INTO Border
VALUES ('MCO', 'FRA', 4.4);

INSERT INTO Border
VALUES ('FRA', 'NLD', 10.2);
INSERT INTO Border
VALUES ('NLD', 'FRA', 10.2);

INSERT INTO Border
VALUES ('FRA', 'SUR', 510);
INSERT INTO Border
VALUES ('SUR', 'FRA', 510);

COMMIT;

-- 2
SELECT *
FROM Region;

SELECT *
FROM Country
WHERE name = 'France';

SELECT *
FROM Border
WHERE country = 'FRA'
  OR bcountry = 'FRA';

-- 3
INSERT INTO Country (iso3, iso2, name, rcode)
VALUES ('FRA', 'FR', 'Autre France', '155');
-- ORA-00001: violation de contrainte unique (TESTE.PK_COUNTRY)

-- 4
INSERT INTO Country (iso3, iso2, name, rcode)
VALUES ('XXX', 'FR', 'Autre France', '155');
-- ORA-00001: violation de contrainte unique (TESTE.UK_COUNTRY_ISO2)

-- 5
INSERT INTO Country (iso3, iso2, name, rcode)
VALUES ('XXX', 'XX', 'Autre France', '999');
-- ORA-02291: violation de contrainte d'intégrité (TESTE.FK_COUNTRY_RCODE) - clé parent introuvable

------------------------------------------------------------------
-- 2	Suppression de tuples
------------------------------------------------------------------

-- 1
INSERT INTO Country 
VALUES ('OCC', 'OC', 'Occitanie', 'Toulouse', 5839867, 72724, 80, '155', 'Europe');

INSERT INTO Border 
VALUES ('OCC', 'FRA', 485);
INSERT INTO Border 
VALUES ('FRA', 'OCC', 485);

COMMIT;

-- 2
DELETE FROM Country
WHERE name = 'Occitanie'
-- ORA-02292: violation de contrainte (TESTE.FK_BORDER_COUNTRY) d'intégrité - enregistrement fils existant

-- 3
DELETE FROM Border
WHERE country = 'OCC'
  OR bcountry = 'OCC';

DELETE FROM Country
WHERE name = 'Occitanie'

COMMIT;

------------------------------------------------------------------
-- 3	Modification de tuples
------------------------------------------------------------------

-- 1
UPDATE Country
SET rcode = '155',
    cname = 'Europe'
WHERE rcode  IS NULL;

COMMIT;

-- 2
SELECT iso3, name, capital, rcode, cname
FROM Country
WHERE iso3 IN ('AUT', 'BEL', 'CHE', 'DEU', 'LIE', 'LUX', 'MCO', 'NLD');



-- 3
UPDATE Country SET capital = 'Buenos Aires' WHERE name = 'Argentina';
UPDATE Country SET capital = 'Quito' WHERE name = 'Ecuador';
UPDATE Country SET capital = 'Georgetown' WHERE name = 'Guyana';
UPDATE Country SET capital = 'Lima' WHERE name = 'Peru';
UPDATE Country SET capital = 'Paramaribo' WHERE name = 'Suriname';
UPDATE Country SET capital = 'La Paz' WHERE name = 'Bolivia';
UPDATE Country SET capital = 'Asunción' WHERE name = 'Paraguay';
UPDATE Country SET capital = 'Montevideo' WHERE name = 'Uruguay';
UPDATE Country SET capital = 'Santiago' WHERE name = 'Chile';
UPDATE Country SET capital = 'Cayenne' WHERE name = 'French Guiana';
UPDATE Country SET capital = 'Caracas' WHERE name = 'Venezuela';
UPDATE Country SET capital = 'Bogotá' WHERE name = 'Colombia';
UPDATE Country SET capital = 'Brasília' WHERE name = 'Brazil';

COMMIT;
