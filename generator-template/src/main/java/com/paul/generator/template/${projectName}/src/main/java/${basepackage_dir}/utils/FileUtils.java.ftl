package ${basepackage}.tools;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import ${basepackage}.Constants;




public class FileUtils {
	
	/**
	 * 
	 * 
	 * 
	 * @param inputName
	 *            is upload's file name , if inputName==null , the file is in
	 *            FileMap first file
	 * 
	 * @param savePath
	 *            is the file save path
	 * 
	 * @param fileName
	 *            is saved file name , the file name no suffix , if
	 *            fileName==null the savePath is savePath+fileName
	 * 
	 * @return path+fileName
	 * 
	 * */
	public static String upLoadFile(HttpServletRequest request,
			String inputName, String savePath, String fileName)
			throws Exception {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		MultipartFile file = null;

		if (null != inputName) {

			file = multipartRequest.getFile(inputName);

		} else {

			Iterator<MultipartFile> iterator = multipartRequest.getFileMap()
					.values().iterator();
			if (iterator.hasNext())
				file = iterator.next();
		}

		if (file == null) {
			return null;
		}

		String xdPath = savePath;

		if (null != fileName) {
			String oldName = file.getOriginalFilename();
			xdPath += "/" + fileName
					+ oldName.substring(oldName.lastIndexOf('.'));
		}

		File savePathFile = new File(WebUtils.getSaveFileAbsolutePath()+savePath);

		if (!savePathFile.exists()) {

			savePathFile.mkdirs();
		}

		String pathFile = WebUtils.getSaveFileAbsolutePath()+xdPath;

		FileOutputStream fos = new FileOutputStream(pathFile);
		byte[] b = file.getBytes();

		fos.write(b);
		fos.flush();
		fos.close();

		return Constants.SAVE_BASE_UPLOAD_FOLDER+"/"+xdPath;
	}
	/**
	 * 
	 * 
	 * 
	 * 
	 * @param source 要追加的原文件名。
	 * @param num 要放大的倍数
	 * 
	 * @return String 换回格式如：  aaaX2.jpg
	 * 
	 * */
	public static String addXn(String source,int num){
		if (source==null) {
			return "";
		}
		
		
		
		String [] ary = source.split("\\.");
		if (ary.length!=2) {
			return source;
		}
		return ary[0]+"x"+num+"."+ary[1];
	}
	

	
	
	
	
	/**
	 * 
	 * 
	 * 
	 * 
	 * @param source 要追加的原文件名。
	 * @param num 要放大的倍数
	 * 
	 * @return String 返回格式如：  aaaX2.jpg
	 * 
	 * */
	public static Integer [] getImgHW(String imgPath){
		if (imgPath==null) {
			return new Integer[]{0,0};
		}
		try {
			
			if(!new File(WebUtils.getSaveFileAbsolutePath() + imgPath).exists()){
				return new Integer[]{0,0};
			}
			
			BufferedImage bi = ImageIO.read(new File(WebUtils.getSaveFileAbsolutePath() + imgPath));
			return new Integer[]{bi.getHeight(),bi.getWidth()};
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new Integer[]{0,0};
	
	}
	
	
	/**
	 * 
	 * 
	 * 如果 fileName==null 则用当前时间生成文件名称。
	 * 当文件上传成功根据 oldFilePath 删除的文件。
	 * 
	 * @param desPath 相对路径，目录
	 * 
	 * 
	 * */
	public static String multipartFile(MultipartFile file,String desPath,String fileName,String oldFilePath){
		
		if(file==null){
			return oldFilePath;
		}
		
		if(ObjectUtils.isEmpty(fileName)){
			fileName=GeneratedKeyUtils.getStrKey("");
		}
		
		if(fileName.indexOf(".")<0){
			fileName += file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		}
		
		new File(WebUtils.getSaveFileAbsolutePath()+desPath).mkdirs();
		desPath += ("/"+fileName);
		try {
			
			file.transferTo(new File(WebUtils.getSaveFileAbsolutePath()+desPath));
			
			if(oldFilePath!=null)
			(new File(WebUtils.getSaveFileAbsolutePath()+oldFilePath)).delete();
			
			return Constants.SAVE_BASE_UPLOAD_FOLDER+"/"+desPath;
		}catch (Exception e) {
			e.printStackTrace();
			return oldFilePath;
		}
		
	}
	
	
	/***
	 * 
	 * @param desPath目标目录相对路径
	 * 
	 * */
	public static List multipartFile(MultipartFile[] file,String desPath){
		List<String> list = new ArrayList<String>(file.length);
		new File(WebUtils.getSaveFileAbsolutePath()+desPath).mkdirs();
		if(file!=null)
		for (MultipartFile multipartFile : file) {
			if(multipartFile!=null){
				String fileSuffix = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf('.'));
				String fileName = desPath+"/"+GeneratedKeyUtils.getStrKey("")+fileSuffix;
				list.add(Constants.SAVE_BASE_UPLOAD_FOLDER+"/"+fileName);
				try {
					multipartFile.transferTo(new File(WebUtils.getSaveFileAbsolutePath()+fileName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	
	/**
	 * 
	 * copy file , to not suffix 
	 * 
	 * */
	public static String copyFile(String from,String to){
		to = to.replaceAll("\\\\", "/");
		if(to.substring(to.lastIndexOf('/')).lastIndexOf(".") == -1){
			to = to + from.substring(from.lastIndexOf('.'));
		}
		File fromFile = new File(WebUtils.getWebInfPath()+from);
		File toFile = new File(WebUtils.getSaveFileAbsolutePath()+to);
		copyFile(fromFile,toFile);
		return Constants.SAVE_BASE_UPLOAD_FOLDER+"/"+to;
	}
	
	
	
	
	/**
	 * 
	 * copy file , to not suffix 
	 * 
	 * */
	public static String copyFileTool(String from,String to,String savePath){
		if (ObjectUtils.isAllEmpty(from) || from.equals(to)) {
			return to;
		}
		if(!ObjectUtils.isNull(to)){
			new File(WebUtils.getSaveFileAbsolutePath()+"/"+to).delete();
		}
		to = savePath+"/"+GeneratedKeyUtils.getStrKey("");
		String retuernString = copyFile(from,to);
		if(from.indexOf("tempFiles")>-1){
			new File(WebUtils.getWebInfPath()+from).delete();
		}
		return retuernString;
	}
	
	
	/**
	 * 
	 * filePath is File path and File name.  the path is relatively path<br> 
	 * 
	 * */
	public static String readFileToString(String filePath){
		
		File file =  new File(WebUtils.getSaveFileAbsoluteNotUploadPath() + filePath);
		
		if (!file.exists()) {
			return null;
		}
		
		StringBuilder sb = new StringBuilder();
		
		BufferedReader br = null;
		
		try {
			br = new BufferedReader(  new InputStreamReader(new FileInputStream(file),"UTF-8")); 
			
			String line = null;
			
			while (( line = br.readLine()) != null) {
				sb.append(line);
				sb.append(System.lineSeparator());
			}
			return sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally{
			
			try{
				if(null!=br){
					br.close();
				}
			}catch (Exception e) {
			}
		}
		
		
		
	}
	
	
	/**
	 * 
	 * delFilePath is File path and File name.  the path is relatively path<br> 
	 * 
	 * */
	public static void delFile(String delFilePath){
		
		File file =  new File(WebUtils.getSaveFileAbsoluteNotUploadPath() + delFilePath);
		
		if (file.exists()) {
			file.delete();
		}
		
	}
	
	
	/**
	 * 
	 * filePath is File path and File name.  the path is relatively path<br>
	 * 
	 * */
	public static boolean WriteFile(String filePath,String content){
		File file =  new File(WebUtils.getSaveFileAbsoluteNotUploadPath()+ filePath);
		if (content==null) {
			content="";
		}
		
		file.getParentFile().mkdirs();
		
		BufferedOutputStream out = null;
		
		FileOutputStream fout = null;
		
		try {
			
			fout = new FileOutputStream(file);
			
			out = new BufferedOutputStream(fout);
			
			out.write(content.getBytes("UTF-8"));
			
			out.flush();
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally{
			if (out!=null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	
	}
	
	
	
	
	
	
	
	
	public static boolean copyFile(File from,File to){
			
		
		to.getParentFile().mkdirs();
		
		BufferedInputStream input = null;
		BufferedOutputStream out = null;
		try {
			input = new BufferedInputStream(new FileInputStream(from));
			
			out = new BufferedOutputStream(new FileOutputStream(to));
			
			byte [] b = new byte[200];
			int k = -1;
			
			while ((k=input.read(b)) > -1) {
				out.write(b,0, k);
				out.flush();
			}
			out.close();
			input.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}
	
	
	public static boolean checkExcelFileType(String fileType){
		boolean result = false;  
        if(ObjectUtils.isNotEmpty(fileType)) {  
            fileType = fileType.toUpperCase();  
            if("XLS".equals(fileType) || "XLSX".equals(fileType)) {  
                result = true;  
            }  
        }  
        return result; 
	}
	public static String valImgFile(CommonsMultipartFile file,Integer fileSize,Integer width,Integer heigth,String ... suffix){
		String msg = "";
		try {
			Long fsize = file.getSize() / 1024;
			String fileName = file.getOriginalFilename();
			String fileType = fileName.substring(fileName.lastIndexOf(".")+1);
			
			if (suffix !=null) {
				List<String> list = Arrays.asList(suffix);
				if(!list.contains(fileType.toUpperCase())){
					StringBuffer sb = new StringBuffer();
					for(String s:list){
						sb.append(s).append(",");
					}
					return msg = "请上传"+sb.substring(0,sb.length()-1)+"格式图片";
				}
			} 
			if(fileSize !=null && fileSize<fsize){
				return msg="图片大于"+fileSize+"K";
			}
			if(width!=null && heigth !=null){
				FileInputStream fs = (FileInputStream)file.getInputStream();
				BufferedImage buff = ImageIO.read(fs);
				if (buff.getWidth() != width || buff.getHeight() != heigth) {
					msg = "请上传"+width+"x"+heigth+"尺寸的图片";
				} 
				fs.close();
			}
			return msg;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		} 
	}
}
