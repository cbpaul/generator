<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>惠富海外投资后台管理</title>
<meta content="width=device-width, initial-scale=1.0-SNAPSHOT" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<link href="media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/bootstrap-responsive.min.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/bootstrap-fileupload.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="media/css/style.css" rel="stylesheet" type="text/css" />
<link href="media/css/style-responsive.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/default.css" rel="stylesheet" type="text/css"
	id="style_color" />
<link href="media/css/bootstrap-toggle-buttons.css" rel="stylesheet"
	type="text/css" />
	<link href="media/css/uniform.default.css" rel="stylesheet"
	type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css" href="media/css/select2_metro.css" />
<link rel="stylesheet" href="media/css/DT_bootstrap.css" />
<!-- END PAGE LEVEL STYLES -->

<!-- BEGIN SCO STYLES -->
<link rel="stylesheet" type="text/css" href="media/css/sco.message.css" />
<!-- END SCO STYLES -->

<!-- BEGIN DATE STYLES -->
<link rel="stylesheet" type="text/css" href="media/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="media/css/timepicker.css" />
<link rel="stylesheet" type="text/css" href="media/css/jquery.tagsinput.css" />
<link rel="stylesheet" type="text/css" href="media/css/daterangepicker.css" />
<link rel="stylesheet" type="text/css" href="media/css/datetimepicker.css" />

<!-- 编辑器 -->
<link rel="stylesheet" type="text/css"
	href="media/Redactor/css/redactor.css" />
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body class="page-header-fixed">
	<!-- BEGIN HEADER -->
	<div class="header navbar navbar-inverse navbar-fixed-top">
		<!-- BEGIN TOP NAVIGATION BAR -->
		<div class="navbar-inner">
			<div class="container-fluid">
				<!-- BEGIN LOGO -->
				<!-- END LOGO -->

				<!-- BEGIN RESPONSIVE MENU TOGGLER -->
				<a href="javascript:;" class="btn-navbar collapsed"
					data-toggle="collapse" data-target=".nav-collapse"> <img
					src="media/image/menu-toggler.png" alt="" /> </a>
				<!-- END RESPONSIVE MENU TOGGLER -->

				<!-- BEGIN TOP NAVIGATION MENU -->
				<ul class="nav pull-right">

					<!-- BEGIN USER LOGIN DROPDOWN -->

					<li class="dropdown user"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <img alt=""
							src="media/image/avatar1_small.jpg" /> <span class="username">${r"${sessionUSER
								}</span> <i class="icon-angle-down"></i> </a>
						<ul class="dropdown-menu">

							<li><a href="${r"${ctx}"}logout"><i class="icon-key"></i> 注销</a>
							</li>

						</ul>
					</li>

					<!-- END USER LOGIN DROPDOWN -->

				</ul>

				<!-- END TOP NAVIGATION MENU -->

			</div>

		</div>

		<!-- END TOP NAVIGATION BAR -->

	</div>

	<!-- END HEADER -->

	<!-- BEGIN CONTAINER -->

	<div class="page-container row-fluid">

		<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

		<div id="portlet-config" class="modal hide">

			<div class="modal-header">

				<button data-dismiss="modal" class="close" type="button"></button>

				<h3>Widget Settings</h3>

			</div>

			<div class="modal-body">

				<p>Here will be a configuration form</p>

			</div>

		</div>

		<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

		<!-- BEGIN SIDEBAR1 -->

		<div class="page-sidebar nav-collapse collapse">
			<!-- BEGIN SIDEBAR MENU1 -->
			<ul class="page-sidebar-menu">
				<li class="start"><a class="ajaxify start" action="home"> <i
						class="icon-home"></i> <span class="title">主页</span> <span
						class="selected"></span> </a></li>
			<!-- -------------------菜单-------------------------------- -->
				<t:menu />
			</ul>
			<!-- END SIDEBAR MENU1 -->
		</div>
		<!-- END SIDEBAR1 -->

		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<div class="page-content-body"></div>
			</div>
			<!-- HERE WILL BE LOADED AN AJAX CONTENT -->
		</div>

		<!-- BEGIN PAGE -->

	</div>

	<!-- END CONTAINER -->

	<!-- BEGIN FOOTER -->
	<div class="footer">
		<div class="footer-inner">Copyright &copy; 上海英特福斯营销策划有限公司
			INTERFOCUS.CN All Rights Reserved.</div>
		<div class="footer-tools">
			<span class="go-top"> <i class="icon-angle-up"></i> </span>
		</div>
	</div>
	<!-- 文件上传验证 -->
	<img id="filevalid" alt="" src="" style="display: none"></img>
	<!-- END FOOTER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->
	<script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="media/js/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>
	<script src="media/js/excanvas.min.js"></script>
	<script src="media/js/respond.min.js"></script>  
	<![endif]-->

	<script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>
	<script src="media/js/jquery.uniform.min.js" type="text/javascript"></script>
	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="media/js/select2.min.js"></script>
	<script type="text/javascript" src="media/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="media/js/DT_bootstrap.js"></script>
	<script type="text/javascript" src="media/js/datatable-common.js"></script>
	<script type="text/javascript" src="media/js/jquery.tagsinput.min.js"></script>
	<script type="text/javascript" src="media/js/jquery.toggle.buttons.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN SCO PLUGINS -->
	<script type="text/javascript" src="media/js/sco.message.js"></script>
	<script type="text/javascript" src="media/js/sco.confirm.js"></script>
	<script type="text/javascript" src="media/js/sco.modal.js"></script>
	<!-- END SCO PLUGINS -->

	<!-- BEGIN FORM VALIDATE PLUGINS -->
	<script type="text/javascript" src="media/js/jquery.validate.js"></script>
	<script type="text/javascript" src="media/js/jquery.validate.zh.js"></script>
	<script type="text/javascript" src="media/js/additional-methods.min.js"></script>
	<script type="text/javascript" src="media/js/custom-methods.js"></script>
	<script type="text/javascript" src="media/js/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kOWATK4ihKe8AGeg09TUGzap"></script>
	<!-- END FORM VALIDATE PLUGINS -->

	<!-- BEGIN FANCYBOX PLUGINS -->
	<script type="text/javascript" src="media/js/jquery.fancybox.pack.js"></script>
	<!-- END FANCYBOX PLUGINS -->
	<script type="text/javascript" src="media/js/bootstrap-fileupload.js"></script>

	<!-- BEGIN DATE TIME PLUGINS -->
	<script type="text/javascript" src="media/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript"
		src="media/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="media/js/bootstrap-timepicker.js"></script>
	<script type="text/javascript" src="media/js/date.js"></script>
	<!-- END DATE TIME PLUGINS -->

	<script type="text/javascript"
		src="media/js/jquery.inputmask.bundle.min.js"></script>
	<script type="text/javascript" src="media/js/form-components.js"></script>
	<script type="text/javascript" src="media/js/jquery.multi-select.js"></script>
	<script type="text/javascript" src="media/js/jquery.multiselect2side.js"></script>
	<script type="text/javascript" src="media/js/bootstrap-modal.js"></script>
	<script type="text/javascript" src="media/js/bootstrap-modalmanager.js"></script>
	<!-- 地区 -->
	<script type="text/javascript" src="media/js/areaData.js"></script>
	<!-- 物流 -->
	<script type="text/javascript" src="media/js/logisticsCode.js"></script>
	<script src="media/js/app.js"></script>
	<!-- 编辑器 -->
	<script src="media/Redactor/js/redactor.js"></script>
	<script src="media/Redactor/js/zh_cn.js"></script>
	<!-- 数组操作 -->
	<script src="media/js/array.js"></script>
	<script type="text/javascript" src="media/js/CheckIDCard.js"></script>
	<script type="text/javascript" src="${r"${ctx }"}media/js/imgUpload.js"></script>
	<script src="media/js/jquery.fancybox.pack.js"></script>
	<script src="media/js/daterangepicker.js"></script>
	 <script type="text/javascript" src="scripts/swfobject.js"></script>
      <script type="text/javascript" src="scripts/fullAvatarEditor.js"></script>
	<script type="text/javascript" src="media/zeroclipboard/ZeroClipboard.Core.js"></script>
    <script type="text/javascript" src="media/zeroclipboard/ZeroClipboard.min.js"></script>
	<script>
	
	if (!RedactorPlugins) var RedactorPlugins = {};
	RedactorPlugins.advanced = {
	    init: function ()
	    {
	        this.addBtn('advanced', '预览', this.testButton);
	        // make your added button as Font Awesome's icon
	        //this.buttonAwesome('advanced', 'fa-tasks');
	    },
	    testButton: function(buttonName, buttonDOM, buttonObj, e)
	    {
	    	jQueryOpenPostWindow("browsHtml.jsp",$(".redactor_editor").html(),"html","预览");
	    }
	};
		jQuery(document).ready(function() {
			App.init();
			$("#myModal").hide();
			$("#uploadModal").hide();
			$('.page-sidebar .ajaxify.start').click() // load the content for the dashboard page.
			$('input[id=lefile]').change(function() {
				$('#photoCover').val($(this).val());
			});
		});
	</script>

	<!-- END JAVASCRIPTS -->

	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-37564768-1' ]);
		_gaq.push([ '_setDomainName', 'keenthemes.com' ]);
		_gaq.push([ '_setAllowLinker', true ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://'
					: 'http://')
					+ 'stats.g.doubleclick.net/dc.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
		
	</script>
	<!-- 弹框 上传头像-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
					<h4 class="modal-title" id="myModalLabel">上传图片</h4>
				</div>
				<div class="modal-body" style="overflow-y: none; max-height: 450px">
					<div style="width:570px;height:410px;" id="flashDiv">
						<div id="altContent">
							
						</div>
					</div>

				</div>
				<div class="modal-footer">
						<button type="submit" id="swfupload" class="btn btn-primary">上传</button>
						<button type="button" id="swfcancel" class="btn btn-default">关闭</button>
					</div>
				<!-- /.modal-content -->
				<!--  <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" id="comfirmUpload" class="btn btn-primary">确认</button>
      </div> -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	</div>
	<!-- 弹框 上文件-->
	<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog"
		aria-labelledby="uploadModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" action="" target="hidden_frame"
					method="post" enctype="multipart/form-data">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title" id="uploadModal">导入数据</h4>
					</div>
					<div class="modal-body">
						<input id="lefile" name="file" type="file" style="display:none">
						<div class="input-append">
							<input id="photoCover" class="input-large" type="text"
								style="height:25px;"> <a class="btn"
								onclick="$('input[id=lefile]').click();">选择</a>
						</div>
						<div>
							<span class="error"
								style="color: red;font-size: 12 ;margin-top: 4px"></span>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="submit" id="comfirmUpload" class="btn btn-primary">上传</button>
					</div>
					<iframe name="hidden_frame" id="hidden_frame" style="display: none">
					</iframe>
				</form>
			</div>
		</div>
	</div>
	<iframe name="uploadFile" style="display: none;"> </iframe>
</body>

<script>
	//上传文件回调
	function callback(msg) {
		if (msg.code == 200) {
			$("#uploadModal").modal("hide");
			TableCommon.success(msg.info);//提示操作成功
		} else {
			$(".error").show().text(msg.info);
			//TableCommon.error(msg.info);//提示操作失败
		}
	}
	//券码上传回调
	function couponCallback(msg) {
		if (msg.code == 200) {
			$("#uploadModal").modal("hide");
			//TableCommon.success(msg.info);//提示操作成功
			$('#'+msg.info[0].coupon_input_id).val(msg.info[0].content);
			$('#'+msg.info[0].awards_num_id).val(msg.info[0].count);
			$('#'+msg.info[0].coupon_path_id).attr('href',msg.info[0].path);
		} else {
			$(".error").show().text(msg.info);
		}
	}
	function activityCallBack(msg) {
		if (msg.code == 200) {
			TableCommon.success(msg.info);//提示操作成功
			App.forwardAjax(msg.callPath, "get");
		} else {
			if (msg.callPath.length == 0) {
				TableCommon.error(msg.info);
			} else {
				$("#errorlab").addClass("has_children");
				$("#errorlab").html(msg.info);
			}
		}
	}
</script>

<!-- END BODY -->
</html>