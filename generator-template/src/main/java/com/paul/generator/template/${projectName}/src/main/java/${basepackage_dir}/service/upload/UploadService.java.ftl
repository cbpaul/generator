package ${basepackage}.service.upload;

import javax.servlet.http.HttpServletRequest;

public abstract interface UploadService
{
  public abstract String jqueryUpload(HttpServletRequest paramHttpServletRequest, String paramString1, String paramString2);
  
  public abstract String getJqueryUploadJSON(String paramString, Long paramLong);
}





