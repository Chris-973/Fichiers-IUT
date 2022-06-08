------------------------------------------------------------------
-- TP#10 LID Agrégation
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Requêtes 
------------------------------------------------------------------

-- 1
SELECT cname, COUNT(iso3) AS nbp
FROM Country
GROUP BY cname
HAVING COUNT(iso3) > 30;

-- 2
SELECT cname
FROM Country
GROUP BY cname
HAVING COUNT(iso3) > 30;

-- 3
SELECT C.name, C.area
FROM Country Co, Continent C
WHERE Co.cname = C.name
GROUP BY C.name, C.area
HAVING COUNT(iso3) > 30;

-- 4
SELECT cname
FROM Country
WHERE population > 1000000
GROUP BY cname
HAVING COUNT(iso3) > 40;

-- 5
SELECT iso3, name
FROM Country Co, Border B
WHERE Co.iso3 = B.country
GROUP BY iso3, name
HAVING SUM(length) > 8000;

-- 6
SELECT Co.iso3, Co.name
FROM Country Co, Border B, Country Co2
WHERE Co.iso3 = B.country
  AND B.bcountry = Co2.iso3
  AND Co.cname = Co2.cname
GROUP BY Co.iso3, Co.name
HAVING SUM(length) > 8000;

-- 7
SELECT Co.iso3, Co.name
FROM Country Co, Border B, Country Co2
WHERE Co.iso3 = B.country
  AND B.bcountry = Co2.iso3
  AND Co.cname <> Co2.cname
  AND Co.cname = 'Europe'
GROUP BY Co.iso3, Co.name
HAVING COUNT(Co2.iso3) > 1;

-- 8
SELECT P.iso3, name, AVG(rrate) AS taux
FROM Pandemic P, Country C
WHERE P.iso3 = C.iso3
  AND TO_CHAR(ddate, 'YYYY') = '2020'
  AND cname = 'Europe'
GROUP BY P.iso3, name
ORDER BY taux DESC;

