------------------------------------------------------------------
-- TP#04 Accès transactionnels la base de données (BD)
------------------------------------------------------------------

------------------------------------------------------------------
-- 1	Atomicité
------------------------------------------------------------------

-- 1 

INSERT INTO Continent (name, area)
VALUES ('IUT', NULL);

INSERT INTO Country (iso3, iso2, name, capital, rcode, cname)
VALUES ('UT2', 'U2', 'IUT de Blagnac', 'Blagnac', '155', 'IUT');

-- 2

SELECT *
FROM Continent
WHERE name = 'IUT';

SELECT *
FROM Country
WHERE iso3 = 'UT2';

-- 3

ROLLBACK;

-- 4

SELECT *
FROM Continent
WHERE name = 'IUT';

SELECT *
FROM Country
WHERE iso3 = 'UT2';

-- On constate que l'annulation de la transaction à annulé toutes la manipulations. 
-- La transaction est bien atomique, 
-- soit tout est validé, 
-- soit (ici) tout est annulé

------------------------------------------------------------------
-- 2	Durabilité
------------------------------------------------------------------

-- 1 

INSERT INTO Continent (name, area)
VALUES ('IUT', NULL);

INSERT INTO Country (iso3, iso2, name, capital, rcode, cname)
VALUES ('UT2', 'U2', 'IUT de Blagnac', 'Blagnac', '155', 'IUT');

SELECT *
FROM Continent
WHERE name = 'IUT';

SELECT *
FROM Country
WHERE iso3 = 'UT2';

COMMIT;

-- 2
-- 3

SELECT *
FROM Continent
WHERE name = 'IUT';

SELECT *
FROM Country
WHERE iso3 = 'UT2';

-- On constate que les données insérées ont été conservées 
-- La transaction qui a été validée est persistante, 
-- respectant ainsi le principe de durabilité

------------------------------------------------------------------
-- 3	Cohérence
------------------------------------------------------------------

-- 1

ALTER TABLE Country
DISABLE CONSTRAINT fk_country_cname;

-- 2

INSERT INTO Country (iso3, iso2, name, capital, rcode, cname)
VALUES ('UT3', 'U3', 'IUT de Rangueil', 'Toulouse', '155', 'XXX');

-- 3

COMMIT;

-- 4

ALTER TABLE Country
ENABLE CONSTRAINT fk_country_cname;

-- Il est impossible de réactiver la contrainte
-- La BD est dans un état incohérent par rapport à cette contrainte 
-- car un pays existe sans continent

-- 5 

DELETE FROM Country
WHERE iso3 = 'UT3';

-- 6

COMMIT;

ALTER TABLE Country
ENABLE CONSTRAINT fk_country_cname;

-- Cette fois il est possibnle de réactiver la contrainte
-- La BD est en effet dans un état cohérent par rapport à la contrainte réactrivée
-- puisque le tuple incohérent a été supprimé

------------------------------------------------------------------
-- 4	Isolation
------------------------------------------------------------------

------------------------------------------------------------------
-- 4.1	Accès en lecture/écriture
------------------------------------------------------------------

-- 1 Connexion #1

INSERT INTO Country (iso3, iso2, name, capital, rcode, cname) 
VALUES ('UT3', 'U3', 'IUT de Rangueil', 'Toulouse', '155', 'IUT');

INSERT INTO Country (iso3, iso2, name, capital, rcode, cname) 
VALUES ('UT1', 'U1', 'IUT de Rodez', 'Rodez', '155', 'IUT');

-- 2 Connexion #1

SELECT *
FROM Country
WHERE cname = 'IUT';

-- 3 Connexion #2

SELECT *
FROM Country
WHERE cname = 'IUT';

-- Les deux tuples insérés ne sont pas visible
-- La transaction de la connexion #1 est isolée 
-- et n'interfère donc pas avec la connexion #2

-- 4 Connexion #1

COMMIT;

-- 5 Connexion #2

SELECT *
FROM Country
WHERE cname = 'IUT';

-- La transaction de la connexion #1 ayant terminé (validée),
-- la transaction de la connexion #2 voit les 2 insertions 
-- qui correspondent donc à un état cohérent de la BD.

------------------------------------------------------------------
-- 4.2	Accès en écriture/écriture
------------------------------------------------------------------

-- 1 Connexion #1

SELECT *
FROM Country
WHERE cname = 'IUT';

DELETE FROM Country
WHERE iso3 = 'UT1';

-- 2 Connexion #1

UPDATE Country
SET capital = 'Rangueil'
WHERE iso3 = 'UT3';

-- 3 Connexion #2

DELETE FROM Country
WHERE iso3 = 'UT3';


-- La connexion #2 est mise en attente 
-- car elle accède en écriture à un tuple en cours d'de manipulation par la connexion #1
-- La transaction de la connexion #1 a vérrouillé les tuples
-- Elle bloque ainsi les autres transactions voulant y accéder en écriture

--------ISO IS NAME                                               CAPITAL                                            POPULATION       AREA EXPECTANCY RCO CNAME                         
----------- -- -------------------------------------------------- -------------------------------------------------- ---------- ---------- ---------- --- ------------------------------
--------UT2 U2 IUT de Blagnac                                     Blagnac                                                                             155 IUT                           
--CNX1--UT3 U3 IUT de Rangueil                                    Toulouse                                                                            155 IUT                           
--CNX1--UT1 U1 IUT de Rodez                                       Rodez                                                                               155 IUT                           

-- 4 Connexion #1

COMMIT;

-- La connexion  #1 qui se termine, libère les verrous
-- Cela permet à la transaction de la connexion #2 (qui était en attente) de se réaliser
-- Cette dernière verrouille à son tour le tuple

--------ISO IS NAME                                               CAPITAL                                            POPULATION       AREA EXPECTANCY RCO CNAME                         
----------- -- -------------------------------------------------- -------------------------------------------------- ---------- ---------- ---------- --- ------------------------------
--------UT2 U2 IUT de Blagnac                                     Blagnac                                                                             155 IUT                           
--CNX2--UT3 U3 IUT de Rangueil                                    Toulouse                                                                            155 IUT                           
--------UT1 U1 IUT de Rodez                                       Rodez                                                                               155 IUT                           

-- 5 Connexion #2

COMMIT;

-- 6 Connexion #2

SELECT *
FROM Country
WHERE cname = 'IUT';

------------------------------------------------------------------
-- 4.3	Gestion des inter-blocages
------------------------------------------------------------------

-- 1 Connexion #1

INSERT INTO Country (iso3, iso2, name, capital, rcode, cname) 
VALUES ('UT3', 'U3', 'IUT de Rangueil', 'Toulouse', '155', 'IUT');

-- 2 Connexion #1

COMMIT;

-- 3 Connexion #2

INSERT INTO Country (iso3, iso2, name, capital, rcode, cname) 
VALUES ('UT1', 'U1', 'IUT de Rodez', 'Rodez', '155', 'IUT'); 

-- 4 Connexion #2

COMMIT; 

-- 5 Connexion #2

UPDATE Country
SET capital = 'Capitole'
WHERE iso3 = 'UT1';

-- 6 Connexion #1

UPDATE Country
SET capital = 'Rangueil'
WHERE iso3 = 'UT3';

--------ISO IS NAME                                               CAPITAL                                            POPULATION       AREA EXPECTANCY RCO CNAME                         
----------- -- -------------------------------------------------- -------------------------------------------------- ---------- ---------- ---------- --- ------------------------------
--------UT2 U2 IUT de Blagnac                                     Blagnac                                                                             155 IUT                           
--CNX1--UT3 U3 IUT de Rangueil                                    Rangueil                                                                            155 IUT                           
--CNX2--UT1 U1 IUT de Rodez                                       Capitole                                                                            155 IUT                           

-- 7 Connexion #1

UPDATE Country
SET capital = 'Rodez'
WHERE iso3 = 'UT1';

-- La connexion #1 est mise en attente 
-- car elle accède en écriture à un tuple en cours d'de manipulation par la connexion #2
-- La transaction de la connexion #2 a vérrouillé le tuple
-- Elle bloque ainsi les autres transactions voulant y accéder en écriture

-- 8 Connexion #2

UPDATE Country
SET capital = 'Rangueil'
WHERE iso3 = 'UT3';

-- La connexion #2 est mise en attente 
-- car elle accède en écriture à un tuple en cours d'de manipulation par la connexion #1
-- La transaction de la connexion #1 a vérrouillé le tuple
-- Elle bloque ainsi les autres transactions voulant y accéder en écriture

-- ATTENTION ici nous avons donc un inter-blocage 
-- càd. les deux transactions se bloques l'une et l'autres
-- Le SGBD a détecté cette situation
-- Le SGBD a donc annulé automatiquement la transaction de la connexion #1 à l'origine de l'inter-blocage

-- 9 Connexion #1

COMMIT;

-- 10 COnnexion #2

COMMIT;





