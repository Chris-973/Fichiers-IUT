SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE Gestion_Rugby IS
    FUNCTION retournePointsMarques (p_nome Equipe.nome%TYPE) RETURN NUMBER;
    FUNCTION retournePointsAttribues (p_nome Equipe.nome%TYPE) RETURN NUMBER;
    PROCEDURE classement;
END;

CREATE OR REPLACE PACKAGE BODY Gestion_Rugby IS
    FUNCTION retournePointsMarques (p_nome Equipe.nome%TYPE) RETURN NUMBER IS
        nbPointsMarques NUMBER;
        numEquipe Equipe.ne%TYPE;
    BEGIN
        SELECT ne INTO numEquipe FROM Equipe WHERE nome = p_nome;
        SELECT SUM(POINT) INTO nbPointsMarques FROM Marquer WHERE nj IN (
                                SELECT nj FROM Joueur WHERE ne = numEquipe);
        RETURN nbPointsMarques;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Equipe inconnue.');
    END;

    FUNCTION retournePointsAttribues (p_nome Equipe.nome%TYPE) RETURN NUMBER IS
        nbPointsAttribues NUMBER := 0;
        nbVictoires NUMBER := 0;
        nbEssais NUMBER := 0;
        numEquipe Equipe.ne%TYPE;
        CURSOR C_matchs_equipe IS (SELECT M.nm, M.ne2, M.scr1 as scre, M.scr2 as scra
                                    FROM Match M
                                    WHERE M.ne1 = numEquipe
                                    UNION
                                    SELECT M.nm, M.ne1, M.scr2 as scre, M.scr1 as scra
                                    FROM Match M
                                    WHERE M.ne2 = numEquipe);
    BEGIN
        SELECT ne INTO numEquipe FROM Equipe WHERE nome = p_nome;
        FOR ligne IN C_matchs_equipe LOOP
            IF ligne.scre > ligne.scra THEN
                nbPointsAttribues := nbPointsAttribues + 4;
                nbVictoires := nbVictoires + 1;
            ELSIF ligne.scre = ligne.scra THEN
                nbPointsAttribues := nbPointsAttribues + 2;
            ELSIF ligne.scre < ligne.scra AND (ligne.scra - ligne.scre) <= 8 THEN
                nbPointsAttribues := nbPointsAttribues + 1;
            END IF;
            SELECT COUNT(*) INTO nbEssais FROM MARQUER WHERE NM = ligne.NM
                AND ACTION = 'Essais' AND nj IN (SELECT nj FROM Joueur WHERE ne = numEquipe);
            IF nbEssais >= 4 THEN
                nbPointsAttribues := nbPointsAttribues + 1;
                nbEssais := 0;
            END IF;
        END LOOP;
        IF nbVictoires = 5 THEN
            nbPointsAttribues := nbPointsAttribues + 3;
        END IF;
        RETURN nbPointsAttribues;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Equipe inconnue.');
    END;

    PROCEDURE classement IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nation        PA      PM');
        FOR ligne IN (SELECT nome, retournePointsMarques(nome) as pm, retournePointsAttribues(nome) as pa
                      FROM Equipe ORDER BY pa DESC) LOOP
            DBMS_OUTPUT.PUT_LINE(ligne.nome || '        ' || ligne.pa || '      ' || ligne.pm);
        END LOOP;
    END;
END;


-- 2
--      RPM
-- Cas nominal
SELECT Gestion_Rugby.retournePointsMarques('France') FROM dual;
-- Cas d'erreur
SELECT Gestion_Rugby.retournePointsMarques('Francia') FROM dual;

--      RPA
-- Cas nominal
SELECT Gestion_Rugby.retournePointsAttribues('France') FROM dual;
-- Cas d'erreur
SELECT Gestion_Rugby.retournePointsAttribues('Francia') FROM dual;

-- 3
EXEC Gestion_Rugby.classement;