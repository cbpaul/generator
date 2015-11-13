package ${basepackage}.utils;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

/**
 * @文件名 SearchFilter.java
 * @作者   paul
 * @创建日期 2014-5-9
 * @版本 V 1.0
 */
public class SearchFilter {
	public enum Operator {
		EQ,NEQ, LIKE, GT, LT, GTE, LTE,IN,NOTIN
	}

	public String fieldName;
	public Object value;
	public Operator operator;

	public SearchFilter(String fieldName, Operator operator, Object value) {
		this.fieldName = fieldName;
		this.value = value;
		this.operator = operator;
	}
	public static Map<String, SearchFilter> parse(Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters =new HashMap<String, SearchFilter>();

		for (Entry<String, Object> entry : searchParams.entrySet()) {
			String key = entry.getKey();
			Object value = entry.getValue();
			if (ObjectUtils.isEmpty(value)) {
				continue;
			}

			String[] names = key.split("_");
			if (names.length != 2) {
				throw new IllegalArgumentException(key + " is not a valid search filter name");
			}
			String filedName = names[1];
			Operator operator = Operator.valueOf(names[0]);

			SearchFilter filter = new SearchFilter(filedName, operator, value);
			filters.put(key, filter);
		}

		return filters;
	}
}
