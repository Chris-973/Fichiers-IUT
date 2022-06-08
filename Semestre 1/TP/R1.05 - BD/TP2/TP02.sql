------------------------------------------------------------------
-- TP#02 Modification de la base de données (BD)
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Modification des attributs
------------------------------------------------------------------

-- 1 

ALTER TABLE Continent
MODIFY name VARCHAR(30);

DESC Continent;

-- 2 

ALTER TABLE Continent
MODIFY name VARCHAR(5);
-- ORA-01441: impossible de diminuer la largeur de colonne : certaines valeurs sont trop élevées

DESC Continent;

------------------------------------------------------------------
-- 2	Ajout d’attributs
------------------------------------------------------------------

-- 1

DESC Country;

-- 2

ALTER TABLE Country
ADD cname VARCHAR(30);

ALTER TABLE Country
ADD CONSTRAINT fk_country_cname FOREIGN KEY (cname) REFERENCES Continent(name);

-- 3

DESC Country;

-- 4

SET PAGESIZE 1000;
SELECT * FROM Country ORDER BY name;
-- On constate que la colonne cname est vide (NULL)

-- 5

UPDATE Country C
SET cname = (SELECT R.cname
             FROM Region R
             WHERE R.code = C.rcode);
UPDATE Country C
SET cname = (SELECT R1.cname
             FROM Region R1, Region R2
             WHERE R1.code = R2.rcode 
               AND R2.code = C.rcode)
WHERE cname IS NULL;
COMMIT;

SELECT * FROM Country ORDER BY name;

------------------------------------------------------------------
-- 3	Ajout de contraintes
------------------------------------------------------------------

------------------------------------------------------------------
-- 3.1	Contraintes de clé étrangère (FOREIGN KEY)
------------------------------------------------------------------

-- 1

ALTER TABLE Country
ADD CONSTRAINT fk_country_cname FOREIGN KEY (cname) REFERENCES Continent(name);

------------------------------------------------------------------
-- 3.2	Contraintes d’unicité (UNIQUE)
------------------------------------------------------------------

-- 1

ALTER TABLE Region
ADD CONSTRAINT uk_region_name UNIQUE (name);

-- 2

ALTER TABLE Country
ADD (
    CONSTRAINT uk_country_iso2 UNIQUE (iso2),
    CONSTRAINT uk_country_name UNIQUE (name)
	);

------------------------------------------------------------------
-- 3.3	Contraintes de domaine (CHECK)
------------------------------------------------------------------

-- 1
 
ALTER TABLE Continent
ADD CONSTRAINT ck_continent_area CHECK (area > 0);

-- 2

ALTER TABLE Border
ADD CONSTRAINT ck_border_length CHECK (length > 0);

-- 3

ALTER TABLE Country
ADD (
	CONSTRAINT ck_country_population CHECK (population >= 0),
	CONSTRAINT ck_country_area    CHECK (area > 0),
	CONSTRAINT ck_country_expectancy CHECK (expectancy > 0)
	);

-- 4

ALTER TABLE PandemicCONSTRAINT
ADD (
	CONSTRAINT ck_pandemic_cases       CHECK (cases >= 0),
	CONSTRAINT ck_pandemic_deaths      CHECK (deaths >= 0),
	CONSTRAINT ck_pandemic_rrate       CHECK (rrate >= 0),
	CONSTRAINT ck_pandemic_icu         CHECK (icu >= 0),
	CONSTRAINT ck_pandemic_hpatients   CHECK (hpatients >= 0),
	CONSTRAINT ck_pandemic_tests       CHECK (tests >= 0),
	CONSTRAINT ck_pandemic_prate       CHECK (prate >= 0),
	CONSTRAINT ck_pandemic_vacc        CHECK (vacc >= 0),
	CONSTRAINT ck_pandemic_fvacc       CHECK (fvacc >= 0)
	);

------------------------------------------------------------------
-- 3.4	Contraintes de valeur nulle (NOT NULL)
------------------------------------------------------------------

ALTER TABLE Country
ADD (
	CONSTRAINT nn_country_rcode CHECK (rcode IS NOT NULL),
	CONSTRAINT nn_country_cname CHECK (cname IS NOT NULL)
	);







