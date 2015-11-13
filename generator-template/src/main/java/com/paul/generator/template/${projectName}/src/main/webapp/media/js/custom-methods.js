jQuery.validator.addMethod('mobile', function(value, element) {
	return this.optional(element) || /^1[3|4|5|8][0-9]\d{8}$/.test(value);
}, "请输入合法的手机号码.");
jQuery.validator.addMethod('loginName', function(value, element) {
	return this.optional(element) || /^[0-9a-zA-Z]{4,14}$/.test(value);
}, "请输入4-14位字母或数字.");
jQuery.validator.addMethod('posAccount', function(value, element) {
	return this.optional(element) || /^[a-zA-Z0-9_]{3,15}$/.test(value);
}, "请输入3-15位字母或数字.");
jQuery.validator.addMethod('password', function(value, element) {
	return this.optional(element) || /^[0-9a-zA-Z]{6,16}$/.test(value);
}, "请输入6-16位字母或数字.");
//身份证号
jQuery.validator.addMethod('idCard', function(value, element) {
	return this.optional(element) || checkCard(value);
}, "请输入正确的身份证号");
//车架号
jQuery.validator.addMethod('autoFrameNum', function(value, element) {
	return this.optional(element) || /^[0-9a-zA-Z]{17}$/.test(value);
}, "请输入17位车架号");
//用户名
jQuery.validator.addMethod('userName', function(value, element) {
	if(getByteLen(value)>16){
		return false;
	}
	return true;
}, "用户名不能大于16位");
//微博内容
jQuery.validator.addMethod('msgContent', function(value, element) {
	if(getByteLen(value)>280){
		return false;
	}
	return true;
}, "内容不能大于280位");
//角色名称
jQuery.validator.addMethod('roleName', function(value, element) {
	if(getByteLen(value)>50){
		return false;
	}
	return true;
}, "名称不能大于50位");
//精华帖名称
jQuery.validator.addMethod('msgTypeName', function(value, element) {
	if(getByteLen(value)>50){
		return false;
	}
	return true;
}, "名称不能大于50位");
//昵称
jQuery.validator.addMethod('nickName', function(value, element) {
	var len = getByteLen(value);
	if(len>30 || len<4){
		return false;
	}
	return this.optional(element) || /^(\w+)|([\u0391-\uFFE5]+)$/.test(value);
}, "昵称4-30位字符，汉字，字母，数字组成");
//浮点与整型
jQuery.validator.addMethod('float', function(value, element) {
	return this.optional(element) || /^\d+(\.\d+)?$/.test(value);
}, "请输入整数或小数");
//整型
jQuery.validator.addMethod('num', function(value, element) {
	return this.optional(element) || /^\+?[1-9][0-9]*$/.test(value);
}, "请输入整数");
//地址
jQuery.validator.addMethod('url', function(value, element) {
	return IsURL(value);
}, "地址格式错误");
jQuery.validator.addMethod('urlNull', function(value, element) {
	if(value){
		return IsURL(value);
	}else{
		return true;
	}
}, "地址格式错误");
//地址
jQuery.validator.addMethod('percent', function(value, element) {
	return this.optional(element) ||value<=100;
}, "不能大于100");

function getByteLen(val) {
            var len = 0;
            for (var i = 0; i < val.length; i++) {
                 var a = val.charAt(i);
                 if (a.match(/[^\x00-\xff]/ig) != null) 
                {
                    len += 2;
                }
                else
                {
                    len += 1;
                }
            }
            return len;
        }
function IsURL (str_url) {
	var strRegex = '^((https|http|ftp|rtsp|mms)?://)'
		+ '?(([0-9a-z_!~*\'().&=+$%-]+: )?[0-9a-z_!~*\'().&=+$%-]+@)?' //ftp的user@
		+ '(([0-9]{1,3}.){3}[0-9]{1,3}' // IP形式的URL- 199.194.52.184
		+ '|' // 允许IP和DOMAIN（域名）
		+ '([0-9a-z_!~*\'()-]+.)*' // 域名- www.
		+ '([0-9a-z][0-9a-z-]{0,61})?[0-9a-z].' // 二级域名
		+ '[a-z]{2,6})' // first level domain- .com or .museum
		+ '(:[0-9]{1,4})?' // 端口- :80
		+ '((/?)|' // a slash isn't required if there is no file name
		+ '(/[0-9a-z_!~*\'().;?:@&=+$,%#-]+)+/?)$';
	var re=new RegExp(strRegex);
	//re.test()
	if (re.test(str_url)) {
		return true;
	} else {
		return false;
	}
} 