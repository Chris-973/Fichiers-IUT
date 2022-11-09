CREATE OR REPLACE PROCEDURE afficherJoueur 
(
    Vnomj Joueur.nomj%TYPE,
    Vprej Joueur.prej%TYPE,
    Vposte Joueur.pst%TYPE
    Vdate Match.dtm%TYPE,
    Vstade Match.stade%TYPE,
    Vville Match.ville%TYPE
) IS
-- variables

BEGIN
-- instructions
Select j.nj, j.prej, j.pst, m.date, m.stade, m.ville into Vnomj, Vprej, Vposte, Vdate, Vstade, Vstade, Vville
from Joueur j, Match m
where   
    and 
if() then
    DBMS_OUTPUT.PUT_LINE('Joueur #' ||Vposte ||'le '||Vdate ||'à '||stade||', '||ville);
else
    ...
end if
for leMatch in C_match_joueur_titu loop

end loop;
if() then 

else 

end if
EXCEPTION
-- instructions en cas d’erreur
when NO_DATA_FOUND then 
when Joueur_pas_titu then 

END; 