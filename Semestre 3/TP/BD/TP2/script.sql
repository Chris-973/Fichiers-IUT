SELECT E.ne, J.prej, J.nomj, SUM(MA.point) AS NBP
FROM Joueur J, Marquer MA, Equipe E
WHERE J.ne = E.ne
AND MA.nj = J.nj
AND J.nj IN (
SELECT J.nj
FROM Joueur J, Marquer MA
WHERE MA.nj = J.nj
GROUP BY J.nj
HAVING SUM(MA.point) >= ALL (
SELECT SUM(MA.point)
FROM Joueur J, Marquer MA
WHERE MA.nj = J.nj
AND J.ne = E.ne
GROUP BY J.nj))
GROUP BY E.ne, J.prej, J.nomj;
