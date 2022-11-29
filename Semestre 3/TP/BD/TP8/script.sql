CREATE OR REPLACE TRIGGER MajClassement
 FOR INSERT OR UPDATE OR DELETE
 ON Match COMPOUND TRIGGER
...
AFTER STATEMENT IS
BEGIN
 -- Mise à jour des points
 FOR eq IN (SELECT * FROM Classement) LOOP
 UPDATE Classement
 SET pts = Gestion_Rugby.retournePointsAttribues(eq.nation)
 WHERE nation = eq.nation;
 END LOOP;
END AFTER STATEMENT;
END;
CREATE OR REPLACE TRIGGER MajClassement
    FOR INSERT OR UPDATE OR DELETE
    ON Match COMPOUND TRIGGER
...
AFTER STATEMENT IS
BEGIN
     -- Mise à jour des points
    FOR eq IN (SELECT * FROM Classement) LOOP
    UPDATE Classement
    SET pts = Gestion_Rugby.retournePointsAttribues(eq.nation)
    WHERE nation = eq.nation;
    END LOOP;
END AFTER STATEMENT;
END;
