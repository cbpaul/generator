var isMobile = {
	Android: function() {
		return navigator.userAgent.match(/Android/i) ? true : false;
	},
	BlackBerry: function() {
		return navigator.userAgent.match(/BlackBerry/i) ? true : false;
	},
	iOS: function() {
		return navigator.userAgent.match(/iPhone|iPad|iPod/i) ? true : false;
	},
	Windows: function() {
		return navigator.userAgent.match(/IEMobile/i) ? true : false;
	},
	any: function() {
		return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Windows());
	}
};

$(function(){
	var inHtml = '<div class="prompt_box"></div><div class="prompt_box"><span></span></div>';
	$("body").append(inHtml);
	
	$.setMenu("ul.c_menu"); //Main menu
});


/***Prompt*/
$.promptBox = function(txt){
	var txt  = txt==null ? "请按要求填写~" : txt,
		o    = $("div.prompt_box"),
		oTop = 0;
	
	o.show().find("span").html(txt);
	oTop = Math.floor(($(window).height()-o.find("span").innerHeight())/2);
	o.css("paddingTop", oTop);
	o.delay(1500).fadeOut(200);
}


/***弹出窗口*/
$.friBox = function(){
	var o    = $("div.conv_co"),
		p    = $("div.conv_bg"),
		oTop = Math.floor(($(window).height()-o.height())/2);
		oTop = oTop<0 ? 0 : oTop;
	
	p.fadeIn(200);
	o.css("top", oTop).fadeIn(200);

	o.on("click", "input.inpte", function(){
		setTimeout(function(){
			var oTop = Math.floor(($(window).height()-o.height())/2);
			o.css("top", oTop);
		}, 300);
	});
	
	if(o.is(":visible")) {
		function setBoxH(){
			var oTop = Math.floor(($(window).height()-o.height())/2);
			o.css("top", oTop);
		}
		ST = setInterval(setBoxH, 500);
	}
}

$.friBoxClose = function(){
	var o    = $("div.conv_co"),
		p    = $("div.conv_bg");

	clearInterval(ST);
	p.fadeOut(300);
	o.fadeOut(300);
}

/***登陆**/

var wait=60;

function send(o){
	var phone = $("#phone_").val();
	if(/^\s*$/.test(phone)){
		$.promptBox("电话号码不能为空！");
		return;
	}
	if (phone.length != "11") {
		$.promptBox("请输入正确的电话号码！");
		return true;
	} 
	var p1 = /^(13\d{9})|(15\d{9})|(18\d{9})|(0\d{10,11})$/;
	if (!p1.test(phone)) {
		$.promptBox("电话号码格式错误！");
		return true;
	}
	time(o,phone);
	
}

function time(o,mobile) {
	if(wait==60){
		$.ajax( {
			type : "POST",
			dataType:"json",
			url :"/lyc/WeiXin/smsVerifyCode",
			data :"mobile="+mobile,
			success : function(data) {
				var response = data.response;
				if(response.code == 0){
					$.promptBox("短信已经发送！");
				}else{
					wait=0;
					$.promptBox(response.msg);
				}
			},
			error : function(XMLHttpRequest, textStatus,
					errorThrown) {
			}
			});
	}
	if (wait <= 0) {
		o.removeAttribute("disabled");			
		o.innerHTML="发送登陆密码";
		wait = 60;
	} else {
		o.setAttribute("disabled", true);
		o.innerHTML= wait + "秒后重新获取";
		wait--;
		
	setTimeout(function() {time(o)},1000);
	}
}


function bingFans(openid){
	var phone = $("#phone_").val();
	if(/^\s*$/.test(phone)){
		$.promptBox("电话号码不能为空！");
		return;
	}
	if (phone.length != "11") {
		$.promptBox("请输入正确的电话号码！");
		return true;
	} 
	var p1 = /^(13\d{9})|(15\d{9})|(18\d{9})|(0\d{10,11})$/;
	if (!p1.test(phone)) {
		$.promptBox("电话号码格式错误！");
		return true;
	}
	var code = $("#code_").val();
	if (code.length != "6") {
		$.promptBox("验证码未不正确填写!");
		return true;
	} 
	
	$.ajax( {
		type : "POST",
		dataType:"json",
		url :"/lyc/WeiXin/login",
		data :"mobile="+phone+"&smsVerifyCode="+code+"&openid="+openid,
		success : function(data) {
			var response = data.response;
			if(response.code == 0){
				$.friBoxClose();
				$.promptBox("登陆成功!");
				$("#uuid").val(response.userInfo.uid);
			}else{
				wait=0;
				$.promptBox(response.msg);
			}
		},
		error : function(XMLHttpRequest, textStatus,
				errorThrown) {
		}
		});
}


/*Main menu*/
$.setMenu = function(o){
	var o = $(o);
	
	o.find("li > a").on("click", function(){
		var c = $(this),
			h = c.next().height();
		if(c.parent().is(".on")) {
			c.next().stop(true, false).animate({
				"height" : 0
			}, 200, function(){
				c.next().removeAttr("style");
				c.parent().removeClass("on");
			});
		} else {
			c.parent().addClass("on");
			c.next().height(0).stop(true, false).animate({
				"height" : h
			}, 200);
		}
	});
	
	o.find("div a.on").parent().prev().find("i").css("display", "block");
}


/***Pub Dialog*/
$.dialogBox = function(o){
	var o    = o == null ? $("div.dialog_box") : $(o),
		p    = $("div.shade_box"),
		oTop = Math.floor(($(window).height()-o.height())/2);
		oTop = oTop<0 ? 0 : oTop;
	
	p.fadeIn(200);
	o.css("top", oTop).fadeIn(200);
	
	$(window).resize(function(){
		oTop = Math.floor(($(window).height()-o.height())/2);
		o.animate({
			"top" : oTop
		}, 200);
	});
	
	if(o.find("#dg_close").length>0) {
		o.find("#dg_close").on("click", function(){
			p.fadeOut(300);
			o.fadeOut(300);
		});
	}

	if(o.find(".dg_close").length>0) {
		o.find(".dg_close").on("click", function(){
			p.fadeOut(300);
			o.fadeOut(300);
		});
	}
}