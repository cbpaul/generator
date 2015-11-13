/**
 * Created with JetBrains PhpStorm.
 * User: user
 * Date: 13-10-15
 * Time: 上午10:06
 * To change this template use File | Settings | File Templates.
 */
function Validate(){
    Validate.prototype.name=function(){
        if($("input[name='name']").val()==''){
        	$.promptBox("请输入称呼");
            return false;
        }
        return true;
    }
    Validate.prototype.mobile = function(){
        var mobileVal = $("input[name='mobile']").val();
        if(mobileVal==''){
        	$.promptBox("请输入手机号码");
            return;
        }
        var length = mobileVal.length;
        var mobile = /^1[3|4|5|8][0-9]\d{8}$/;
        var bool = (length == 11 && mobile.exec(mobileVal))? true:false;
        if(!bool){
        	$.promptBox("手机号格式错误");
            return false;
        }
        return true;
    }
    Validate.prototype.code = function(){
        var code = $("input[name='code']").val();
        if(code==''){
        	$.promptBox("验证码不能为空");
            return false;
        }
        return true;
    }

    Validate.prototype.brand = function(defaultVal){
    	var brand = $("#brand").val();
    	if(brand=='' || brand == defaultVal){
    		alert("请选择品牌");
    		return false;
    	}
    	return true;
    }
    Validate.prototype.series = function(defaultVal){
    	var series = $("#series").val();
    	if(series=='' || series==defaultVal){
    		alert("请选择车系");
    		return false;
    	}
    	return true;
    }
    Validate.prototype.car = function(defaultVal){
    	var car = $("#car").val();
    	if(car=='' || car == defaultVal){
    		alert("请选择车型");
    		return false;
    	}
    	return true;
    }
    Validate.prototype.mileage = function(){
       var mileage = $("input[name='mileage']").val();
        if(mileage == ''){
            alert("请填写行驶里程");
            return false;
        }
        return true;
    }
    Validate.prototype.autoPlateNum=function(){
        var autoPlateNum = $("input[name='autoPlateNum']").val();
        if(autoPlateNum ==''){
        	$.promptBox("车牌号不能为空");
            return false;
        }
        var re=/^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5}$/;
        if(!re.exec(autoPlateNum)){
        	$.promptBox("车牌号格式错误");
            return false;
        }else{
            return true;
        }
    }
    Validate.prototype.appointTime = function(){
        var appointTime = $("input[name='appointmentTime']").val();
        if(appointTime == '' || appointTime=='请选择预约保养时间'){
        	$.promptBox("请选择预约时间");
            return false;
        }
        return true;
    }
   Validate.prototype.password=function(password){
       if(!password || password==''){
           alert("密码不能为空");
           return false;
       }
       return true;
   }
   Validate.prototype.pwdeq = function(pwd,confirmPwd){
       if(pwd==""){
           alert("请输入密码");
           return false;
       }
       if(confirmPwd == ''){
          alert("请输入确认密码");
           return false;
       }
       if(confirmPwd != pwd){
           alert("两次密码不一致");
           return false;
       }
       return true;
   }
}


