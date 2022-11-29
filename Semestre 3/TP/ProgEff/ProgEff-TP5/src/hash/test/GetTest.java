package hash.test;

import hash.CMAHashTable;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class GetTest {

	CMAHashTable<String, String> h;

	@Before
	public void setup() {
		h = new CMAHashTable<>();
	}

	@Test
	public void emptyTableGivesNull() {
		assertNull("Getting a key from an empty table should return null",
				h.get("Hello"));
	}

	@Test
	public void absentKeyGivesNull() {
		h.put("Hello", "World");
		assertNull("Getting an absent key should return null", h.get("World"));
	}

	@Test
	public void identicalKeyGivesTheValue() {
		String k = "Here";
		String v = "we are!";
		h.put(k, v);
		assertEquals(v, h.get(k));
	}

	@Test
	public void equalKeyGivesTheValue() {
		String k1 = "Why";
		String k2 = new String(k1);
		String v = "not";
		assertNotSame(k1, k2);
		assertEquals(k1, k2);
		h.put(k1, v);
		assertEquals(v, h.get(k2));
	}

	@Test
	public void negativeHashCodeFound() {
		String k = "Supercalifragilisticexpialidocious";
		String v = "Mary Poppins";
		h.put(k, v);
		assertEquals(v, h.get(k));
	}

}
