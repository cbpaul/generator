 package ${basepackage}.service.upload.impl;
 
 import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ${basepackage}.service.upload.UploadService;
import ${basepackage}.utils.FileUtils;
import ${basepackage}.utils.GeneratedKeyUtils;
import ${basepackage}.utils.ObjectUtils;
 
 @Component
 public class UploadServiceImpl
   implements UploadService
 {
   public String jqueryUpload(HttpServletRequest img, String savePath, String fileName)
   {
     if ((img instanceof MultipartHttpServletRequest))
     {
       if (null == fileName) {
         fileName = GeneratedKeyUtils.getStrKey("");
       }
       if (savePath == null) {
    	   
       }
       try
       {
         return FileUtils.upLoadFile(img, null, savePath, fileName);
       }
       catch (Exception e)
       {
         e.printStackTrace();
         return null;
       }
     }
     return null;
   }
   
   public String getJqueryUploadJSON(String urlPath, Long id)
   {
     if (ObjectUtils.isNotEmpty(urlPath)) {
       return "{\"files\":[{\"filelink\":\"" + urlPath + "\",\"id\":\"" + id + "\"}]}";
     }
     return "{\"files\":[{\"error\":\"500\"}]}";
   }
 }





