package hash.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import org.junit.Test;

public class PutSequence {

	public static <K, V> void put(OpenHashTable<K, V> h, K key, V value,
			V expectedPrevious) {
		int size_bef = h.size();
		V prev = h.put(key, value);
		if (expectedPrevious == null) {
			assertNull("When adding a new entry, put should return null", prev);
			assertEquals(
					"When adding a new entry, the size should be increased by one",
					size_bef + 1, h.size());
		} else {
			assertEquals(
					"When updating an entry, put should return the old value",
					expectedPrevious, prev);
			assertEquals(
					"When updating an entry, the size should be unchanged",
					size_bef, h.size());
		}
		h.check();
	}

	@Test
	public void run() {
		OpenHashTable<String, Integer> h = new OpenHashTable<>();
		put(h, "A", 1, null);
		put(h, "B", 2, null);
		put(h, "C", 1, null);
		put(h, "A", 4, 1);
		put(h, "A", 0, 4);
		put(h, "Hello", 9, null);
	}
}
