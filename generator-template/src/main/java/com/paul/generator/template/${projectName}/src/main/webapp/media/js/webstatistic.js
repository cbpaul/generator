!function ($) {
	var CHARS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
	var startTime=new Date().getTime();
	var Statistic=function (element, options) {
		this.init(element, options);
	};
		
	Statistic.prototype={
		constructor: Statistic,
		init: function (element, options) {
			this.options = options;
		},
		uuid:function(){
			var chars = CHARS, uuid = new Array(36), rnd=0, r;
		    for (var i = 0; i < 36; i++) {
		      if (i==8 || i==13 ||  i==18 || i==23) {
		        uuid[i] = '-';
		      } else if (i==14) {
		        uuid[i] = '4';
		      } else {
		        if (rnd <= 0x02) rnd = 0x2000000 + (Math.random()*0x1000000)|0;
		        r = rnd & 0xf;
		        rnd = rnd >> 4;
		        uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
		      }
    		}
    		return uuid.join('');
		},
		getCookie:function(c_name){
			if (document.cookie.length > 0) {
		        c_start = document.cookie.indexOf(c_name + "=");
		        if (c_start != -1) {
		            c_start = c_start + c_name.length + 1;
		            c_end = document.cookie.indexOf(";", c_start);
		            if (c_end == -1) {
		                c_end = document.cookie.length;
		            }
		            return unescape(document.cookie.substring(c_start, c_end));
		        }
		    }
    		return "";
		},
		setCookie:function(c_name, value, expiredays){
			 var exdate = new Date();
    		 exdate.setDate(exdate.getDate() + expiredays);
    		 document.cookie = c_name + "=" + escape(value) + ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString());
		},
		setStatId:function(){
			var uuid=this.uuid();
			var expiresDate= new Date();
			this.setCookie("statisticID",uuid,Math.random() * 3000000);
		},
		getStatId:function(){
			var uuid = this.getCookie("statisticID");
			 if (uuid != null && uuid.length > 0) {
		        return uuid;
		    } else {
		        this.setStatId();
		        return this.getStatId();
		    }
		},
		/**
		 *获取浏览器类型 
		 */
		getBrower:function(){
			 var ua = navigator.userAgent;
		    if (ua.length > 250) {
		        ua = ua.substring(0, 250);
		    }
		    if (ua.indexOf("Maxthon") != -1) {
		        return "Maxthon";
		    } else if (ua.indexOf("MSIE") != -1) {
		        return "MSIE";
		    } else if (ua.indexOf("Firefox") != -1) {
		        return "Firefox";
		    } else if (ua.indexOf("Chrome") != -1) {
		        return "Chrome";
		    } else if (ua.indexOf("Opera") != -1) {
		        return "Opera";
		    } else if (ua.indexOf("Safari") != -1) {
		        return "Safari";
		    } else {
		        return "ot";
		    }
		},
		/**
		 *获取浏览器语言 
		 */
		getBrowerLanguage:function(){
			 var lang = navigator.browserLanguage;
    		 return lang != null && lang.length > 0 ? lang : "";
		},
		/**
		 * 操作系统
		 */
		getPlatform:function(){
			return navigator.platform;
		},
		/**
		 *页面tite 
		 */
		getUtmdt:function(){
			return $("title").text();
		},
		/**
		 *浏览器分辨率 
		 */
		getUtmsr:function(){
			return $(window).height()+"x"+$(window).width();
		},
		/**
		 *用户浏览器语言 
		 */
		getUtmul:function(){
			return navigator.language;
		},
		/**
		 *浏览器是否支持java 
		 */
		getUtmje:function(){
			return navigator.javaEnabled();
		},
		/**
		 *flash版本与是否安装 
		 */
		flashChecker:function(){
			var hasFlash = 0;　　　　 
    		var flashVersion = 0;　  
    		if(document.all) {  
        	 	var swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');  
        	 	if(swf) {  
            		hasFlash = 1;  
            		VSwf = swf.GetVariable("$version");  
            		flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);  
        		}  
    		} else {  
       			if(navigator.plugins && navigator.plugins.length > 0) {  
	            	var swf = navigator.plugins["Shockwave Flash"];  
	           		if(swf) {  
	       				 hasFlash = 1;  
	                	var words = swf.description.split(" ");  
	                	for(var i = 0; i < words.length; ++i) {  
	                   			if(isNaN(parseInt(words[i]))) continue;  
	                    		flashVersion = parseInt(words[i]);  
	                	}  
	            	}  
        		}  
    		}
    		return  {f:hasFlash,v:flashVersion};  
		},
		/**
		 *得到flash版本 
		 */
		getUtmfl:function(){
			return this.flashChecker().v;
		},
		getUtmr:function(){
			return encodeURIComponent(document.referrer);
		}
	};
	var settings = {};
	$.fn.statistic=function(option){
		return this.each(function () {
			var $this = $(this);
			$.extend(settings, $.fn.statistic.defaults, option);
			var staObj=new Statistic(this,settings);
			var postData=settings.postData;
			$.fn.statistic.subPost(postData,staObj);
		});
	};
	/**
	 *type 类型 0:普通1：点击之类的事件（eventName为事件名称） 3：用户自定变量 
	 *eventName 事件名称
	 *variables 自定义变量
	 */
	$.fn.statistic.defaults = {
		updata_url:"http://localhost:8080/rmp/webstatic/sm",
		finishLoadpost:true,
		postData:{},
		eventName:"",
		variables:""
	};
	$.fn.statistic.subPost=function(postData,staObj){
		var endTime=new Date().getTime();
		postData['utmwv']=1.0;
		postData['utmn']=new Date().getTime();
		postData['utmsr']=staObj.getUtmsr();
		postData['utmul']=staObj.getUtmul();
		postData['utmje']=staObj.getUtmje();
		postData['utmfl']=staObj.getUtmfl();
		postData['utmdt']=staObj.getUtmdt();
		postData['event']=staObj.options.eventName;
		postData['variables']=staObj.options.variables;
		postData['platform']=staObj.getPlatform();
		postData['utmhid']=new Date().getTime();
		postData['utmr']=staObj.getUtmr();
		postData['utmlt']=endTime-startTime;
		postData['uid']=staObj.getStatId();
		postData['utmhn']= document.domain;
		postData['url']=encodeURIComponent(document.URL);
		console.info(postData);
		$.get(settings.updata_url,postData,function(){
			alert("上传完成");
		});
	};
	$(function () {
		//为带有样式clickstatistic注册点击事件
		$(document).on('click.stattistic', ' .clickstatistic', function ( e ) {
			var eventName= $(this).attr("sta-eventname")||"";//统计事件名称
			var option = $.extend({}, {'eventName':eventName,type:1});
			$(this).statistic(option);
		});
		$(document).statistic();
	});
}(window.jQuery);	
