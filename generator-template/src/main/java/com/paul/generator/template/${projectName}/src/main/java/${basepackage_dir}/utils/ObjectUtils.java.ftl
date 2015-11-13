package ${basepackage}.utils;

import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ObjectUtils {

	/**
	 * if str is=="" return null;<br>
	 * else return str;
	 * 
	 * */
	public static String strToNull(String str) {

		if ("".equals(str)) {
			return null;
		}

		return str;
	}

	/**
	 * 
	 * 
	 * 将日期字符串根据格式返回时间的时间戳
	 * 
	 * 
	 * */
	public static Long strToDateLong(String dateStr, String format) {
		if (isNull(dateStr) || isNull(format)) {
			return null;
		}
		try {
			return (new SimpleDateFormat(format).parse(dateStr)).getTime();
		} catch (ParseException e) {
			return null;
		}
	}

	/**
	 * 将日期字符串根据格式返回时间的时间戳
	 * 
	 * @param dateStr
	 *            日期字符串(格式为yyyy-MM-dd)
	 * @return
	 */
	public static Long strToDateLong(String dateStr) {
		return strToDateLong(dateStr, "yyyy-MM-dd");
	}

	/**
	 * 给字符串双引号和换行符加上斜杠
	 * 
	 * */
	public static String rnQuoMarks(String source) {

		if (source == null) {
			return "";
		}
		return source.replaceAll("\"", "\\\\\"")
				.replaceAll("" + ((char) 10), "\\\\r\\\\n")
				.replaceAll("" + ((char) 13), "\\\\r\\\\n");
	}

	/**
	 * 
	 * anyone is null return true;
	 * 
	 * */
	public static boolean anyoneIsEmpty(String... objects) {

		if (objects == null || objects.length == 0) {
			return true;
		}

		for (String str : objects) {
			if (isNull(str)) {
				return true;
			}
		}

		return false;

	}

	/**
	 * if str is==null return "";<br>
	 * else return str;
	 * 
	 * */
	public static String nullToStr(Object str) {

		if (null == str) {
			return "";
		}

		return str.toString();
	}

	/**
	 * if str is==null return "";<br>
	 * else return str;
	 * 
	 * */
	public static String nullToStr(String str) {

		if (null == str) {
			return "";
		}

		return str;
	}

	/**
	 * now Date to String <BR>
	 * 
	 * @param String
	 *            format <br>
	 * 
	 * */
	public static String nowDateStr(String format) {
		try {
			return new SimpleDateFormat(format).format(new Date());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * String to Date <BR>
	 * 
	 * @param String
	 *            format yyyy-MM-dd <br>
	 * 
	 * */
	public static Date strToDateDef(String dateStr) {
		try {
			return new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * check String is Null<br>
	 * if str==null or "" equals str return true;<br>
	 * */
	public static boolean isNull(String str) {
		if (null == str) {
			return true;
		}
		return "".equals(str.trim());
	}

	public static boolean isNotNull(String str) {
		return !isNull(str);
	}

	private static SimpleDateFormat yyyyMMddHHmmSS = new SimpleDateFormat(
			"yyyy年MM月dd日 HH:mm:ss");

	/**
	 * 
	 * if dateTime == null return "";<br>
	 * else return formate is yyyy年MM月dd日 HH:mm:ss
	 * 
	 * */
	public static String dateTimeToStr(Long dateTime) {
		if (null == dateTime) {
			return "";
		}
		return yyyyMMddHHmmSS.format(new Date(dateTime));
	}

	/**
	 * 
	 * @pramati.
	 * @param dateTime
	 *            length is thirteen <br>
	 * @param The
	 *            return value's SimpleDateFormat is the format <br>
	 * 
	 * */
	public static String dateTimeToStr(long dateTime, String format) {
		if (format == null) {

			return "";
		}

		SimpleDateFormat simp = new SimpleDateFormat(format);

		return simp.format(new Date(dateTime));

	}

	/**
	 * get now Date Time. format : yyyy年MM月dd日 HH:mm:ss<br>
	 * the return is long type.
	 * */
	public static String getNowDateTimeYMdHmS() {
		return yyyyMMddHHmmSS.format(new Date());
	}

	/**
	 * 返回今天的日期，格式为yyyy-MM-dd
	 * 
	 * */
	public static String getNowDateTimeYMd() {
		return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	}

	/**
	 * 返回昨天的日期，格式为yyyy-MM-dd
	 * 
	 * @return
	 */
	public static String getYesterdayYMd() {
		return dateTimeToStr(
				addDate(Calendar.DAY_OF_MONTH, -1,
						strToDateLong(getNowDateTimeYMd())), "yyyy-MM-dd");
	}

	/**
	 * get now Date Time.<br>
	 * the return is long type.
	 * 
	 * @return long length is thirteen
	 * */
	public static long getNowDateTime() {
		return System.currentTimeMillis();
	}

	/**
	 * get now Date Time.<br>
	 * the return is long type.
	 * 
	 * @return long length is ten
	 * */
	public static long getNowDateTimeTen() {
		return System.currentTimeMillis() / 1000;
	}

	/**
	 * 
	 * return null==list?true:list.isEmpty();
	 * 
	 * */
	public static boolean isEmpty(List list) {
		return null == list ? true : list.isEmpty();
	}

	/**
	 * 
	 * anyone is null return true;
	 * 
	 * */
	public static boolean anyIsEmpty(Object... objects) {

		if (objects == null || objects.length == 0) {
			return true;
		}

		for (Object object : objects) {
			if (object == null) {
				return true;
			}
		}

		return false;

	}

	/**
	 * 
	 * 日期、月或者年的添加
	 * 
	 * @param addType
	 *            如Calendar.MONTH
	 * @param addNum
	 *            要添加值
	 * @param sourceTime
	 *            源时间
	 * 
	 * */
	public static long addDate(int addType, int addNum, long sourceTime) {

		ObjectUtils.dateTimeToStr(sourceTime, "yyyy-MM-dd");

		Calendar calendar = Calendar.getInstance(Locale.CHINA);
		calendar.setTimeInMillis(sourceTime);
		calendar.add(addType, addNum);

		return calendar.getTimeInMillis();
	}

	public static Date addDate(int addType, int addNum, Date sourceTime) {
		Calendar calendar = Calendar.getInstance(Locale.CHINA);
		calendar.setTime(sourceTime);
		calendar.add(addType, addNum);
		return calendar.getTime();
	}

	/**
	 * 
	 * 对当期时间进行 日、月或者年的添加
	 * 
	 * @param addType
	 *            如Calendar.MONTH
	 * @param addNum
	 *            要添加值
	 * @param sourceTime
	 *            源时间
	 * 
	 * */
	public static long addDate(int addType, int addNum) {

		return addDate(addType, addNum, getNowDateTime());
	}

	/**
	 * 
	 * if all is null return true;<br>
	 * <br>
	 * 
	 * if any one is not null return false;
	 * 
	 * */
	public static boolean isAllEmpty(Object... objects) {
		if (objects == null) {
			return true;
		}
		for (Object object : objects) {
			if (null != object && !"".equals(object)) {
				return false;
			}
		}

		return true;
	}

	/**
	 * 
	 * if any of one string is null or equals "" return true;<br>
	 * <br>
	 * else return false;
	 * 
	 * */
	public static boolean isEmpty(String... strs) {
		if (strs == null || strs.length == 0) {
			return true;
		}
		for (String str : strs) {
			if (str == null || "".equals(str)) {
				return true;
			}
		}

		return false;
	}

	public static boolean isNotEmpty(String... strs) {
		return !isEmpty(strs);
	}

	/**
	 * 
	 * 
	 * if(value instanceof List){ return ((List)value).isEmpty();<br>
	 * <br>
	 * 
	 * if(value instanceof Object[]){ return ((Object[])value).length==0;<br>
	 * <br>
	 * 
	 * if(value instanceof Map){ return ((Map)value).size()==0;<br>
	 * <br>
	 * 
	 * 
	 * 
	 * */
	public static boolean isEmpty(Object value) {
		if (null == value) {
			return true;
		} else if (value instanceof List) {
			return ((List) value).isEmpty();
		} else if (value instanceof Object[]) {
			return ((Object[]) value).length == 0;
		} else if (value instanceof Map) {
			return ((Map) value).size() == 0;
		} else if ((value instanceof String) && isNull((String) value)) {
			return true;
		}
		return false;
	}

	public static boolean isNotEmpty(Object value) {
		return !isEmpty(value);
	}

	/**
	 * 
	 * @param oldStr
	 *            要匹配的数据
	 * @param patterStr
	 *            正则表达式
	 * @return boolean
	 * 
	 * */
	public static boolean patternMatcher(String oldStr, String patterStr) {

		boolean flag = false;
		try {
			Pattern p = Pattern.compile(patterStr);
			Matcher m = p.matcher(oldStr);
			flag = m.matches();
		} catch (Exception e) {
			flag = false;
		}
		return flag;
	}

	/**
	 * 手机号码校验
	 * 
	 * @return boolean true 是手机号码
	 * */
	public static boolean isMobile(String mobile) {

		return patternMatcher(mobile, "^1[0-9]{10}$");

	}

	/**
	 * 
	 * html 转义
	 * 
	 * */
	public static String html(String content) {

		if (content == null)
			return "";

		String html = content;

		html = html.replaceAll("'", "&apos;");
		html = html.replaceAll("&", "&amp;");
		html = html.replaceAll("\"", "&quot;");
		html = html.replaceAll("<", "&lt;");
		html = html.replaceAll(">", "&gt;");

		return html;
	}

	public static String getChineseStringTime(Long time) {
		if (time == null)
			return null;
		StringBuilder sb = new StringBuilder();
		if (time / (1000 * 60 * 60) > 0) {
			sb.append(time / (1000 * 60 * 60)).append("小时");
		}
		if ((time % (1000 * 60 * 60)) / (1000 * 60) > 0) {
			sb.append((time % (1000 * 60 * 60)) / (1000 * 60)).append("分钟");
		}
		return sb.toString();
	}

	/**
	 * 转成integer
	 * 
	 * @param arg
	 * @return
	 */
	public static Integer toInteger(Object arg) {
		if (isEmpty(arg)) {
			return null;
		}
		try {
			String value = String.valueOf(arg);
			BigDecimal decimal = new BigDecimal(value);
			return decimal.intValue();
		} catch (Exception e) {
			return null;
		}
	}

	public static Integer toInteger(Object arg, Integer defValue) {
		Integer l = toInteger(arg);
		return l == null ? defValue : l;
	}

	/**
	 * 转换成long
	 * 
	 * @param arg
	 * @return
	 */
	public static Long toLong(Object arg) {
		if (isEmpty(arg)) {
			return null;
		}
		try {
			String value = String.valueOf(arg);
			BigDecimal decimal = new BigDecimal(value);
			return decimal.longValue();
		} catch (Exception e) {
			return null;
		}
	}

	public static Long toLong(Object arg, Long defValue) {
		Long l = toLong(arg);
		return l == null ? defValue : l;
	}

	/**
	 * 转换成double
	 * 
	 * @param arg
	 * @return
	 */
	public static Double toDouble(Object arg) {
		if (isEmpty(arg)) {
			return null;
		}
		try {
			String value = String.valueOf(arg);
			BigDecimal decimal = new BigDecimal(value);
			return decimal.setScale(2).doubleValue();
		} catch (Exception e) {
			return null;
		}
	}

	public static BigDecimal toBigDecimal(Object arg) {
		if (isEmpty(arg)) {
			return null;
		}
		try {
			String value = String.valueOf(arg);
			BigDecimal decimal = new BigDecimal(value);
			return decimal;
		} catch (Exception e) {
			return null;
		}
	}

	public static BigDecimal toBigDecimal(Object arg, BigDecimal defValue) {
		BigDecimal b = toBigDecimal(arg);
		return b == null ? defValue : b;
	}

	public static String listToString(List list, String separater) {
		StringBuilder sb = new StringBuilder();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				sb.append(list.get(i) + separater);
			}
			if (ObjectUtils.isNotNull(separater)) {
				sb = sb.delete(sb.length() - separater.length(), sb.length());
			}
		}
		return sb.toString();
	}

	/**
	 * 字符串数据转long数组
	 * 
	 * @param args
	 * @return
	 */
	public static Long[] strArrayToLongArray(String... args) {
		return strArrayToTypeArray(Long.class, args);

	}

	public static <T> T[] strArrayToTypeArray(Class<T> clazz, String... args) {
		T[] resultArray = (T[]) Array.newInstance(clazz, args.length);
		for (int i = 0; i < args.length; i++) {
			try {
				resultArray[i] = clazz.getConstructor(String.class)
						.newInstance(args[i]);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		return resultArray;

	}

	/**
	 * 校验是否所有的参数都有值
	 * 
	 * @param objects
	 *            参数列表
	 * @return
	 */
	public static boolean anyIsMust(Object... objects) {

		if (objects == null || objects.length == 0) {
			return false;
		}
		for (Object object : objects) {
			if (isEmpty(object)) {
				return false;
			}
		}
		return true;

	}

	public static String valueOf(Object obj) {
		if (obj == null)
			return "";
		return String.valueOf(obj);
	}

	/**
	 * 创建一个打印流水号
	 * 
	 * @return
	 */
	public static String getPrintNo() {
		return String.valueOf(ObjectUtils.getNowDateTime()).substring(2, 11)
				+ (int) (Math.random() * 100);
	}

	/**
	 * 创建一个扫描编号
	 * 
	 * @return
	 */
	public static String getScanNum() {
		return String.valueOf(ObjectUtils.getNowDateTime()).substring(2)
				+ (int) (Math.random() * 10000);
	}

	public static String toString(Object obj) {
		return obj != null ? obj.toString() : null;
	}

}
