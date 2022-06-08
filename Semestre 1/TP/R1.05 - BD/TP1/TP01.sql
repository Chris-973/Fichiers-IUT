------------------------------------------------------------------
-- TP#01 Création de la base de données (BD)
------------------------------------------------------------------

------------------------------------------------------------------
-- 1.	Connexion à Oracle
------------------------------------------------------------------
-- 1.1 
-- 1.2 
-- 1.3 
-- 1.4 

------------------------------------------------------------------
-- 2.	Création de la BD initiale
------------------------------------------------------------------
-- 2.1 createbase.sql

// Suppression des Tables

DROP TABLE Pandemic;
DROP TABLE Border;
DROP TABLE Country;
DROP TABLE Region;
DROP TABLE Continent;

// Création des Tables

CREATE TABLE Continent
(
 name VARCHAR(50),
 area DECIMAL(12,2),
 CONSTRAINT pk_continent PRIMARY KEY (name)
);

CREATE TABLE Region
(
 code CHAR(3),
 name VARCHAR(50),
 rcode CHAR(3),
 cname VARCHAR(50),
 CONSTRAINT pk_region PRIMARY KEY (code),
 CONSTRAINT fk_region_rcode FOREIGN KEY (rcode) REFERENCES Region (code),
 CONSTRAINT fk_region_cname FOREIGN KEY (cname) REFERENCES Continent (name)
);

CREATE TABLE Country
(
 iso3 CHAR(3),
 iso2 CHAR(2),
 name VARCHAR(50),
 capital VARCHAR(50),
 population DECIMAL,
 area DECIMAL(12,2),
 expectancy DECIMAL(4,2),
 rcode CHAR(3),
 CONSTRAINT pk_country PRIMARY KEY (iso3),
 CONSTRAINT fk_country_rcode FOREIGN KEY (rcode) REFERENCES Region (code)
);

CREATE TABLE Border
(
 country  CHAR(3),
 bcountry CHAR(3),
 length DECIMAL,
 CONSTRAINT pk_border PRIMARY KEY (country, bcountry),
 CONSTRAINT fk_border_country  FOREIGN KEY (country)  REFERENCES Country (iso3),
 CONSTRAINT fk_border_bcountry FOREIGN KEY (bcountry) REFERENCES Country (iso3)
);

CREATE TABLE Pandemic
(
 iso3 CHAR(3),
 ddate DATE,
 cases DECIMAL,
 deaths DECIMAL,
 rrate DECIMAL,
 icu DECIMAL,
 hpatients DECIMAL,
 tests DECIMAL,
 prate DECIMAL(4,3),
 vacc DECIMAL,
 fvacc DECIMAL,
 CONSTRAINT pk_pandemic PRIMARY KEY (iso3, ddate),
 CONSTRAINT fk_pandemic_iso3 FOREIGN KEY (iso3) REFERENCES Country (iso3)
);

-- 2.2

SELECT table_name
FROM user_tables
ORDER BY table_name ASC;

-- 2.3
-- 2.4

-- 2.5

SELECT * FROM Continent;
SELECT * FROM Region;
SELECT * FROM Country;
SELECT * FROM Border;
SELECT * FROM Pandemic;

-- 2.6


