import stone.Stone;

public class Exo1 {
    public static void main(String[] args) {
        Stone smallStone = Stone.makeSmallStone(); // Instantie une petite stone avec la méthode makeSmallStone()
        System.out.println(smallStone.toString());
        smallStone.split(); // Casse smallStone en deux
        System.out.println(smallStone.toString());
    }
}
