package hash.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import hash.CMAHashTable;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Deque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;

/**
 * This class tests a Map implementation against a reference Map implementation.
 * 
 * Every failure comes with an history of operations. This history can be used
 * to reproduce the diverging behaviors, under the assumption that the
 * <code>size</code> and <code>get</code> methods are side effect free.
 * 
 */
public class MapTest {

	MonitoredMap<String, String> map;

	@SuppressWarnings("unchecked")
	static <K, V> Map<K, V> getObservedMap() {
		// TODO: return a new instance of the map under test
		return (Map<K, V>) new CMAHashTable<>();
	}

	static <K, V> Map<K, V> getReferenceMap() {
		return new HashMap<>();
	}

	@Before
	public void setUp() throws Exception {
		map = new MonitoredMap<>();
	}

	/* Basic tests */

	@Test
	public void newTest() {
	}

	@Test
	public void putOneTest() {
		map.put("one", "eins");
	}

	@Test
	public void putTwoTest() {
		map.put("one", "eins");
		map.put("two", "swei");
	}

	@Test
	public void putTwice() {
		map.put("one", "drei");
		map.put("one", "eins");
	}

	@Test
	public void putTwiceDistinct() {
		map.put(new String("one"), "drei");
		map.put(new String("one"), "eins");
	}

	@Test
	public void getDistinct() {
		map.put(new String("one"), "eins");
		map.get(new String("one"));
	}

	/* Coverage test */

	@Test
	public void clearTest() {
		map.put("one", "eins");
		map.clear();
		map.put("three", "drei");
		map.get("one");
	}

	@Test
	public void containsKeyTest() {
		map.put("one", "eins");
		map.containsKey("two");
		map.containsKey("one");
		map.containsKey(new String("one"));
	}

	@Test
	public void containsValueTest() {
		map.put("one", "eins");
		map.containsValue("eins");
		map.containsValue("one");
		map.containsValue(new String("eins"));
	}

	@Test
	public void entrySetTest() {
		map.put("one", "eins");
		map.put("two", "swei");
		map.put("three", "drei");
		map.entrySet();
	}

	@Test
	public void keySetTest() {
		map.put("one", "eins");
		map.put("two", "swei");
		map.put("three", "drei");
		map.keySet();
	}

	@Test
	public void valuesTest() {
		map.put("one", "eins");
		map.put("two", "swei");
		map.put("three", "drei");
		map.values();
	}

	@Test
	public void equalsTest() {
		map.put("one", "eins");
		map.put("two", "swei");
		map.put("three", "drei");
		Map<String, String> other = new HashMap<>();
		other.put("one", "eins");
		map.equals(other);
		other.put("two", "swei");
		map.equals(other);
		other.put("three", "drei");
		map.equals(other);
		other.put("four", "vier");
		map.equals(other);
	}

	@Test
	public void hashCodeTest() {
		map.hashCode();
		map.put("one", "eins");
		map.hashCode();
		map.put("two", "swei");
		map.hashCode();
		map.put("three", "drei");
		map.hashCode();
	}

	@Test
	public void isEmptyTest() {
		map.isEmpty();
		map.put("one", "eins");
		map.isEmpty();
	}

	@Test
	public void putAllTest() {
		map.put("one", "eins");
		Map<String, String> other = new HashMap<>();
		other.put("one", "eins");
		other.put("eight", "acht");
		map.putAll(other);

	}

	@Test
	public void removeTest() {
		map.put("one", "eins");
		map.put("two", "swei");
		map.put("three", "drei");
		map.remove("one");
		map.remove(new String("two"));
		map.remove("one");
		map.remove("zero");
	}

	/* Intensive tests */

	@Test
	public void put100Test() {
		for (int i = 1; i <= 100; i++) {
			map.put(Integer.toString(i), "nombre");
		}
	}

	/* Utility inner class. */

	static class MonitoredMap<K, V> implements Map<K, V> {

		private Deque<String> hist;
		private Map<K, V> ref;
		private Map<K, V> obs;

		void failure(Exception e) {
			fail(hist + " lead to " + e);
		}

		void sameResults(Object refRes, Object obsRes) {
			assertEquals(hist + " lead to incorrect result.", refRes, obsRes);
		}

		<E> void sameCollections(Collection<E> refRes, Collection<E> obsRes) {
			assertNotNull(hist + " lead to incorrect result: null.", obsRes);
			assertTrue(hist + " lead to incorrect result. " + obsRes
					+ " was expected to contain " + refRes,
					obsRes.containsAll(refRes));
			assertTrue(hist + " lead to incorrect result. " + refRes
					+ " was expected to be contained in " + obsRes,
					refRes.containsAll(obsRes));
		}

		void sameMaps() {
			checkSize();
			for (K refKey : ref.keySet()) {
				checkGet(refKey);
			}
		}

		public MonitoredMap() throws Exception {
			hist = new LinkedList<>();
			ref = getReferenceMap();
			hist.addLast("new()");
			try {
				obs = getObservedMap();
			} catch (Exception e) {
				throw new Exception(
						"The method MapTest.getObservedMap() failed", e);
			}
			if (obs == null)
				throw new Exception(
						"The method MapTest.getObservedMap() returned null");
			sameMaps();
		}

		@Override
		public int size() {
			return size(true);
		}
		
		public void checkSize() {
			size(false);
		}
		
		public int size(boolean log) {
			int refRes = ref.size();
			hist.addLast("size()");
			int obsRes = 0;
			try {
				obsRes = obs.size();
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			if (!log) hist.removeLast();
			return refRes;
		}

		@Override
		public boolean isEmpty() {
			boolean refRes = ref.isEmpty();
			hist.addLast("isEmpty()");
			boolean obsRes = false;
			try {
				obsRes = obs.isEmpty();
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			return refRes;
		}

		@Override
		public boolean containsKey(Object key) {
			boolean refRes = ref.containsKey(key);
			hist.addLast("containsKey(" + key + ")");
			boolean obsRes = false;
			try {
				obsRes = obs.containsKey(key);
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			return refRes;
		}

		@Override
		public boolean containsValue(Object value) {
			boolean refRes = ref.containsValue(value);
			hist.addLast("containsValue(+" + value + ")");
			boolean obsRes = false;
			try {
				obsRes = obs.containsValue(value);
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			return refRes;
		}
		
		@Override
		public V get(Object key) {
			return get(key, true);
		}
		
		public void checkGet(Object key) {
			get(key, false);
		}

		public V get(Object key, boolean log) {
			V refValue = ref.get(key);
			hist.addLast("get(" + key + ")");
			V obsValue = null;
			try {
				obsValue = obs.get(key);
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refValue, obsValue);
			if (!log) hist.removeLast();
			return refValue;
		}

		@Override
		public V put(K key, V value) {
			V refValue = ref.put(key, value);
			hist.addLast("put(" + key + ", " + value + ")");
			V obsValue = null;
			try {
				obsValue = obs.put(key, value);
			} catch (Exception e) {
				failure(e);
			}
			sameMaps();
			sameResults(refValue, obsValue);
			return refValue;
		}

		@Override
		public V remove(Object key) {
			V refValue = ref.remove(key);
			hist.addLast("remove(" + key + ")");
			V obsValue = null;
			try {
				obsValue = obs.remove(key);
			} catch (Exception e) {
				failure(e);
			}
			sameMaps();
			sameResults(refValue, obsValue);
			return refValue;
		}

		@Override
		public void putAll(Map<? extends K, ? extends V> m) {
			ref.putAll(m);
			hist.addLast("putAll(" + m + ")");
			try {
				obs.putAll(m);
			} catch (Exception e) {
				failure(e);
			}
			sameMaps();
		}

		@Override
		public void clear() {
			ref.clear();
			hist.addLast("clear()");
			try {
				obs.clear();
			} catch (Exception e) {
				failure(e);
			}
			sameMaps();
		}

		@Override
		public Set<K> keySet() {
			Set<K> refRes = new HashSet<>(ref.keySet());
			hist.addLast("keySet()");
			Set<K> obsRes = null;
			try {
				obsRes = obs.keySet();
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			return refRes;
		}

		@Override
		public Collection<V> values() {
			Collection<V> refRes = new ArrayList<>(ref.values());
			hist.addLast("values()");
			Collection<V> obsRes = null;
			try {
				obsRes = obs.values();
			} catch (Exception e) {
				failure(e);
			}
			sameCollections(refRes, obsRes);
			return refRes;
		}

		@Override
		public Set<Entry<K, V>> entrySet() {
			Set<Entry<K, V>> refRes = new HashSet<>(ref.entrySet());
			hist.addLast("entrySet()");
			Set<Entry<K, V>> obsRes = null;
			try {
				obsRes = obs.entrySet();
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			return refRes;
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see java.lang.Object#hashCode()
		 */
		@Override
		public int hashCode() {
			int refRes = ref.hashCode();
			hist.addLast("hashCode()");
			int obsRes = 0;
			try {
				obsRes = obs.hashCode();
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			return refRes;
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see java.lang.Object#equals(java.lang.Object)
		 */
		@Override
		public boolean equals(Object obj) {
			boolean refRes = ref.equals(obj);
			hist.addLast("equals(" + obj + ")");
			boolean obsRes = false;
			try {
				obsRes = obs.equals(obj);
			} catch (Exception e) {
				failure(e);
			}
			sameResults(refRes, obsRes);
			return refRes;
		}

	}

}
