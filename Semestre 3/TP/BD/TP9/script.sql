-- 1.1 :
CREATE VIEW V_Equipe_FR (NJ,PREJ,NOMJ,PST,CAP,NE)
AS SELECT * 
FROM Joueur
WHERE ne = 'FRA';

-- 1.2
select * 
FROM V_Equipe_FR;

-- 1.3
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

-- 1.4
INSERT INTO V_Equipe_FR (NJ,PREJ,NOMJ,PST,CAP,NE)
VALUES (seq_joueur.nextval, 'Killua', 'Gon', 'Centre', null, 'FRA');

-- 1.5
SELECT * 
FROM V_Equipe_FR
WHERE prej = 'Killua';

-- 2.1
CREATE OR REPLACE VIEW V_Equipe_FR (NJ,PREJ,NOMJ,PST,CAP,NE,POINTS)
AS SELECT j.nj, j.prej, j.nomj, j.pst, j.cap, j.ne, SUM(NVL(m.point, 0)) 
from marquer m, joueur j, equipe e
where j.ne = e.ne
    and j.nj = m.nj (+)
    and j.ne = 'FRA'
group by j.nj, j.prej, j.nomj, j.pst, j.cap, j.ne;

-- 2.2
select * 
FROM V_Equipe_FR;

-- 2.3
INSERT INTO V_Equipe_FR (NJ,PREJ,NOMJ,PST,CAP,NE,POINTS)
VALUES (seq_joueur.nextval, 'Killua', 'Gon', 'Centre', null, 'FRA', 17);

UPDATE V_Equipe_FR 
SET PST = 'Centre'
WHERE nj = 121;

DELETE FROM V_Equipe_FR 
WHERE nj = 121;

-- 3.1
CREATE OR REPLACE TRIGGER t_iof_iud_V_Equipe_FR
    INSTEAD OF INSERT OR DELETE OR UPDATE
    ON V_Equipe_FR
    FOR EACH ROW
DECLARE
    numEq JOUEUR.NE%TYPE;
BEGIN
    IF (INSERTING) THEN
        SELECT NE
        INTO numEq
        FROM EQUIPE
        WHERE EQUIPE.NOME = :NEW.nome;

        INSERT INTO JOUEUR (NJ, PREJ, NOMJ, PST, CAP, NE)
        VALUES (:NEW.num, :NEW.prenom, :NEW.nom, :NEW.poste, :NEW.cap, numEq);
    END IF;
    IF (UPDATING) THEN
        UPDATE JOUEUR
        SET NJ   = :NEW.num,
            PREJ = :NEW.prenom,
            NOMJ = :NEW.nom,
            PST  = :NEW.poste,
            CAP  = :NEW.cap
        WHERE NJ = :OLD.num;
    END IF;
    IF (DELETING) THEN
        DELETE FROM JOUEUR WHERE  Joueur.NJ = :OLD.num;
    END IF;
END;

-- 3.2.1
select * 
FROM V_Equipe_FR
WHERE PREJ = 'Killua';

INSERT INTO V_Equipe_FR (NJ,PREJ,NOMJ,PST,CAP,NE,POINTS)
VALUES (seq_joueur.nextval, 'Killua', 'Gon', 'Centre', null, 'FRA', 17);

select * 
FROM V_Equipe_FR
WHERE PREJ = 'Killua';

ROLLBACK;

select * 
FROM V_Equipe_FR
WHERE nj = '121';

UPDATE V_Equipe_FR 
SET PST = 'Centre'
WHERE nj = 121;

select * 
FROM V_Equipe_FR
WHERE nj = '121';

ROLLBACK;

select * 
FROM V_Equipe_FR
WHERE nj = '121';

DELETE FROM V_Equipe_FR 
WHERE nj = 121;

select * 
FROM V_Equipe_FR
WHERE nj = '121';

ROLLBACK;