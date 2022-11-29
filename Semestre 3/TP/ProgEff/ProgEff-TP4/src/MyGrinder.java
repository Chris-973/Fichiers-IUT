import stone.Grinder;
import stone.Stone;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class MyGrinder implements Grinder {

    @Override
    public Collection<Stone> grind(Stone stone, int diameter) {
        List<Stone> fragementStone = new ArrayList<>(); // Création d'une collection de fragement de stone
        fragementStone.add(stone);

        Stone pierre;

        for(int i = 0; i < fragementStone.size(); i++){
            while(fragementStone.get(i).diameter() > diameter){
                
                fragementStone.add(fragementStone.get(i).split());
            }
        }
        return fragementStone; // on return la liste des fragement
    }
}
