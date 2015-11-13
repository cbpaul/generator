package ${basepackage}.utils;

import java.io.IOException;
import java.io.Writer;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import ${basepackage}.Constants;
import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * 
 * Service接口工具类
 * 
 * */
public class ServiceUtils {
	private static final long EXPIRE_TIME=10*60*1000;//十分钟
	public static void writer(Writer writer, Object outMess) {
		try {
			writer.write(outMess.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	/**
	 * 输出分页查询数据
	 * 
	 * @param writer
	 * @param aaData
	 *            查询出的分页数据
	 * @param totalData
	 *            总共数据量
	 */
	public static void writePageData(Writer writer,Integer sEcho, Object aaData, long totalData) {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			String json = "{\"sEcho\":" + sEcho + ",\"iTotalRecords\":"
					+ totalData + ",\"iTotalDisplayRecords\":" + totalData
					+ ",\"aaData\":" + objectMapper.writeValueAsString(aaData)
					+ "}";
			ServiceUtils.writer(writer, json);
		} catch (Exception e) {
			e.printStackTrace();
			ServiceUtils
					.writer(writer,
							"{\"sEcho\":1,\"iTotalRecords\":0,\"iTotalDisplayRecords\":0,\"aaData\":[]}");
		}
	}
	/**
	 * 检测uri是否过期
	 * @param request
	 * @return
	 */
	public static boolean checkUriExpired(HttpServletRequest request){
		String timestamp=request.getParameter("timestamp");
		if(null!=timestamp && !"".equals(timestamp.trim()) && timestamp.matches("\\d{13}")){
			long urlTime=Long.parseLong(timestamp);
			long curTime=System.currentTimeMillis();
			if(curTime<urlTime&&urlTime+EXPIRE_TIME<curTime){
				return false;
			}
			return true;
		}
		return false;
	}
	/**
	 * 校验必填参数，当校验不通过且writer不为空时，自动输出错误信息 <br/>
	 * 
	 * @return boolean 校验通过返回true,否则返回false;
	 * 
	 * 
	 * **/
	public static boolean checkMustParam_pasw(HttpServletRequest request,
			Writer writer, String mess, Object... params) {

		if (!ObjectUtils.anyIsEmpty(params)) {
			return true;
		}

		if (null != writer) {
			writer(writer,
					error(1, mess == null ? Constants.ERROR_1_lackParam : mess));
		}
		return false;

	}

	public static String successed(String code, String msg) {
		return "{\"successed_response\":{\"code\":\"" + code + "\",\"msg\":\""
				+ msg + "\"}}";
	}

	public static String error(int code, String msg) {
		return "{\"error_response\":{\"code\":\"" + code + "\",\"msg\":\""
				+ msg + "\"}}";
	}

	public static String successedMVC(int code, String msg) {
		return "{\"code\":\"" + code + "\",\"info\":\"" + msg + "\"}";
	}

	public static String errorMVC(int code, String msg) {
		return "{\"code\":\"" + code + "\",\"info\":\"" + msg + "\"}";
	}
	public static String errorMVC(int code, String msg,String callPath) {
		return "{\"code\":\"" + code + "\",\"info\":\"" + msg + "\",\"callPath\":\""+callPath+"\"}";
	}

	public static void errorMVC(int code, String msg, Writer writer) {
		writer(writer, ServiceUtils.errorMVC(code, msg));
	}
	public static void errorMVC(int code, String msg, String callPath,Writer writer) {
		writer(writer, ServiceUtils.errorMVC(code, msg,callPath));
	}

	public static void successedMVC(String msg, Writer writer) {
		writer(writer, ServiceUtils.successedMVC(200, msg));
	}
	/**
	 * js回调
	 * @param code
	 * @param msg
	 * @param writer
	 * @throws IOException 
	 */
	public static void javaScritpMvc(String callbackName,int code,String msg,Writer writer) throws IOException{
		writer.write("<script>parent."+callbackName+"("+ServiceUtils.errorMVC(code, msg)+")</script>");
	}
	/**
	 * js回调
	 * @param callbackName
	 * @param code
	 * @param msg
	 * @param callPath重新请求路径
	 * @param writer
	 * @throws IOException
	 */
	public static void javaScritpMvc(String callbackName,int code,String msg,String callPath,Writer writer) throws IOException{
		writer.write("<script>parent."+callbackName+"("+ServiceUtils.errorMVC(code, msg,callPath)+")</script>");
	}
	/**
	 * 返回<code>{\"code\":\"200\",\"info\":\"操作成功！\"}</code>
	 * @param writer
	 */
	public static void successedMVC(Writer writer) {
		writer(writer, ServiceUtils.successedMVC(200, "操作成功！"));
	}

	/**
	 * 
	 * 直接输出错误信息
	 * 
	 * */
	public static void error(int code, String msg, Writer writer) {
		writer(writer, ServiceUtils.error(code, msg));
	}

	/**
	 * 
	 * 直接输出错误信息
	 * 
	 * */
	public static void successed(String code, String msg, Writer writer) {
		writer(writer, ServiceUtils.successed(code, msg));
	}

	/**
	 * 
	 * 当数据为空时，输出错误信息并返回true, 否则返回false；
	 * 
	 * */
	public static boolean writeEmpty(Object obj, Writer writer) {
		if (null == obj) {
			error(6, "没有相关数据", writer);
			return true;
		} else if (obj instanceof List) {
			if (((List) obj).isEmpty()) {
				error(6, "没有相关数据", writer);
				return true;
			}
		} else if (obj instanceof String) {
			if (obj.toString().length() == 0) {
				error(6, "没有相关数据", writer);
				return true;
			}
		}
		return false;
	}
}
