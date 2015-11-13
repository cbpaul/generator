package ${basepackage}.tools;

import java.io.File;
import java.io.IOException;
import java.net.URL;
public class WebUtils {
	
	
	private static String webInfPath;
	
	/**
	 *
	 *get WEB-INF path<br><br>
	 *
	 * */
	public static String getWebInfPath(){

		  
		try {
			
			if(null==webInfPath){
				webInfPath = ApplicationContextUtils.getContext().getResource("").getFile().getPath()+"/";
			}
			
			return webInfPath;
			
		} catch (IOException e) {
			
			e.printStackTrace();
			
		}
		
		
		URL url = new WebUtils().getClass().getProtectionDomain().getCodeSource().getLocation();
		String path = url.toString();
		int index = path.indexOf("WEB-INF");
		
		
		if(index == -1){
			index = path.indexOf("classes");
		}
		if(index == -1){
			index = path.indexOf("bin");
		}
		path = path.substring(0, index);
		if(path.startsWith("zip")){
			path = path.substring(4);
		}else if(path.startsWith("file")){
			path = path.substring(6);
		}else if(path.startsWith("jar")){
			path = path.substring(10); 
		}
		
		return path.replaceAll("%20", " ");
	}
	
	
	
	/**
	 * 
	 * 获得相对路径。
	 * @param folder 文件夹路径
	 * @param fileName 文件名，当fileName==null时随机创建一个
	 * @param prefix 后缀，prefix!=null 累加在后面
	 * 
	 * */
	public static String getRelativePath(String folder,String fileName,String prefix){
		
		fileName = (fileName==null?GeneratedKeyUtils.getStrKey(""):fileName);
		
		if (prefix!=null) {
			fileName = fileName+"."+prefix;
		}
		new File(WebUtils.getSaveFileAbsolutePath() +  folder+"/"+fileName ).mkdirs();
		
		return folder+"/"+fileName;
	}
	/**
	 * @return返回${catalina.base}/项目名/upload/
	 */
	public static String getSaveFileAbsolutePath(){
		File file = new File(getWebInfPath());
		String path = file.getPath() + "/uploads/";
		return path;
	}
	/**
	 * @return返回${catalina.base}/项目名/
	 */
	public static String getSaveFileAbsoluteNotUploadPath(){
		File file = new File(getWebInfPath());
		String path = file.getPath() + "/";
		return path;
	}
	
}
