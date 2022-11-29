import stone.Stone;

public class Exo2 {
    public static void main(String[] args) {
        Stone bigStone = Stone.makeBigStone();
        System.out.println(bigStone.toString());
        bigStone.split();
        System.out.println(bigStone.toString());
        int i = 0;
        while (bigStone.diameter() >= 5){
            i++;
            bigStone.split();
            System.out.println("split n°" + i + " " + bigStone.toString());
        }
    }
}
