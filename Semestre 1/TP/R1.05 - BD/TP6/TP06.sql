------------------------------------------------------------------
-- TP#06 LID Projection et Sélection
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Requêtes
------------------------------------------------------------------

-- 1 
SELECT *
FROM Continent;

-- 2
SELECT name AS nom, area AS superficie
FROM Continent;

-- 3
SELECT iso3, name
FROM Country
WHERE cname = 'Europe';

-- 4
SELECT iso3, name AS "Nom du Pays"
FROM Country
WHERE cname = 'Europe'
ORDER BY name;

-- 5
SELECT iso3, name
FROM Country
WHERE rcode = '155'
ORDER BY population DESC

-- 6a
SELECT iso3, name
FROM Country
WHERE rcode = '155'
   OR rcode = '154';

-- 6b
SELECT iso3, name
FROM Country
WHERE rcode IN ('155', '154');

-- 7
SELECT iso3, name
FROM Country
WHERE area > 10000
  AND population > 100000000;

-- 8a
SELECT iso3, name
FROM Country
WHERE area > 10000
  AND population >= 100000000
  AND population <= 200000000;

-- 8b
SELECT iso3, name
FROM Country
WHERE area > 10000
  AND population BETWEEN 100000000 AND 200000000;

-- 9
SELECT iso3, name, capital
FROM Country
WHERE UPPER(capital) LIKE '%PA%';

-- 10
SELECT iso3, name, capital
FROM Country
WHERE UPPER(capital) LIKE '%PAR%'
   OR UPPER(capital) LIKE '%POR%';

-- 11
SELECT iso3, name
FROM Country
WHERE UPPER(iso3) = SUBSTR(UPPER(name),1,3);

-- 12
SELECT iso3, name
FROM Country
WHERE capital IS NULL;

-- 13
SELECT iso3, icu
FROM Pandemic
WHERE ddate = '30/03/2020'
  AND ICU IS NOT NULL;

-- 14
SELECT DISTINCT iso3
FROM Pandemic
WHERE TO_CHAR(ddate,'YYYY') = '2020'
  AND icu > 5000;

-- Autre version possible
SELECT DISTINCT iso3
FROM Pandemic
WHERE ddate >= '01/01/2020'
  AND ddate <= '31/12/2020'
  AND icu > 5000;

-- 15
SELECT DISTINCT iso3
FROM Pandemic
WHERE TO_CHAR(ddate,'YYYY') = '2020'
  AND (icu > 5000 OR rrate > 3);

