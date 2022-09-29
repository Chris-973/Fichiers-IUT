import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class TestSort {
	public static void main(String[] args) {
		TestSort ts = new TestSort();
		
		
		
		String ch1 = "Je suis Christopher";
		String ch2 = "Je suis pas Christopher";
		
		
		ts.test();
	}

	private void test() {
		List<String> li = Arrays.asList("aaa", "b", "AAA", "eee", "ffff", "g", "h", "i", "FF", "j", "k", "K", "A", "BBBBb");
		
		// ComparaisonStringMajMin c = new ComparaisonStringMajMin();
		
		li.sort(new Comparator<String> () {
			@Override
			public int compare(String str1, String str2) {
				int result = 0;
				
				str1 = str1.toUpperCase();
				str2 = str2.toUpperCase();
				
				if(str1.compareTo(str2) == 0) {
					result = 0;
				} else if(str1.compareTo(str2) > 1) {
					result = 1;
				} else if(str1.compareTo(str2) < 1) {
					result = -1;
				}
				
				return result;
			}
		});
		
		printList(li);
	}
	
	private void printList (List<String> l) {
		for (String s : l) {
			System.out.println(s);
		}
	}
	
	private class ComparaisonStringMajMin implements Comparator<String>{
		
		/*
		 * Compare alphabétiquement deux chaînes de caractère
		 * @param str1 : la première chaine
		 * @param str2 : la seconde chaine
		 * @return -1 si str1 < str2, 0 si str1 = str2, 1 si str1 > str2
		 */
		@Override
		public int compare(String str1, String str2)  {
			int result = 0;
			
			str1 = str1.toUpperCase();
			str2 = str2.toUpperCase();
			
			if(str1.compareTo(str2) == 0) {
				result = 0;
			} else if(str1.compareTo(str2) > 1) {
				result = 1;
			} else if(str1.compareTo(str2) < 1) {
				result = -1;
			}
			
			return result;
			
		}
	}
}
