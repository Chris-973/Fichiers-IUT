package tp1;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;

/**
 * Utility class for dictionaries. This class offers static methods for
 * manipulating objects of type Map.
 * 
 */
public class MapUtils {

	/**
	 * Exchange the values attached to two given keys.
	 * 
	 * @param dict
	 *            the dictionary where the exchange is performed
	 * @param k1
	 *            one key
	 * @param k2
	 *            another key
	 * @throws IllegalArgumentException
	 *             if any of the two keys is not in the dictionary.
	 */
	public static <K, V> void exchange(Map<K, V> dict, K k1, K k2) {
		if (!dict.containsKey(k1) || !dict.containsKey(k2))
			throw new IllegalArgumentException("Absent key");
		V v1 = dict.get(k1);
		V v2 = dict.get(k2);
		dict.put(k1, v2);
		dict.put(k2, v1);
	}

	/**
	 * Construct a dictionary from a list of strings representing the key-value
	 * pairs. Each string must be of the form "key:value" where key and value
	 * contains no ":".
	 * 
	 * @param pairs
	 *            a list of strings, each representing a pair
	 * @return the corresponding dictionary.
	 * @throws IllegalArgumentException
	 *             if any of the strings is not well-formed.
	 */
	public static Map<String, String> ofPairList(List<String> pairs) {
		// TODO: exercise 2
		return null;
	}

	/**
	 * Return the list of keys that map to a given value.
	 * 
	 * @param dict
	 *            the dictionary where to search
	 * @param value
	 *            the value to search
	 * @return the list of keys mapping to that value.
	 */
	public static <K, V> List<K> selectByValue(Map<K, V> dict, V value) {
		// TODO: exercise 3
		return null;
	}

	/**
	 * Remove the pairs where the key is equal to the value.
	 * 
	 * @param dict
	 *            the dictionary where to remove the pairs
	 */
	public static <T> void removeEquals(Map<T, T> dict) {
		// TODO: exercise 4
	}

	/**
	 * Compute the number of time that each element appears in a list.
	 * The result is given as a dictionary binding elements to number of appearance.
	 *
	 * @param list
	 * 		      the list where to count
	 * @return a dictionary associating to each element of the list the number of times it appears in the list.
	 */
	public static <E> Map<E, Integer> frequency(List<E> list) {
		// TODO: exercise 5
		return null;
	}

	/**
	 * Invert a dictionary by computing a new dictionary where the keys are the old values and the values are
	 * lists of old keys.
	 *
	 * @param dict
	 *            the dictionary to revert
	 * @return a new dictionary, inverse of the input one.
	 */
	public static <K, V> Map<V, List<K>> invert(Map<K, V> dict) {
		// TODO: exercise 6
		return null;
	}

	/**
	 * Merge the input dictionaries together.
	 * If a key is bound in both dictionaries, the associated values are combined using the combination function.
	 * @param d1
	 *            the first dictionary
	 * @param d2
	 *            the second dictionary
	 * @param combine
	 *            the combination function (optional)
	 * @return a new dictionary merge the input dictionaries.
	 * @throws IllegalArgumentException
	 *             if a key is in both dictionaries and no combination function is provided.
	 */
	public static <K, V> Map<K, V> merge(Map<K, V> d1, Map<K, V> d2,
			BiFunction<V, V, V> combine) {
		// TODO: exercise 7
		return null;
	}
}
