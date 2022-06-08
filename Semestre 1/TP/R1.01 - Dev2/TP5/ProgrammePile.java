class Pile {

  public String elements[]  ;
  public int indiceSommet = -1 ;

  /* Constructeurs */
  Pile(){
	elements = new String[100];
  }
  Pile(int pfTaille){
	elements = new String[pfTaille] ;
  }
} // fin class



public class ProgrammePile {

  public static boolean estVide(Pile pfPile) { return(pfPile.indiceSommet == -1); }
  
  public static void empiler(Pile pfPile, String pfElement) throws Exception {
    if ( pfPile.indiceSommet >= (pfPile.elements.length - 1) ) { throw new Exception("Erreur: Pile pleine"); }
    pfPile.indiceSommet = pfPile.indiceSommet + 1 ;
    pfPile.elements[pfPile.indiceSommet] = pfElement ;
  }
  
  public static void depiler(Pile pfPile) throws Exception {
    if ( estVide(pfPile) ) { throw new Exception("Erreur: Pile vide"); }
    pfPile.indiceSommet = pfPile.indiceSommet - 1 ;
  }
  
  public static String sommet(Pile pfPile) throws Exception {
    if ( estVide(pfPile) ) { throw new Exception("Erreur: Pile vide"); }
    return(pfPile.elements[pfPile.indiceSommet]);
  }
  
  /* Operations supplémentaires */
  
  public static String toString(Pile pfPile) {
    String resultat = "|vide" ;
    for (int indice = 0; indice <= pfPile.indiceSommet ; indice = indice + 1){
	resultat = "|" + pfPile.elements[indice] + resultat ;
    }
    return(resultat);
  }
  
  public static int nbElements(Pile pfPile) {
    return(pfPile.indiceSommet + 1);
  } 
  
  
  
  
  public static void main(String[] args) {
   Pile pile = new Pile() ;
    try {
		empiler(pile,"111") ;
		empiler(pile,"222") ;
		 
		empiler(pile,"A");
		empiler(pile,"B");

	}catch (Exception e) { System.out.println("Erreur : "+e.getMessage()); }; 
     System.out.println(toString(pile));

     
  } // fin main
  
} // fin class
