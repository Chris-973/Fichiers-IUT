------------------------------------------------------------------
-- TP#07 LID Jointure
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Requêtes
------------------------------------------------------------------

-- 1 
SELECT C.*
FROM Continent C, Country P
WHERE C.name = P.cname
  AND P.name = 'France';
  
-- 2
SELECT C.*
FROM Continent C, Country P
WHERE C.name = P.cname
  AND (P.name = 'France'
   OR P.name = 'Australia');

-- 3
SELECT R.name
FROM Region R, Country P
WHERE R.code = P.rcode
  AND P.name = 'France';
  
-- 4
SELECT DISTINCT R.name
FROM Region R, Country P
WHERE R.code = P.rcode
  AND (P.name = 'France' OR P.name = 'Spain' OR P.name = 'Italy');

-- 5
SELECT P.name
FROM Region R, Country P
WHERE R.code = P.rcode
  AND R.name = 'Western Europe';

-- 6
SELECT name, capital
FROM Country
WHERE capital = name;

-- Il ne s'agit pas d'une jointure mais d'un sélection
-- En effet, nous comparons les valeurs de deux attibuts pour chaque tuple de la même table

-- 7
SELECT DISTINCT P.cname, R.name
FROM Country P, Region R
WHERE  R.name LIKE '%'||P.cname||'%'
ORDER BY P.cname;

-- Il s'agit bien d'une jointure entre la table Country et Region
-- En effet, nous comparons les valeurs de deux attributs de deux tables différentes 
-- dont les tuples sont combinés (produit cartésien)

-- 8
SELECT R2.name
FROM Region R1, Region R2, Country P
WHERE R1.rcode = R2.code
  AND R1.code = P.rcode
  AND P.name = 'Argentina';

-- 9
SELECT P.name, iso3, capital
FROM Region R1, Region R2, Country P
WHERE R1.rcode = R2.code
  AND R1.code = P.rcode
  AND R2.name = 'Latin America and the Caribbean'
ORDER BY P.name;

-- 10
SELECT name, iso3, iso2, capital
FROM Country, Border
WHERE country = 'FRA'
  AND bcountry = iso3;

-- 11
SELECT DISTINCT R.name
FROM Border, Country P, Region R
WHERE country = 'FRA'
  AND bcountry = iso3
  AND P.rcode = code;

-- 12
SET PAGESIZE 1000;

SELECT DISTINCT P2.name
FROM Region R, Country P1, Border B, Country P2
WHERE R.name = 'Western Europe'
  AND R.code = P1.rcode
  AND P1.iso3 = country
  AND bcountry = P2.iso3;

-- 13
SELECT DISTINCT R2.name
FROM Region R1, Country P1, Border B, Country P2, Region R2
WHERE R1.name = 'Western Europe'
  AND R1.code = P1.rcode
  AND P1.iso3 = country
  AND bcountry = P2.iso3
  AND P2.rcode = R2.code;

-- 14
COLUMN rrate FORMAT 99.99;

SELECT ddate, rrate
FROM Pandemic P, Country C
WHERE P.iso3 = C.iso3
  AND name = 'France'
  AND TO_CHAR(ddate,'YYYY') = '2020'
  AND rrate IS NOT NULL
ORDER BY ddate;

-- 15
SELECT P2.ddate, P2.rrate, P2.iso3
FROM Pandemic P1, Country C, Pandemic P2
WHERE P1.iso3 = C.iso3
  AND name = 'France'
  AND P1.ddate = P2.ddate
  AND P1.rrate = P2.rrate
  AND P2.iso3 <> 'FRA'
  AND TO_CHAR(P1.ddate,'YYYY') = '2020'
ORDER BY P2.ddate, P2.iso3;

