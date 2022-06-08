------------------------------------------------------------------
-- TP#09 LID Agrégation
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Requêtes 
------------------------------------------------------------------

-- 1a
SELECT COUNT(name) AS nbc
FROM Continent;

-- 1b
SELECT COUNT(DISTINCT cname) AS nbc
FROM Country;

-- On obtient un résultyat différent car il y a un cotinent supplémentaire qui n'a pas de pays.

-- 2
SELECT cname, COUNT(iso3) AS nbp
FROM Country
GROUP BY cname;

-- 3
SELECT Continent.name, COUNT(iso3) AS nbp
FROM Continent, Country
WHERE Continent.name = Country.cname (+)
GROUP BY Continent.name;

-- 4
SELECT COUNT(Continent.name) AS nbc
FROM Continent, Country
WHERE Continent.name = Country.cname (+)
  AND Country.cname IS NULL;

-- 5
SELECT Continent.name, COUNT(iso3) AS nbp
FROM Continent, Country
WHERE Continent.name = Country.cname (+)
  AND Continent.name LIKE 'A%'
GROUP BY Continent.name;

-- 6
SELECT Continent.name, COUNT(iso3) AS nbp, MAX(population) AS max_pop, MIN(population) AS min_pop
FROM Continent, Country
WHERE Continent.name = Country.cname (+)
GROUP BY Continent.name;

-- 7
SET PAGESIZE 1000;

SELECT C.iso3, name, COUNT(bcountry) AS nbf
FROM Country C, Border B
WHERE C.iso3 = B.country
GROUP BY C.iso3, name
ORDER BY nbf DESC;

-- 8
SELECT C.iso3, name, COUNT(bcountry) AS nbf
FROM Country C, Border B
WHERE C.iso3 = B.country
GROUP BY C.iso3, name
HAVING COUNT(bcountry) >= 5
ORDER BY nbf DESC;

-- 9
SELECT cname, AVG(area) AS sup
FROM Country
WHERE population > 1000000
GROUP BY cname;

-- 10
SELECT cname, AVG(area) AS sup
FROM Country C, Border B
WHERE C.iso3 = B.country
  AND population > 1000000
GROUP BY cname
HAVING COUNT(bcountry) >= 5;

-- 11
SELECT name, SUM(length) AS longueur 
FROM Country C, Border B
WHERE C.iso3 = B.country
  AND cname = 'Europe'
GROUP BY name
HAVING SUM(length) > 3000;

-- 12
SELECT name, SUM(length) AS longueur, COUNT(bcountry) AS nbp
FROM Country C, Border B
WHERE C.iso3 = B.country
  AND cname = 'Europe'
GROUP BY name
HAVING SUM(length) > 3000
   AND COUNT(bcountry) > 10;


