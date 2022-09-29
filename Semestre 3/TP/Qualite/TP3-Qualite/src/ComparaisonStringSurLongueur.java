import java.util.Comparator;

public class ComparaisonStringSurLongueur implements Comparator<String>{
	
	/*
	 * Compare la longueur de deux chaînes de caractère
	 * @param str1 : la première chaine
	 * @param str2 : la seconde chaine
	 * @return -1 si str1 < str2, 0 si str1 = str2, 1 si str1 > str2
	 */
	@Override
	public int compare(String str1, String str2)  {
		int result = 0;
		
		if(str1.length() > str2.length()) {
			result = 1;
		}
		if(str1.length() == str2.length()) {
			result = 0;
		}
		if(str1.length() < str2.length()) {
			result = -1;
		}
		
		return result;
		
	}
}
