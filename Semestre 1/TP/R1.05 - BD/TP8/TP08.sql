------------------------------------------------------------------
-- TP#08 LID Jointure
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Requêtes avec auto-jointure
------------------------------------------------------------------

-- 1 
SELECT DISTINCT B1.country AS iso3
FROM Border B1, Border B2
WHERE B1.bcountry = 'FRA'
  AND B2.bcountry = 'ITA'
  AND B1.country = B2.country;

-- ou
SELECT DISTINCT B1.bcountry AS iso3
FROM Border B1, Border B2
WHERE B1.country = 'FRA'
  AND B2.country = 'ITA'
  AND B1.bcountry = B2.bcountry;
  
-- 2
SELECT DISTINCT C.name, C.capital
FROM Country C, Border B1, Border B2
WHERE B1.bcountry = 'FRA'
  AND B2.bcountry = 'ITA'
  AND B1.country = B2.country
  AND B1.country = C.iso3;
 
-- 3
SELECT DISTINCT C2.iso3, C2.name
FROM Country C1, Border B1, Country C2
WHERE C1.cname = 'Europe'
  AND C1.iso3 = B1.country
  AND C2.cname = 'America'
  AND C2.iso3 = B1.bcountry;
  
-- 4
SET PAGESIZE 1000;
COLUMN rrate FORMAT 99.99;

SELECT DISTINCT P1.ddate, P1.rrate
FROM Pandemic P1, Country C1, Pandemic P2, Country C2
WHERE C1.name = 'France'
  AND C1.iso3 = P1.iso3
  AND C2.name = 'Germany'
  AND C2.iso3 = P2.iso3
  AND P1.rrate = P2.rrate
  AND P1.ddate = P2.ddate
ORDER BY P1.ddate;
  
------------------------------------------------------------------
-- 2	Requêtes avec thêta-jointure
------------------------------------------------------------------

-- 1 
SELECT C2.iso3, C2.name, C2.population
FROM Country C1, Country C2
WHERE C1.name = 'France'
  AND C2.cname = 'Europe'
  AND C2.population > C1.population;
  
-- 2
SELECT C2.iso3, C2.name, C2.area
FROM Country C1, Country C2
WHERE C1.name = 'Brazil'
  AND C2.name <> 'Brazil'
  AND C2.area >= C1.area;
 
-- 3
SELECT DISTINCT C.iso3, C.name
FROM Country C, Border B1, Border B2
WHERE C.iso3 = B1.country
  AND C.iso3 = B2.country
  AND B1.bcountry <> B2.bcountry  
  AND B1.length = B2.length;
  
-- 4
SELECT C2.iso3, C2.name, C2.expectancy
FROM Country C1, Country C2
WHERE C1.name = 'France'
  AND C1.iso3 <> C2.iso3
  AND C1.expectancy < C2.expectancy
ORDER BY C2.expectancy DESC;

------------------------------------------------------------------
-- 3	Requêtes avec jointure externe et anti-jointure
------------------------------------------------------------------

-- 1
SELECT C.name
FROM Continent C, Country P
WHERE C.name = P.cname (+)
  AND P.cname IS NULL;

-- 2
SELECT C.iso3, C.name
FROM Country C, Border B
WHERE C.iso3 = B.country (+)
  AND B.country IS NULL
ORDER BY C.iso3;

-- 3
COLUMN name FORMAT A32;

SELECT P.name, R1.name, R2.name
FROM Country P, Region R1, Region R2
WHERE P.rcode = R1.code
  AND R1.rcode = R2.code (+)
  AND P.cname = 'Africa'
ORDER BY P.name;


  
