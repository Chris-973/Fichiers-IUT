package tp1.tests;

import org.junit.Test;
import tp1.MapUtils;

import java.util.*;

import static org.junit.Assert.assertEquals;

public class TestSelect {

	@Test
	public void testCore() {
		Map<String, String> dict = new HashMap<>();
		dict.put("UA", "not funny");
		dict.put("PrEf", "funny");
		dict.put("IUT", "funny");
		List<String> result = MapUtils.selectByValue(dict, "funny");
		List<String> expected = Arrays.asList("PrEf", "IUT");
		assertEquals(new HashSet<>(expected), new HashSet<>(result)); // Ignoring the order
	}

	@Test
	public void testSingle() {
		Map<String, String> dict = new HashMap<>();
		dict.put("UA", "not funny");
		dict.put("PrEf", "funny");
		dict.put("IUT", "funny");
		List<String> result = MapUtils.selectByValue(dict, "not funny");
		List<String> expected = Arrays.asList("UA");
		assertEquals(expected, result);
	}

	@Test
	public void testNone() {
		Map<String, String> dict = new HashMap<>();
		dict.put("UA", "not funny");
		dict.put("PrEf", "funny");
		dict.put("IUT", "funny");
		List<String> result = MapUtils.selectByValue(dict, "super funny");
		List<String> expected = Arrays.asList();
		assertEquals(expected, result);
	}

	@Test
	public void testComparison() {
		Map<String, String> dict = new HashMap<>();
		dict.put("UA", "not funny");
		dict.put("PrEf", "funny");
		dict.put("IUT", "funny");
		List<String> result = MapUtils.selectByValue(dict, new String(
				"not funny")); // Equal string, different reference
		List<String> expected = Arrays.asList("UA");
		assertEquals(expected, result);
	}

}
