-- 1.1
CREATE OR REPLACE TRIGGER t_iu_composer_ci
AFTER INSERT OR UPDATE OF nm, nj
ON Composer
FOR EACH ROW
DECLARE
	vne  Joueur.ne%TYPE;
	vne1 Match.ne1%TYPE;
	vne2 Match.ne2%TYPE;
    pst1 Joueur.pst%TYPE;
    pst2 Joueur.pst%TYPE;
    pst3 Joueur.pst%TYPE;
    pst4 Joueur.pst%TYPE;

BEGIN
	SELECT ne INTO vne
	FROM Joueur
	WHERE nj = :NEW.nj;

	SELECT ne1, ne2 INTO vne1, vne2
	FROM Match
	WHERE nm = :NEW.nm;

    select pst INTO pst1
    from composer c, joueur j
    where j.nj = c.nj
    and maillot IN (1, 3);

    select pst INTO pst2
    from composer c, joueur j
    where j.nj = c.nj
    and maillot = 2;

    select pst INTO pst3
    from composer c, joueur j
    where j.nj = c.nj
    and maillot IN (4, 5);

    select pst INTO pst4
    from composer c, joueur j
    where j.nj = c.nj
    and maillot IN (6, 7, 8);

	IF (vne <> vne1) AND (vne <> vne2) THEN
		RAISE_APPLICATION_ERROR(-20000, 'ERREUR : Equipe du joueur ne participe pas au match !');
	END IF;

    IF (pst1 <> 'Pilier') THEN 
        RAISE_APPLICATION_ERROR(-20001, 'ERREUR : Le Joueur 1 ou 3 a le mauvais poste');
    END IF;

    IF (pst1 <> 'Talonneur') THEN 
        RAISE_APPLICATION_ERROR(-20002, 'ERREUR : Le Joueur 2 a le mauvais poste');
    END IF;

    IF (pst3 <> 'Deuxième ligne') THEN 
        RAISE_APPLICATION_ERROR(-20003, 'ERREUR : Le Joueur 4 ou 5 a le mauvais poste');
    END IF;

    IF (pst3 <> 'Troisième ligne') THEN 
        RAISE_APPLICATION_ERROR(-20004, 'ERREUR : Le Joueur 4 ou 5 a le mauvais poste');
    END IF;
END;