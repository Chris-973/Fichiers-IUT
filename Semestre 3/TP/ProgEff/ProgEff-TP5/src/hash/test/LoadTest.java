package hash.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class LoadTest {

	@Test
	public void run() {
		OpenHashTable<String, Integer> h = new OpenHashTable<>();
		for (int i = 1; i < 1000; i++) {
			h.put(String.valueOf(i), i);
			assertEquals("Bad size", i, h.size());
			h.check();
			double load = (h.size() * 100.) / h.table().length;
			assertTrue("Table reached " + load + "% after " + i
					+ " values added", load < 80.);
		}
	}

}
