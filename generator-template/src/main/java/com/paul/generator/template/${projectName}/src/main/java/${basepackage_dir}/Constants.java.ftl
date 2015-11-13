package ${basepackage};

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Constant values used throughout the application.
 * 
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a>
 */
public final class Constants {

	private Constants() {
		// hide me
	}

	/**
	 * File separator from System properties
	 */
	public static final String FILE_SEP = System.getProperty("file.separator");

	public final static String ERROR_1_lackParam = "缺少必要参数";
	public final static String ERROR_2_NoAuthority = "无权限调用此接口";
	public final static String ERROR_3_outTime = "请求超时";
	public final static String ERROR_4_dbError = "数据库读取错误";
	public final static String ERROR_5_unknownError = "未知错误";
	public final static String ERROR_6_noInfo = "没有相关数据";
	public final static String IS_MERCHANT="ismerchant";
	
}
