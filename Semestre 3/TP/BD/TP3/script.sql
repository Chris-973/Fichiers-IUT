CREATE OR REPLACE PROCEDURE AjouterMatch 
(
-- ex : p_prea Arbitre.prea%TYPE,
p_jrn Match.jrn%TYPE,
p_dtm Match.dtm%TYPE,
p_stade Match.stade%TYPE,
p_ville Match.ville%TYPE,
p_prea Match.prea%TYPE,
p_noma Match.noma%TYPE,
p_ne1 Match.ne1%TYPE,
p_ne2 Match.ne2%TYPE
) 

IS

pb_check exception;
pb_pk exception;
pb_unique exception;

BEGIN
    INSERT INTO Match (jrn, dtm, stade, ville, prea, noma, ne1, ne2)
    VALUES (p_jrn, p_dtm, p_stade, p_ville, p_prea, p_noma, p_ne1, p_ne2)
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Match inséré.');

EXCEPTION   
    WHEN pb_check THEN
        IF(SQLERRM LIKE '%CK_MATCH_NE1_NE2%') THEN
            DBMS_OUTPUT.PUT_LINE('Une équipe ne peut pas jouer contre elle même.');
        END IF; 
    WHEN pb_unique THEN
        IF() THEN 
        END IF; 
    WHEN pb_pk THEN 
        IF(SQLERRM LIKE '%FK_MATCH_ARBITRE') THEN
            DBMS_OUTPUT.PUT_LINE('L''arbitre est inexistante');  
        END IF; 

END; 