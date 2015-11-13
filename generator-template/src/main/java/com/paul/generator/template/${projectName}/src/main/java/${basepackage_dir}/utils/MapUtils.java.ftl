package ${basepackage}.tools;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 将对象转换为MAP的工具类
 * 
 * @author Administrator
 * 
 */
public class MapUtils {
	private static Boolean bool;
	private static List<String> fieldList;
	private static String[] fields;

	/**
	 * 将对象转换为MAP
	 * 
	 * @param obj
	 *            需要转换的对象
	 * @return
	 */
	public synchronized static Object object2map(Object obj) {
		return object2map(obj, null);
	}

	/**
	 * 将对象转换为MAP
	 * 
	 * @param obj
	 *            需要转换的对象
	 * @param isFilter
	 *            是否过滤
	 * @param fieldFilter
	 *            过滤或必要字段 isFilter=true 过滤fieldFilter这些字段，</br> isFilter= fase
	 *            fieldFilter这些段为必要过滤不在之内的。
	 * @return
	 */
	public synchronized static Object object2map(Object obj, Boolean isFilter,
			String... fieldFilter) {
		bool = isFilter;
		fieldList = new ArrayList<String>();
		if (fieldFilter != null && fieldFilter.length > 0) {
			fields = fieldFilter;
			Collections.addAll(fieldList, fieldFilter);
		}
		if (obj == null) {
			return null;
		} else if (obj instanceof Object[]) {
			return array2map((Object[]) obj);
		} else if (obj instanceof List) {
			return list2map((List<?>) obj);
		} else if (obj instanceof Map) {
			return map2map((Map<?, ?>) obj);
		} else if (obj instanceof Set) {
			return set2map((Set<?>) obj);
		} else {
			return bean2map(obj);
		}
	}

	public static Object set2map(Set<?> set) {
		List<Object> listMap = new ArrayList<Object>();
		if (set != null && set.size() > 0) {
			for (Object obj : set) {
				listMap.add(object2map(obj, bool, fields));
			}
		} else {
			return null;
		}
		return listMap;
	}

	public static Object array2map(Object[] array) {
		List<Object> listMap = new ArrayList<Object>();
		if (array != null && array.length > 0) {
			for (Object obj : array) {
				listMap.add(object2map(obj, bool, fields));
			}
		} else {
			return null;
		}
		return listMap;
	}

	public static Object list2map(List<?> list) {
		List<Object> listMap = new ArrayList<Object>();
		if (list != null && list.size() > 0) {
			for (Object obj : list) {
				listMap.add(object2map(obj, bool, fields));
			}
		} else {
			return null;
		}
		return listMap;
	}

	public static Object map2map(Map<?, ?> map) {
		Map<String, Object> m = new HashMap<String, Object>();
		if (map != null && map.size() > 0) {
			for (Object key : map.keySet()) {
				if (isNecessary((String) key)) {
					if (isConvert(map.get(key))) {
						m.put(key.toString(),
								object2map(map.get(key), bool, fields));
					} else {
						m.put(key.toString(), map.get(key));
					}
				}
			}
		} else {
			return null;
		}
		return m;
	}

	public static Object bean2map(Object bean) {
		Map<String, Object> map = new HashMap<String, Object>();
		PropertyDescriptor[] props = null;
		try {
			props = Introspector.getBeanInfo(bean.getClass(), Object.class)
					.getPropertyDescriptors();
		} catch (IntrospectionException e) {
		}
		if (props != null) {
			for (int i = 0; i < props.length; i++) {
				try {
					if (isNecessary(props[i].getName())
							&& ObjectUtils.isNotNull(props[i].getName())) {
						String name = props[i].getName();
						Object value = props[i].getReadMethod().invoke(bean);
						if (isConvert(value)) {
							map.put(name, object2map(value, bool, fields));
						} else {
							map.put(name, value);
						}
					}
				} catch (Exception e) {
				}
			}
		}
		return map;
	}

	public static boolean isConvert(Object obj) {
		if (obj == null) {
			return false;
		} else if (obj instanceof String || obj instanceof Integer
				|| obj instanceof Float || obj instanceof Boolean
				|| obj instanceof Short || obj instanceof Double
				|| obj instanceof Long || obj instanceof BigDecimal
				|| obj instanceof Date
				|| obj instanceof BigInteger || obj instanceof Byte) {
			return false;
		}
		return true;
	}

	public static boolean isNecessary(String field) {
		if (fieldList == null || fieldList.size() == 0 || bool == null) {
			return true;
		}
		if (bool) {
			if (fieldList.contains(field)) {
				return false;
			} else {
				return true;
			}
		} else {
			if (fieldList.contains(field)) {
				return true;
			} else {
				return false;
			}
		}
	}

	/**
	 * 当调用API权限受限时，获取error_response结构(权限受限)
	 * 
	 * @return <code>{ "error_response":{ "code":7,"msg":"权限受限!" } }</code>
	 */
	public static Map<String, Object> getApiAccessErrorResponse() {
		return getApiErrorResponse(7, "权限受限!");
	}

	/**
	 * 当调用API发生错误时，获取error_response结构(缺少必要参数)
	 * 
	 * @return <code>{ "error_response":{ "code":1,"msg":"缺少必要参数!" } }</code>
	 */
	public static Map<String, Object> getApiErrorResponse() {
		return getApiErrorResponse(1, "缺少必要参数!");
	}

	/**
	 * 当调用API发生错误时，获取error_response结构
	 * 
	 * @param code
	 *            错误码
	 * @param msg
	 *            错误信息
	 * @return <code>{ "error_response":{ "code":code,"msg":msg } }</code>
	 */
	public static Map<String, Object> getApiErrorResponse(Integer code,
			String msg) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("msg", msg);
		resultMap.put("error_response", map);
		return resultMap;
	}

	/**
	 * 当调用API成功时，获取successed_response结构
	 * 
	 * @param code
	 *            返回码
	 * @param msg
	 *            返回信息
	 * @return <code>{ "successed_response":{ "code":code,"msg":msg } }</code>
	 */
	public static Map<String, Object> getApiSuccessedResponse(Integer code,
			String msg) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("msg", msg);
		resultMap.put("successed_response", map);
		return resultMap;
	}

	/**
	 * 获取一个新的包含key-value的MAP对象
	 * 
	 * @param key
	 * @param value
	 * @return
	 */
	public static Map<String, Object> getApiResultMap(String key, Object value) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put(key, value);
		return resultMap;
	}

	public static String getString(Map<String, Object> map, String key) {
		if (map != null) {
			Object obj = map.get(key);
			if (obj != null)
				return (String) obj;
		}
		return null;
	}

	public static Map<String, Object> getMap(Map<String, Object> map, String key) {
		if (map != null) {
			Object obj = map.get(key);
			if (obj != null)
				return (Map<String, Object>) obj;
		}
		return null;
	}

	public static List<Map<String, Object>> getListMap(Map<String, Object> map,
			String key) {
		if (map != null) {
			Object obj = map.get(key);
			if (obj != null)
				return (List<Map<String, Object>>) obj;
		}
		return null;
	}
}
