-- 1.1
ALTER TABLE Equipe
ADD npt DECIMAL(3);

-- 1.2
UPDATE Equipe E
SET npt = (SELECT SUM(M.point)
 FROM Joueur J, Marquer M
 WHERE J.nj = M.nj
 AND J.ne = E.ne);

 -- 1.3 
 SELECT * FROM Equipe;

-- 1.4
CREATE OR REPLACE TRIGGER t_iud_marquer_maj_npt
AFTER INSERT OR DELETE OR UPDATE OF nj, point
ON Marquer
FOR EACH ROW
DECLARE
    vne Joueur.ne%TYPE;

BEGIN
    IF (INSERTING OR UPDATING) THEN
        SELECT ne INTO vne
        FROM Joueur
        WHERE nj = :NEW.nj;
        UPDATE Equipe
        SET npt = npt + :NEW.point
        WHERE ne = vne;
    END IF;
    IF (DELETING OR UPDATING) THEN
        SELECT ne INTO vne
        FROM Joueur
        WHERE nj = :OLD.nj;
        UPDATE Equipe
        SET npt = npt - :OLD.point
        WHERE ne = vne;
    END IF;
END;

-- 1.5
-- cas d'insert 
INSERT INTO Marquer (nm, tps, nj, action, point)
VALUES (15, '10', 108, 'Essais', 5);

-- cas de delete
DELETE FROM Marquer
WHERE tps = 10
    AND nj = 108;

-- cas d'update
    UPDATE Marquer
    SET nj = 14
    WHERE nm = 15
        AND nj = 116;

-- 2.1
ALTER TABLE Equipe
ADD nes DECIMAL(3);

--2.2
UPDATE Equipe E
SET nes = (SELECT SUM(M.point)
 FROM Joueur J, Marquer M
 WHERE J.nj = M.nj
 AND M.action = 'Essais'
 AND J.ne = E.ne);

 -- 2.3
 SELECT * 
 FROM Equipe;

 -- 2.4
CREATE OR REPLACE TRIGGER t_iud_marquer_maj_npt
AFTER INSERT OR DELETE OR UPDATE OF nj, point
ON Marquer
FOR EACH ROW
DECLARE
    vne Joueur.ne%TYPE;

BEGIN
    IF (INSERTING OR UPDATING) THEN
        SELECT ne INTO vne
        FROM Joueur
        WHERE nj = :NEW.nj;
        UPDATE Equipe
        SET npt = npt + :NEW.point, nes = nes + :NEW.point
        WHERE ne = vne; 
    END IF;
        IF (DELETING OR UPDATING) THEN
        SELECT ne INTO vne
        FROM Joueur
        WHERE nj = :OLD.nj;
        UPDATE Equipe
        SET npt = npt - :OLD.point, nes = nes - :OLD.point
        WHERE ne = vne;
    END IF;
END;

-- 2.5
-- cas d'insert 
INSERT INTO Marquer (nm, tps, nj, action, point)
VALUES (15, '28', 108, 'Essais', 5);

-- cas de delete
DELETE FROM Marquer
WHERE tps = 28
    AND nj = 108;

-- cas d'update
UPDATE Marquer
SET nj = 14
WHERE nm = 15
    AND nj = 116;