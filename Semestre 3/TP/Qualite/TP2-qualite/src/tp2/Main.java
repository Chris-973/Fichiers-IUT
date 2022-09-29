package tp2;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class Main {
public static void main(String[] args) {
	StrLen str;
	str = new StrLen();
	
	
	List<String> reference = Arrays.asList("z", "ccc", "aa");
	
	List<String> li = Arrays.asList("a", "bb", "c", "dd", "e", "ff");
	int res = StrLen.mostFrequent(li);
	System.out.println(res);
	
	
	
}
}
