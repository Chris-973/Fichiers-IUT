------------------------------------------------------------------
-- TP#05 Contraintes d’Intégrités Différées
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Désactivation de contraintes et Table de rejet
------------------------------------------------------------------

-- 1 
CREATE TABLE Rejet
(
 No_Ligne       ROWID,
 Proprio        VARCHAR(30),
 Nom_Table      VARCHAR(30),
 Nom_Contrainte VARCHAR(30)
);

-- 2 
ALTER TABLE Country
DISABLE CONSTRAINT FK_Country_cname;

-- 3 
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, VALIDATED
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'COUNTRY';

-- 4
INSERT INTO Country (iso3, iso2, name, cname)
VALUES ('UT2', 'UT', 'IUT de Blagnac', 'XXX');

-- 5 
ALTER TABLE Country
ENABLE CONSTRAINT FK_Country_cname
EXCEPTIONS INTO REJET;

-- 6 
SELECT *
FROM Rejet;

-- 7 
SELECT ROWID, C.*
FROM  Country C
WHERE ROWID IN (SELECT No_Ligne FROM Rejet);

-- 8
DELETE FROM Country
WHERE ROWID IN (SELECT No_Ligne FROM Rejet);

-- 9
DELETE FROM Rejet;

ALTER TABLE Country
ENABLE CONSTRAINT FK_Country_cname
EXCEPTIONS INTO REJET;

-- La contrainte est réactivée
-- car la BD est bien dans un état cohérent (le contenu respecte toutes les C.I. de la BD)

-- 10
DROP TABLE Rejet;

------------------------------------------------------------------
-- 2	Contraintes différées
------------------------------------------------------------------

------------------------------------------------------------------
-- 2.1	Mise en place de la contrainte différée
------------------------------------------------------------------

-- 1
ALTER TABLE Country
DROP CONSTRAINT FK_Country_cname;

ALTER TABLE Region
DROP CONSTRAINT FK_Region_cname;

-- 2
ALTER TABLE Country
ADD CONSTRAINT FK_Country_cname FOREIGN KEY (cname) REFERENCES Continent (name)
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE Region
ADD CONSTRAINT FK_Region_cname FOREIGN KEY (cname) REFERENCES Continent (name)
DEFERRABLE INITIALLY IMMEDIATE;

-- 3
SET PAGESIZE 100;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, DEFERRABLE, DEFERRED
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('COUNTRY', 'REGION');


------------------------------------------------------------------
-- 2	Contraintes différées
------------------------------------------------------------------

-- 1
INSERT INTO Country (iso3, iso2, name, capital, rcode, cname)
VALUES ('UT2', 'U2', 'IUT de Blagnac', 'Blagnac', '155', 'XXX');
-- ORA-02291: violation de contrainte d'intégrité (TESTE.FK_COUNTRY_CNAME) - clé parent introuvable

DELETE FROM Continent
WHERE name = 'Europe';
-- ORA-02292: violation de contrainte (TESTE.FK_REGION_CNAME) d'intégrité - enregistrement fils existant

UPDATE Country
SET cname = 'Amérique'
WHERE iso3 = 'CAN';
-- ORA-02291: violation de contrainte d'intégrité (TESTE.FK_COUNTRY_CNAME) - clé parent introuvable

-- 2
ALTER TABLE Country
MODIFY CONSTRAINT FK_Country_cname INITIALLY DEFERRED;

ALTER TABLE Region
MODIFY CONSTRAINT FK_Region_cname INITIALLY DEFERRED;

-- 3
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, DEFERRABLE, DEFERRED
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('COUNTRY', 'REGION');

-- 4
INSERT INTO Country (iso3, iso2, name, capital, rcode, cname)
VALUES ('UT2', 'U2', 'IUT de Blagnac', 'Blagnac', '155', 'XXX');

DELETE FROM Continent
WHERE name = 'Europe';

UPDATE Country
SET cname = 'Amérique'
WHERE iso3 = 'CAN';

-- 5
SELECT *
FROM Country
WHERE cname = 'XXX';

SELECT *
FROM Continent
WHERE name = 'Europe';

SELECT *
FROM Country
WHERE cname = 'Amérique';

-- 6
COMMIT;

-- ORA-02091: transaction annulée
-- ORA-02291: violation de contrainte d'intégrité (TESTE.FK_COUNTRY_CNAME) - clé parent introuvable
-- 02091. 00000 -  "transaction rolled back"

-- 7
SELECT *
FROM Country
WHERE cname = 'XXX';

SELECT *
FROM Continent
WHERE name = 'Europe';

SELECT *
FROM Country
WHERE cname = 'Amérique';

-- 8
INSERT INTO Country (iso3, iso2, name, capital, rcode, cname)
VALUES ('UT2', 'U2', 'IUT de Blagnac', 'Blagnac', '155', 'XXX');

INSERT INTO Continent
VALUES ('XXX', NULL);

COMMIT;

