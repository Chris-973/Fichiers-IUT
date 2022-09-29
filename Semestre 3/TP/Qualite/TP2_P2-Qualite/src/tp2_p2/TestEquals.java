package tp2_p2;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class TestEquals {

	public static void main (String args[]) {
		/*
		
		List<String> li = Arrays.asList("a", "bb", "c", "dd", "e", "ff", "bb");
		
		System.out.println("Tests for List<String>:");
		System.out.println(li.contains("a"));
		System.out.println(li.contains("ff"));
		System.out.println(li.contains("c"));
		System.out.println(li.contains("ZZZ"));
		
		System.out.println(li.indexOf("ff"));
		System.out.println(li.indexOf("FF"));
		
		System.out.println(li.lastIndexOf("bb"));
		System.out.println(li.lastIndexOf("a"));
		System.out.println(li.lastIndexOf("BB"));
		
		
		*/
		
		
		
		/*
		 Q.b / Sans lancer le code : que pensez vous que vont afficher les lignes situées sous "Tests for List<String>:" ?
		 	
		 	Je pense ques les lignes situés sous "Tests for List<String>:" seront :
		 		- true
		 		- true
		 		- true
		 		- false
		*/
		
		
		List<Person> lp = Arrays.asList(
				new Person ("a", "a"),
				new Person ("bb", "bb"),
				new Person ("c", "c"),
				new Person ("dd", ""),
				new Person ("e", "e"),
				new Person ("ff", "ff")
				);
		
		System.out.println("Tests for List<Person>:");
		System.out.println(lp.contains(new Person("a", "a")));
		System.out.println(lp.contains(new Person("ff", "ff")));
		System.out.println(lp.contains(new Person("c", "c")));
		System.out.println(lp.contains(new Person("ZZZ", "ZZZ")));
		
		/*
		 	Q.1 : Sans lancer le code : que pensez vous que vont afficher les lignes situées sous "Tests for List<Person>:" :
		 		Je pense que les lignes que seront afficher en dessous de "Tests for List<Person>:" seront :
		 			- true
		 			- true
		 			- true
		 			- false
		*/
		
		
		List<String> li2 = Arrays.asList("a", "bb", "c", "dd", "e", "ff");
		List<Person> lp2 = Arrays.asList(
				new Person ("a", "a"),
				new Person ("bb", "bb"),
				new Person ("c", "c"),
				new Person ("dd", ""),
				new Person ("e", "e"),
				new Person ("ff", "ff")
				);
		System.out.println("Tests equals:");
		System.out.println(li2.equals(li2));
		System.out.println(lp.equals(lp2));
		
	}
}
