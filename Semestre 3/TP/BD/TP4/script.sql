-- 2.1
CREATE OR REPLACE PROCEDURE AjouterComposition
(
    VnumMatch Composer.nm%TYPE,
    Vnomj Joueur.nomj%TYPE,
    Vprej Joueur.prej%TYPE,
    Vmaillot Composer.maillot%TYPE
) IS

    fk_error Exception;
    PRAGMA Exception_init(fk_error, -2291);

    ck_error Exception;
    PRAGMA Exception_init(ck_error, -2290);

DECLARE 
    numeroJoueur int;
    
BEGIN
    -- récupère le joueur 
    SELECT c.NJ INTO numeroJoueur
    FROM COMPOSER c, JOUEUR j
    WHERE c.NJ = j.NJ
    AND j.NOMJ = Vnomj; 

    -- ajoute dans composition
    INSERT INTO Composer
    VALUES (VnumMatch, numeroJoueur, Vmaillot);
  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Composition d''un joueur insérée.');

EXCEPTION
    WHEN fk_error THEN
        if(SQLERRM LIKE '%FK_MATCH_NM%') then
            DBMS_OUTPUT.PUT_LINE('Le match n''existe pas');
        end if;
        if(SQLERRM LIKE '%FK_JOUEUR_NJ%') then
            DBMS_OUTPUT.PUT_LINE('Le joueur n''existe pas');
        end if;

    WHEN ck_error THEN
        if(SQLERRM LIKE '%CK_COMPOSER_MAILLOT%') then
            DBMS_OUTPUT.PUT_LINE('Le numéro de maillot est invalide');
        end if;

    WHEN DUP_VAL_ON_INDEX THEN 
            DBMS_OUTPUT.PUT_LINE('Le joueur est déjà enregistré pour ce match');

END;
--2.2

-- 2.3

-- 2.4