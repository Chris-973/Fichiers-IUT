package tp1.tests;

import org.junit.Test;
import tp1.MapUtils;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.fail;

public class TestOfListException {

	@Test
	public void testTooFewColumns() {
		List<String> input = Arrays.asList("lol_mdr");
		Map<String, String> dict;
		try {
			dict = MapUtils.ofPairList(input);
		} catch (IllegalArgumentException e) {
			return;
		}
		fail("Expecting IllegalArgumentException, got: " + dict);
	}

	@Test
	public void testTooMuchColumns() {
		List<String> input = Arrays.asList("lol:mdr:kikou");
		Map<String, String> dict;
		try {
			dict = MapUtils.ofPairList(input);
		} catch (IllegalArgumentException e) {
			return;
		}
		fail("Expecting IllegalArgumentException, got: " + dict);
	}

}
