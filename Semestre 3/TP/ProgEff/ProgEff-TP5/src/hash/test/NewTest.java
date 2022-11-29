package hash.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNotSame;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

public class NewTest {

	OpenHashTable<?, ?> h;

	@Before
	public void setup() {
		h = new OpenHashTable<>();
	}

	@Test
	public void initialSizeIsZero() {
		assertEquals("The size of the new " + h.classUnderTest()
				+ " is invalid.", 0, h.size());
	}

	@Test
	public void initialTableIsNotNull() {
		assertNotNull("The table of the new " + h.classUnderTest()
				+ " should not be null.", h.table());
	}

	@Test
	public void initialTableCapacityIsFour() {
		assertEquals("The capacity of the table is invalid.", 4,
				h.table().length);
	}

	@Test
	public void initialTableCellsAreNotNull() {
		for (int i = 0; i < h.table().length; i++) {
			assertNotNull("The list at index " + i
					+ " of the table should not be null.", h.table()[i]);
		}
	}

	@Test
	public void initialTableCellsAreEmpty() {
		for (int i = 0; i < h.table().length; i++) {
			assertTrue("The list at index " + i
					+ " of the table should be empty.", h.table()[i].isEmpty());
		}
	}

	@Test
	public void initialTableCellsAreDistinct() {
		assertNotSame(
				"First and second table cells should not reference the same list",
				h.table()[0], h.table()[1]);
	}
}
