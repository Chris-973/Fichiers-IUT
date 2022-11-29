package appli;

import hash.CMAHashTable;

public class Exo2 {



    public static void main(String[] args) {
        CMAHashTable<String, String> table = new CMAHashTable<String, String>();
        table.put("two","deux");
        table.put("four","quatre");

        System.out.println(table.get("two"));
        System.out.println(table.get("deux"));
        System.out.println(table.toString() );
    }
}
