package tp2;

import java.util.ArrayList;
import java.util.List;

import com.sun.org.apache.xerces.internal.xs.StringList;

/**
 * A class offering static methods for processing list of strings according to
 * the length of the strings.
 */
public class StrLen {

	/**
	 * Returns the first longest String found in strList.
	 * 
	 * @param strList	the list of strings
	 * @return	longest String, "" if strList is empty
	 */
	public static String longestString (List<String> strList) {

		int taille = strList.size();

		if(strList.size() == 0){
			return "";
		}

		String longest = strList.get(0);

		for(int i = 0; i < taille; i++) {
			if(strList.get(i).length() > longest.length()) {
				longest = strList.get(i);
			}
		}

		return longest;
	}


	/**
	 * Checks if all elements of strList are in strListContaining. The reverse condition is nor checked.
	 * 
	 * @param strList	List of searched elements
	 * @param strListContaining	List in which check is done
	 * @return true if all elements of strList are in strListContaining
	 */
	public static boolean isIncluded (List<String> strList, List<String> strListContaining) {
		int taille1 = strList.size();
		int taille2 = strListContaining.size();
		int cpt = 0;

		if(taille1 > taille2) {
			return false;
		}

		for(int i = 0; i < taille2; i++) {
			for (int j = 0; j < taille1; j++){
				if(strList.get(j).equals(strListContaining.get(i))) {
					cpt++;
				}
			}

		}

		if(cpt == taille1) {
			return true;
		} else {
			return false;
		}
	}


	/**
	 * Checks if each elements of strList is in strListContaining at the same index.
	 * It returns a List of "T"/"F" strings indicating for each index if it is equal or not.
	 * 
	 * @param strList	List of searched elements
	 * @param strListContaining	List in which check is done
	 * @return a List of String "T"/"F" indicating for each index i
	 * 		if string at index i in strList equals ("T") string at index i in strListContaining or not ("F")
	 */
	public static List<String> indexAreIdentical (List<String> strList, List<String> strListContaining) {
		int taille1, taille2;

		taille1 = strList.size();
		taille2 = strListContaining.size();
		List<String> result = new ArrayList<String>();
		
		
		
		for(int i = 0; i < taille1; i++) {
			if(taille2 > i &&  strList.get(i).equals(strListContaining.get(i))) {
				result.add("T");
			} else {
				result.add("F");
			}

		}

		return result;
	}


	/**
	 * Select in a list of the strings the ones having a length greater or equal
	 * to a minimal length.
	 * 
	 * The order of the elements in the selection respect the initial order.
	 * 
	 * @param strList
	 *            the list of strings
	 * @param minLen
	 *            the minimal length
	 * @return A new list of strings, containing the strings long enough.
	 */
	public static List<String> selectLong(List<String> strList, int minLen) {

		int taille = strList.size();
		List<String> result = new ArrayList<String>();
		
		for (int i = 0; i < taille; i++) {
			if(strList.get(i).length() >= minLen) {
				result.add(strList.get(i));
			}
		}
		
		return result;
	}

	/**
	 * Remove from a list of strings the strings strictly longer than a maximal
	 * length.
	 * 
	 * @param strList
	 *            the list of strings
	 * @param maxLen
	 *            the maximal length
	 */
	public static void removeLong(List<String> strList, int maxLen) {
		int taille = strList.size();
		for(int i = 0; i < taille; i++) {
			if(strList.get(i).length() > maxLen) {
				strList.remove(i--);
				taille --;
			}
		}
	}

	/**
	 * Truncate the strings in a list of strings to a maximal length. The string
	 * shorter than this length are not modified.
	 * 
	 * @param strList
	 *            the list of strings
	 * @param maxLen
	 *            the maximal length
	 */
	public static void truncate(List<String> strList, int maxLen) {
		int taille = strList.size();
		for(int i = 0; i < taille; i++) {
			if(strList.get(i).length() > maxLen) {
				String result = strList.get(i).substring(0, maxLen);
				strList.set(i, result);
			}
		}
	}

	/**
	 * Returns a copy of a list of strings, sorted by increasing length. The
	 * sort algorithm is stable.
	 * 
	 * @param strList
	 *            the list of strings
	 * @return A copy sorted by increasing length.
	 */
	public static List<String> increasingLength(List<String> strList) {

		return null;
	}

	/**
	 * Determines the most frequent string length in a list of strings. If
	 * several string length are tie, the highest one is returned.
	 * 
	 * @param strList
	 *            the list of strings
	 * @return The most frequent string length.
	 */
	public static int mostFrequent(List<String> strList) {

		return 0;
	}

}
