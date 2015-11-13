<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include  file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>惠富海外投资后台管理 | 登录</title>
	<!-- BEGIN GLOBAL MANDATORY STYLES -->
<script src="${ctx}/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<link href="${ctx}/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

	<link href="${ctx}/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="${ctx}/media/css/login.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	 .logo1{position:relative;margin:130px auto 30px;width:240px;}
	 .logo1 img{position:relative;width:240px;}
	 
</style>
</head>
<body class="login" ">
<div class="test1">
</div>
	<div class="logo1">
<%--		<img src="${ctx}/media/image/logo.png"  alt="" /> --%>
	</div>

	<!-- END LOGO -->

	<!-- BEGIN LOGIN -->

	<div class="content">

		<!-- BEGIN LOGIN FORM -->

		<form class="form-vertical login-form" action="${ctx }/login" method="post" id="loginForm">

			<h3 class="form-title">登录</h3>

			<div class="alert alert-error ${error!=null?'show':'hide' }">

				<button class="close" data-dismiss="alert"></button>

				<span>${error!=null?error:'账号或密码不能为空' }</span>

			</div>

			<div class="control-group">

				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

				<label class="control-label visible-ie8 visible-ie9">账号</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-user"></i>

						<input class="m-wrap placeholder-no-fix" type="text" placeholder="Username" value="${account }" name="account"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">密码</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i>

						<input class="m-wrap placeholder-no-fix" type="password" placeholder="Password" value="${password }" name="password"/>

					</div>

				</div>

			</div>

			<div class="form-actions">

				<label class="checkbox">
					<input type="checkbox" ${remember==1?'checked=checked':'' } name="remember" value="1"/> 记住我
				</label>

				<button type="submit" class="btn green pull-right">

				Login <i class="m-icon-swapright m-icon-white"></i>

				</button>            

			</div>
			
			
			

			

		<!-- END REGISTRATION FORM -->

	</div>

	<!-- END LOGIN -->

	<!-- BEGIN COPYRIGHT -->

	<div class="copyright">

		Copyright &copy; 上海英特福斯营销策划有限公司 INTERFOCUS.CN All Rights Reserved.

	</div>

	<!-- END COPYRIGHT -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	

	<script src="${ctx}/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="${ctx}/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="${ctx}/media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>

	<script src="${ctx}/media/js/excanvas.min.js"></script>

	<script src="${ctx}/media/js/respond.min.js"></script>  

	<![endif]-->   

	<script src="${ctx}/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="${ctx}/media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="${ctx}/media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="${ctx}/media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="${ctx}/media/js/jquery.validate.min.js" type="text/javascript"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="${ctx}/media/js/app.js" type="text/javascript"></script>

	<script src="${ctx}/media/js/login.js" type="text/javascript"></script>      

	<!-- END PAGE LEVEL SCRIPTS --> 

	<script>

		jQuery(document).ready(function() {     
		  App.init();

		  Login.init();

		});

	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->

</html>