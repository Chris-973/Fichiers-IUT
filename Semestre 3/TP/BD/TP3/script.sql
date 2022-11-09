
-- Equipe 1 inconnue (avec message distinct suivant l’équipe inconnue)
SET SERVEROUTPUT ON;
EXEC ajoutermatch(1, '01/01/01', 'Stade de France', 'Paris', 'Sean', 'Escassut', 'TUV', 'SCO');

-- Equipe 2 inconnue (avec message distinct suivant l’équipe inconnue)
SET SERVEROUTPUT ON;
EXEC ajoutermatch(1, '01/01/01', 'Stade de France', 'Paris', 'Sean', 'Escassut', 'SCO', 'TUV');

-- Equipe se rencontre déjà dans un autre match (exécuté après cas nominal)
SET SERVEROUTPUT ON;
EXEC ajoutermatch(1, '01/01/01', 'Stade de France', 'Paris', 'Sean', 'Escassut', 'ENG', 'SCO');

-- Equipe ne peut pas jouer contre elle-même
SET SERVEROUTPUT ON;
EXEC ajoutermatch(1, '01/01/01', 'Stade de France', 'Paris', 'Sean', 'Escassut', 'ENG', 'ENG');
