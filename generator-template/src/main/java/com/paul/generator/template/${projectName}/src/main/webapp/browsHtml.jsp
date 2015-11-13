<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="cn.interfocus.rmweixing.tools.WebUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>乐养车</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script>
			var window_width;
			$(function(){
				window_width = $(window).width();
				$('.innerBox').find('table').each(function(){
					var table_width = $(this).width();
					if(window_width<table_width){
						$(this).css('width','100%');
					}
				});
				$('.innerBox').find('img').addClass('innerImg');
				
// 				$('.innerBox').find('img').each(function(){
// 					var img_width = $(this).width();
// 					if(window_width<img_width){
						$(this).remove("height");
// 					}
// 				});
			});
//跨域算高度
		/**	function sethash(){
			    hashH = document.documentElement.scrollHeight; 
			    urlC = "http://121.52.218.240:81/if4s/wx/agent.html"; 
			    document.getElementById("iframeC").src=urlC+"#"+hashH; 
			}
			window.onload=sethash;**/
		
</script>
<%	
	String userAgent = request.getHeader("User-Agent").toLowerCase();
	
	
	
	if(userAgent.contains("ipad")   || userAgent.contains("iphone") ||  userAgent.contains("java")  || 
			 userAgent.contains("mobile") || userAgent.contains("android") ){
			 
			// System.out.println(userAgent+"-------手机访问的--------------------");
		%>
		<meta name="viewport" content="width=device-width,minimum-scale=1.0-SNAPSHOT,maximum-scale=1.0-SNAPSHOT,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		
		<style type="text/css">
			p,a{padding:0;margin:0;word-wrap:break-word}
			img{border:0 none;}
			.warp{position:relative;width:100%;margin:0 auto;word-break: break-all;height:100%;}
			.innerBox{position:relative;padding:8px 0px;width:100%;}
			body{font-size:16px;font-family:"黑体";}
			.inner{width:100%;}
			.table_news{width:100%;}
			.innerBox .innerImg{width:100%;display:block;position:relative;margin:0 auto;}
		</style>
	
		
		<%
	}else{
		// System.out.println(userAgent+"-------电脑访问的--------------------");
		%>
		
		
		<style type="text/css">
		p,a{padding:0;margin:0;word-wrap:break-word}
		img{border:0 none;}
		.inner{width:100%;}
		.table_news{width:100%;}
		.cmNewsDetail p{color:#8c8c8c;font-size:14px;}
		.cmNewsSp{font-size:14px;font-weight:normal;color:#8c8c8c;text-indent:2em;line-height:26px;}
		.cmNewsTitle{color:#d0d0d0;font-family:micrsoft yahei;font-size:18px;}
		.cmNewsTime{color:#d0d0d0;font-size:12px;}
	    .innerBox .innerImg{width:100%;display:block;position:relative;margin:0 auto;}
		</style>
		
		
		
		
		<%
	}
%>

</head>
<body>
<div class="warp">
<div class="innerBox">
            <% String html = (String)request.getParameter("html"); 
               String content="";
               if(html!=null && !"".equals(html) ){
            	 	out.print(html);
               }else{
            %>
            	页面不存在。
            <%
               }
            %>
   			
	</div>
	</div>
	</body> 
</html>




