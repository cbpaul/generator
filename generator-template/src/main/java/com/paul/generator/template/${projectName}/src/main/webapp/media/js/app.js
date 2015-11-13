/**
 Core script to handle the entire layout and base functions
 **/
var App = function() {

	// IE mode
	var isRTL = false;
	var isIE8 = false;
	var isIE9 = false;
	var isIE10 = false;
 	var swf; 
 	var code;
	var sidebarWidth = 225;
	var sidebarCollapsedWidth = 35;

	var responsiveHandlers = [];

	// theme layout color set
	var layoutColorCodes = {
		'blue' : '#4b8df8',
		'red' : '#e02222',
		'green' : '#35aa47',
		'purple' : '#852b99',
		'grey' : '#555555',
		'light-grey' : '#fafafa',
		'yellow' : '#ffb848'
	};
	var handleInit = function() {

		if ($('body').css('direction') === 'rtl') {
			isRTL = true;
		}

		isIE8 = !! navigator.userAgent.match(/MSIE 8.0/);
		isIE9 = !! navigator.userAgent.match(/MSIE 9.0/);
		isIE10 = !! navigator.userAgent.match(/MSIE 10/);

		if (isIE10) {
			jQuery('html').addClass('ie10');
			// detect IE10 version
		}
	};
	var handleAjaxPageContent = function() {
		//分页条件查询
		jQuery(".page-content .page-content-body").on('click', ' .searchForm .search', function(e) {//条件查询
			var tableId = $(".searchForm").attr("fortableId");
			TableCommon.reloadFirstPage(tableId);
		});
		//批量删除
		jQuery(".page-content .page-content-body").on('click', ' .batch_delete', function(e) {//批量删除
			var postUrl = "";
			var tableId = $(this).attr("fortableId");
			var deleteAction = $(this).attr("action");
			var logicaldel = $(this).attr("logicaldel") || "0" ;
			var baseUrl = $("#baseUrl").val();
			var confirmMsg = $(this).attr("confirmMsg");
			postUrl = deleteAction || (baseUrl+"/delete");
			var id = TableCommon.getSelectedIDs(tableId);
			id = id.toString().replace(/,/g, "&id=");
			if(!id){
				TableCommon.error("请选择需要操作的数据！");
				return;
			}
			TableCommon.deleteConfirm(postUrl + '?hidden='+logicaldel+'&id=' + id, tableId,confirmMsg);
		});
		jQuery(".page-content .page-content-body").on('click',' .deleteTr',function(){
			var action = $(this).attr("action");
			var $this = $(this);
			var confirm = $.scojs_confirm({
			  content: '<p><span class="icon icon-warning-sign"></span>确认是否删除选择数据?</p>',
			  action: function(){
				  $.ajax({
						"type" : "GET",
						"contentType" : "application/json",
						"url" : action,
						"dataType" : "json",
						"success" : function(res) {
							if(resp.code==-1){
								location.href="";
							}
							if(res.code == 200){
			                	TableCommon.success(res.info);//提示操作成功
			                	$this.parent("td").parent("tr").remove();
				  			}else{
				  				TableCommon.error(res.info);//提示操作失败
				  			}
			  				confirm.close();//关闭确认框
						}
					});
				  }
			});
			confirm.show();
		});
		//搜索全部
		jQuery(".page-content .page-content-body").on('click', ' .searchForm .clearnSearch', function(e) {//搜索全部
			var tableId = $(".searchForm").attr("fortableId");
			$(':input', '.searchForm').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');
			//清空表单内容
			TableCommon.reloadFirstPage(tableId);
		});
		//删除指定数据
		jQuery(".page-content .page-content-body").on('click', ' .deleteItem', function(e) {//删除指定数据
			var postUrl = "";
			var tableId = $(this).attr("fortableId");
			var deleteAction = $(this).attr("action");
			var logicaldel = $(this).attr("logicaldel") || "0" ;
			var baseUrl = $("#baseUrl").val();
			var confirmMsg = $(this).attr("confirmMsg");
			postUrl = deleteAction || (baseUrl+"/delete");
			var id = $(this).attr("delId");
			if($(this).parents("tr").find(".checkboxes").attr("checked")){
				var selectVal=$(this).parents("tr").find(".checkboxes").val();
				if(selectVal){
					var selectedIds=TableCommon.getSelectedIDs();
					if(selectedIds.indexOf(selectVal)!=-1){
						selectedIds.splice(selectedIds.indexOf(selectVal),1);
					}
				}
			}
			TableCommon.deleteConfirm(postUrl + '?hidden='+logicaldel+'&id=' + id, tableId,confirmMsg);
		});
		$(".page-content .page-content-body").on("click"," .emptyModal",function(){
			$("#emptyModal .modal-title").text($(this).attr("title"));
			if($(this).attr("reload")!=""){
				$("#emptyModal").attr("reload",$(this).attr("reload"));
			}
			$.get($(this).attr("hrefUrl"), {}, function(res) {
				$("#emptyModal .modal-content").empty().html(res);
				$("#emptyModal").modal({
					modalOverflow:true,
					height:"450px",
					width:"700px"
				});
			});
		});
		//批量修改帖子类型
		jQuery(".page-content .page-content-body").on('click', ' .batch_updateMsgType', function(e) {//批量修改帖子类型
			var postUrl = "";
			var msgTypeId = $(this).attr("msgTypeId");
			var deleteAction = $(this).attr("action");
			var forwadAction = $(this).attr("forwadAction");
			var tableId = $(this).attr("fortableId");
			var baseUrl = $("#baseUrl").val();
			postUrl = deleteAction;
			var id = TableCommon.getSelectedIDs(tableId);
			id = id.toString().replace(/,/g, "&id=");
			if(postUrl.indexOf("?")!=-1){
				postUrl = postUrl+'&id=' + id+'&msgTypeId='+msgTypeId;
			}else{
				postUrl = postUrl+'?id=' + id+'&msgTypeId='+msgTypeId;
			}
			TableCommon.saveComfirm(postUrl,forwadAction,null,"get");
		});
			//批量修改帖子类型
		jQuery(".page-content .page-content-body").on('click', ' .itemUpdate', function(e) {//批量修改帖子类型
			var action = $(this).attr("action");
			var forwadAction = $(this).attr("forwadAction");
			var tableId = $(this).attr("fortableId");
			var confirmMsg = $(this).attr("confirm-msg");
			var forwadAction = ($(this).attr("forwadAction"))||($("#baseUrl").val()+"/list");
			TableCommon.saveComfirmLoadFirstPage(action,"get",confirmMsg,tableId);
		});
		//修改推送状态
		jQuery(".page-content .page-content-body").on('click', ' .pushStatusUpdate', function(e) {//修改推送状态
			var action = $(this).attr("action");
			var tableId = $(this).attr("fortableId");
			TableCommon.saveObj(action,"get",tableId);
		});
		//保存推送设置
		jQuery(".page-content .page-content-body").on('click', ' .batch_updatePushType', function(e) {
			    var uid = $(this).attr("uid");
		     	var action = $(this).attr("action");
				var rds = $(".open_sataus");
				var ckRds="";
				var k=0;
				for(var i=0;i<rds.length;i++){
					var rd = $(rds[i]).attr("name");
					var rdVal =$('input:radio[name="'+rd+'"]:checked').val();
					ckRds+=rd+','+rdVal+';'; 
				}
			   ckRds=ckRds.substr(0,ckRds.length-1);
			   if(uid && ckRds.length>0){
				   $.ajax({
					   "type" : "GET",
						"contentType" : "application/json",
						"url" : action+"?uid="+uid+"&data="+ckRds,
						"dataType" : "json",
						"success" : function(res) {
							if(resp.code==-1){
								location.href="";
							}
							if(res.code == 200){
                       		TableCommon.success(res.info);//提示操作成功
				  			}else{
				  			TableCommon.error(res.info);//提示操作失败
				  			}
						},
						"error":function(){
							TableCommon.error(res.info);//提示操作失败
						}
				   });
				   
			   }
		});
		//删除图片
		jQuery(".page-content .page-content-body").on('click', ' .delImgItem', function(e) {
			var deleteUrl = $(this).attr("action")||($("#baseUrl").val()+"/imgDel");
			var id=$(this).attr("id");
				var node = $(this);
				if(id){
			  		$.ajax({
						"type" : "GET",
						"contentType" : "application/json",
						"url" : deleteUrl+"?imgId="+id,
						"dataType" : "json",
						"success" : function(res) {
							if(resp.code==-1){
								location.href="";
							}
							if(res.code == 200){
                        		TableCommon.success(res.info);//提示操作成功
                        		node.parents(".template-download").remove();
				  			}else{
				  				TableCommon.error(res.info);//提示操作失败
				  			}
						},
						"error":function(){
							TableCommon.error(res.info);//提示操作失败
						}
					});
				}
		});
		//排序
		jQuery(".page-content .page-content-body").on('click', ' .sortItem', function(e) {//排序
			var postUrl = "";
			var tableId = $(this).attr("fortableId");
			var sortAction = $(this).attr("action");
			var baseUrl = $("#baseUrl").val();
			postUrl = sortAction || (baseUrl+"/sort");
			var id = $(this).attr("sortId");
			var val = $(this).attr("sortVal");
			var sortType = $(this).attr("sortType");
			var page = TableCommon.getPageParam();
			var displayLength = page._iDisplayLength || "0";
			var displayStart = page._iDisplayStart || "0";
			TableCommon.saveObj(postUrl + '?id=' + id+'&val='+val+"&sortType="+sortType+"&displayLength="+displayLength+"&displayStart="+displayStart,"GET", tableId);
		});
		jQuery('.page-content .page-content-body').on('click',' a.ajaxDef' , function(e) {
				e.preventDefault();
				App.scrollTop();
				var url = $(this).attr("href");
				var type = $(this).attr("type");
				var pageContent = $('.page-content');
				var pageContentBody = $('.page-content .page-content-body');
				if($(this).parents(".tab-pane").length>0 &&$(this).attr("reloadTab")!=0){
					pageContentBody = $(this).parents(".tab-pane");
					pageContent = $(this).parents(".tab-pane");
				}
				App.blockUI(pageContent, false);
				var checkForm = $(this).attr("checkForm");
				var b = false;
				if(checkForm){
					if(!($("#"+checkForm).valid())){
						b = true;
					}
					url += "?"+$("#"+checkForm).serialize()
				}
				if(b){
					App.unblockUI(pageContent);
					return;
				}
				if ("get" == type) {
					$.get(url, {}, function(res) {
						if(res=='{"code":"-1","info":"sessionout"}'){
							location.href="";
							return;
						}
						App.unblockUI(pageContent);
						pageContentBody.html(res);
						App.fixContentHeight();
						// fix content height
						App.initUniform();
						// initialize uniform elements
						App.initAjaxDef();
						App.navigationHtmlHandle();
						App.handleDatepiker();
					});
				} else {
					$.post(url, {}, function(res) {
						if(res=='{"code":"-1","info":"sessionout"}'){
							location.href="";
							return;
						}
						App.unblockUI(pageContent);
						pageContentBody.html(res);
						App.fixContentHeight();
						// fix content height
						App.initUniform();
						// initialize uniform elements
						App.initAjaxDef();
						App.navigationHtmlHandle();
						App.handleDatepiker();
					});
				}
			});
		//保存编辑数据
		jQuery(".page-content .page-content-body").on('click', ' .saveData', function(e) {
			var action = $(this).attr("action");
			var forwadAction = $(this).attr("forwadAction");
			var formId = $(this).attr("formId");
			var confirmMsg=$(this).attr("confirmMsg");
			var loadNode=null;//指定加载的dom节点
			if($(this).parents(".tab-pane").length>0&&$(this).attr("reloadTab")!=0){//判断当前点击事件父节点是否是在tab里
				loadNode = $(this).parents(".tab-pane");//内容加载到tab里
			}
			//校验表单数据
			if($("#"+formId).valid()){
				var saveUrl = "";
				var forwadUrl = "";
				var type = "/add";
				var id = $("#"+formId+" input[name='id']");
				if(id && $(id).val() ){
					type = "/edit";
				}
				var baseUrl = $("#baseUrl").val();
				saveUrl = action || (baseUrl+type);
				forwadUrl = forwadAction || (baseUrl+"/list");
				var dataParam = $("#"+formId).serialize();
				if(forwadUrl=="#"){
					forwadUrl=null;
				}
				TableCommon.saveComfirm(saveUrl+'?rand='+ Math.random() + '&' + dataParam,
								forwadUrl,loadNode,null,confirmMsg);
			}
		});
		jQuery(".page-content .page-content-body").on('click', ' table .checkboxes', function(e) {
			var id = parseInt($(this).val());
			if($(this).attr("checked")){
				TableCommon.getSelectedIDs().push(id);
			}else{
				var selectedIds=TableCommon.getSelectedIDs();
				var index;
				if(selectedIds){
				    index=selectedIds.indexOf(id);
				    if(index !=-1){
				        selectedIds.splice(index,1);
				    }
				}
			}
			
			var tableId=$(this).parents("table").attr("id");
			var set = $($('#'+tableId+' .group-checkable').attr("data-set")).not('input:checked');
			if($($('#'+tableId+' .group-checkable').attr("data-set")).lengt=0||set.length>0){
				$('#'+tableId+' .group-checkable').attr("checked",false);
			}else{
				$('#'+tableId+' .group-checkable').attr("checked",true);
			}
			jQuery.uniform.update('#'+tableId+' .group-checkable');
			if(typeof(selectCallBack)!='undefined'&&selectCallBack){
				selectCallBack();
			}
		});
		jQuery(".page-content .page-content-body").on('shown.bs.tab', ' a[data-toggle="tab"]',function (e) {
		  var target = $(e.target).attr("data-target"); // activated tab
		  var href = $(e.target).attr("href"); // activated tab
		  if ($(target)) {
		  	if(href && href.indexOf("#")==-1){
			    $.ajax({
			      type: "GET",
			      url: href,
			      error: function(data){
			        alert("There was a problem");
			      },
			      success: function(data){
			      	if(data=='{"code":"-1","info":"sessionout"}'){
							location.href="";
							return;
						}
			        $(target).html(data);
			      }
			  });
		  }
		 }
		});
		jQuery(".page-content .page-content-body").on('click', ' .upload', function(e) {//上传图片
			     $("#myModal").modal({
					modalOverflow:true,
					height:"450px",
					width:"650px"
				});
			     if(swf){
			    	$("#flashDiv").append('<div id="altContent"></div>');
			    	$("#swf").remove();
			    }
			   	var sizeArr=$(this).attr("imgSize");
			     if(sizeArr){
			       	sizeArr = sizeArr.replace(",","*");
			     }
			     var showImgDomId= $(this).attr("data-showImgId");
				 var newPathDomId = $(this).attr("data-hidenNewPathId");
				 var uploadUrl = $(this).attr("uploadUrl");
			     swfimageUpload("altContent",sizeArr,showImgDomId,newPathDomId,uploadUrl);
			});
	};
	var swfimageUpload = function(nodeId,avaterSize,showImgDomId,newPathDomId,uploadUrl){
		var size = avaterSize;
		var scale = 1;
		if(avaterSize){
			var sizeArr=avaterSize.split("*");
			var scaleWidth=1;
			if(sizeArr[0]-200>50){
				scaleWidth = parseInt((parseInt(sizeArr[0])+200)/200);
			}
			var scaleHeight=1;
			if(sizeArr[1]-200>50){
				scaleHeight = parseInt((parseInt(sizeArr[0])+200)/200);
			}
			if(scaleHeight>scaleWidth){
				scale = scaleHeight;
			}else{
				scale = scaleWidth;
			}
			avaterSize = parseInt(parseInt(sizeArr[0])/scale)+"*"+parseInt(parseInt(sizeArr[1])/scale);
		}else{
			avaterSize = "200*200";
		}
		if(!uploadUrl || uploadUrl==''){
			uploadUrl='upload/swfuploadImg';
		}
         swf = new fullAvatarEditor(nodeId,{
					    id: 'swf',
						upload_url: uploadUrl,
						src_upload:0,
						tab_visible:false,
						browse_box_width:400,
						browse_box_height:400,
						src_box_width:350,
						src_box_height:350,
						src_upload:2,
						button_visible:false,
						avatar_intro:"注意清晰度"+size,
						avatar_scale:scale,
						avatar_field_names:"image",
						avatar_sizes:avaterSize,
						avatar_sizes_desc:size+"像素",
						avatar_tools_visible:false
					},function (msg) {
						code = msg.code;
						switch(msg.code)
						{
							case 1 :break;
							case 2 :$("#swfcancel").text("取消选择");code=2;break;
							case 4:
							  alert("图片超出上传限制");
							 break;
							case 5 :if(msg.type == 0){
									if(msg.content.sourceUrl){
										var path = msg.content.sourceUrl;
										$("#"+showImgDomId).attr("src",path);
										$("#"+newPathDomId).val(path);
										$("#myModal").modal("hide");
										$("#swfcancel").text("关闭");
									}
								}
							break;
						}
					}
				);
				 $("#swfupload").unbind("click");
				$("#swfcancel").unbind("click");
				 $("#swfupload").click(function(){
	            	if(code<2){
	            		alert("请选择图片");
	            	}
	            	swf.call("upload");
	            });
	            $("#swfcancel").click(function(){
	            	if(code<2){
	            		$("#myModal").modal("hide");
	            	}else{
	            		swf.call("changePanel","upload");
	            		$("#swfcancel").text("关闭");
	            		code=1;
	            	}
	            });
					
          
	};
	var handleDesktopTabletContents = function() {
		// loops all page elements with "responsive" class and applies classes for tablet mode
		// For metornic  1280px or less set as tablet mode to display the content properly
		if ($(window).width() <= 1280 || $('body').hasClass('page-boxed')) {
			$(".responsive").each(function() {
				var forTablet = $(this).attr('data-tablet');
				var forDesktop = $(this).attr('data-desktop');
				if (forTablet) {
					$(this).removeClass(forDesktop);
					$(this).addClass(forTablet);
				}
			});
		};

		// loops all page elements with "responsive" class and applied classes for desktop mode
		// For metornic  higher 1280px set as desktop mode to display the content properly
		if ($(window).width() > 1280 && $('body').hasClass('page-boxed') === false) {
			$(".responsive").each(function() {
				var forTablet = $(this).attr('data-tablet');
				var forDesktop = $(this).attr('data-desktop');
				if (forTablet) {
					$(this).removeClass(forTablet);
					$(this).addClass(forDesktop);
				}
			});
		}
	};
	var handleSidebarState = function() {
		// remove sidebar toggler if window width smaller than 900(for table and phone mode)
		if ($(window).width() < 980) {
			$('body').removeClass("page-sidebar-closed");
		}
	};
	var runResponsiveHandlers = function() {
		// reinitialize other subscribed elements
		for (var i in responsiveHandlers) {
			var each = responsiveHandlers[i];
			each.call();
		}
	};
	
	var handleResponsive = function() {
		handleTooltips();
		handleSidebarState();
		handleDesktopTabletContents();
		handleSidebarAndContentHeight();
		handleChoosenSelect();
		handleFixedSidebar();
		runResponsiveHandlers();
	};
	var handleResponsiveOnInit = function() {
		handleSidebarState();
		handleDesktopTabletContents();
		handleSidebarAndContentHeight();
	};
	var handleResponsiveOnResize = function() {
		var resize;
		if (isIE8) {
			var currheight;
			$(window).resize(function() {
				if (currheight == document.documentElement.clientHeight) {
					return;
					//quite event since only body resized not window.
				}
				if (resize) {
					clearTimeout(resize);
				}
				resize = setTimeout(function() {
					handleResponsive();
				}, 50);
				// wait 50ms until window resize finishes.
				currheight = document.documentElement.clientHeight;
				// store last body client height
			});
		} else {
			$(window).resize(function() {
				if (resize) {
					clearTimeout(resize);
				}
				resize = setTimeout(function() {
					console.log('resize');
					handleResponsive();
				}, 50);
				// wait 50ms until window resize finishes.
			});
		}
	};
	//* BEGIN:CORE HANDLERS *//
	// this function handles responsive layout on screen size resize or mobile device rotate.

	var handleSidebarAndContentHeight = function() {
		var content = $('.page-content');
		var sidebar = $('.page-sidebar');
		var body = $('body');
		var height;

		if (body.hasClass("page-footer-fixed") === true && body.hasClass("page-sidebar-fixed") === false) {
			var available_height = $(window).height() - $('.footer').height();
			if (content.height() < available_height) {
				content.attr('style', 'min-height:' + available_height + 'px !important');
			}
		} else {
			if (body.hasClass('page-sidebar-fixed')) {
				height = _calculateFixedSidebarViewportHeight();
			} else {
				height = sidebar.height() + 20;
			}
			if (height >= content.height()) {
				content.attr('style', 'min-height:' + height + 'px !important');
			}
		}
	};
	var handleSidebarMenu = function() {
		jQuery('.page-sidebar').on('click', 'li > a', function(e) {
			if ($(this).next().hasClass('sub-menu') == false) {
				if ($('.btn-navbar').hasClass('collapsed') == false) {
					$('.btn-navbar').click();
				}
				return;
			}

			var parent = $(this).parent().parent();

			parent.children('li.open').children('a').children('.arrow').removeClass('open');
			parent.children('li.open').children('.sub-menu').slideUp(200);
			parent.children('li.open').removeClass('open');

			var sub = jQuery(this).next();
			if (sub.is(":visible")) {
				jQuery('.arrow', jQuery(this)).removeClass("open");
				jQuery(this).parent().removeClass("open");
				sub.slideUp(200, function() {
					handleSidebarAndContentHeight();
				});
			} else {
				jQuery('.arrow', jQuery(this)).addClass("open");
				jQuery(this).parent().addClass("open");
				sub.slideDown(200, function() {
					handleSidebarAndContentHeight();
				});
			}

			e.preventDefault();
		});

		// handle ajax links
		jQuery('.page-sidebar').on('click', ' li > a.ajaxify', function(e) {
			e.preventDefault();
			App.scrollTop();

			var url = $(this).attr("action");
			var menuContainer = jQuery('.page-sidebar ul');
			var pageContent = $('.page-content');
			var pageContentBody = $('.page-content .page-content-body');

			menuContainer.children('li.active').removeClass('active');
			menuContainer.children('arrow.open').removeClass('open');

			$(this).parents('li').each(function() {
				$(this).addClass('active');
				$(this).children('a > span.arrow').addClass('open');
			});
			$(this).parents('li').addClass('active');

			App.blockUI(pageContent, false);

			$.get(url, {}, function(res) {
				if(res=='{"code":"-1","info":"sessionout"}'){
					location.href="";
					return;
				}
				App.unblockUI(pageContent);
				pageContentBody.html(res);
				App.fixContentHeight();
				// fix content height
				App.initUniform();
				
				// initialize uniform elements
				App.initAjaxDef();
				App.navigationHtmlHandle();
				App.handleDatepiker();//日期处理
			});
		});

	};
	var _calculateFixedSidebarViewportHeight = function() {
		var sidebarHeight = $(window).height() - $('.header').height() + 1;
		if ($('body').hasClass("page-footer-fixed")) {
			sidebarHeight = sidebarHeight - $('.footer').height();
		}

		return sidebarHeight;
	};
	var handleFixedSidebar = function() {
		var menu = $('.page-sidebar-menu');

		if (menu.parent('.slimScrollDiv').size() === 1) {// destroy existing instance before updating the height
			menu.slimScroll({
				destroy : true
			});
			menu.removeAttr('style');
			$('.page-sidebar').removeAttr('style');
		}

		if ($('.page-sidebar-fixed').size() === 0) {
			handleSidebarAndContentHeight();
			return;
		}

		if ($(window).width() >= 980) {
			var sidebarHeight = _calculateFixedSidebarViewportHeight();

			menu.slimScroll({
				size : '7px',
				color : '#a1b2bd',
				opacity : .3,
				position : isRTL ? 'left' : ($('.page-sidebar-on-right').size() === 1 ? 'left' : 'right'),
				height : sidebarHeight,
				allowPageScroll : false,
				disableFadeOut : false
			});
			handleSidebarAndContentHeight();
		}
	};
	var handleFixedSidebarHoverable = function() {
		if ($('body').hasClass('page-sidebar-fixed') === false) {
			return;
		}

		$('.page-sidebar').off('mouseenter').on('mouseenter', function() {
			var body = $('body');

			if ((body.hasClass('page-sidebar-closed') === false || body.hasClass('page-sidebar-fixed') === false) || $(this).hasClass('page-sidebar-hovering')) {
				return;
			}

			body.removeClass('page-sidebar-closed').addClass('page-sidebar-hover-on');
			$(this).addClass('page-sidebar-hovering');
			$(this).animate({
				width : sidebarWidth
			}, 400, '', function() {
				$(this).removeClass('page-sidebar-hovering');
			});
		});

		$('.page-sidebar').off('mouseleave').on('mouseleave', function() {
			var body = $('body');

			if ((body.hasClass('page-sidebar-hover-on') === false || body.hasClass('page-sidebar-fixed') === false) || $(this).hasClass('page-sidebar-hovering')) {
				return;
			}

			$(this).addClass('page-sidebar-hovering');
			$(this).animate({
				width : sidebarCollapsedWidth
			}, 400, '', function() {
				$('body').addClass('page-sidebar-closed').removeClass('page-sidebar-hover-on');
				$(this).removeClass('page-sidebar-hovering');
			});
		});
	};
	var handleSidebarToggler = function() {
		// handle sidebar show/hide
		$('.page-sidebar').on('click', '.sidebar-toggler', function(e) {
			var body = $('body');
			var sidebar = $('.page-sidebar');

			if ((body.hasClass("page-sidebar-hover-on") && body.hasClass('page-sidebar-fixed')) || sidebar.hasClass('page-sidebar-hovering')) {
				body.removeClass('page-sidebar-hover-on');
				sidebar.css('width', '').hide().show();
				e.stopPropagation();
				runResponsiveHandlers();
				return;
			}

			$(".sidebar-search", sidebar).removeClass("open");

			if (body.hasClass("page-sidebar-closed")) {
				body.removeClass("page-sidebar-closed");
				if (body.hasClass('page-sidebar-fixed')) {
					sidebar.css('width', '');
				}
			} else {
				body.addClass("page-sidebar-closed");
			}
			runResponsiveHandlers();
		});

		// handle the search bar close
		$('.page-sidebar').on('click', '.sidebar-search .remove', function(e) {
			e.preventDefault();
			$('.sidebar-search').removeClass("open");
		});

		// handle the search query submit on enter press
		$('.page-sidebar').on('keypress', '.sidebar-search input', function(e) {
			if (e.which == 13) {
				window.location.href = "extra_search.html";
				return false;
				//<---- Add this line
			}
		});

		// handle the search submit
		$('.sidebar-search .submit').on('click', function(e) {
			e.preventDefault();

			if ($('body').hasClass("page-sidebar-closed")) {
				if ($('.sidebar-search').hasClass('open') == false) {
					if ($('.page-sidebar-fixed').size() === 1) {
						$('.page-sidebar .sidebar-toggler').click();
						//trigger sidebar toggle button
					}
					$('.sidebar-search').addClass("open");
				} else {
					window.location.href = "extra_search.html";
				}
			} else {
				window.location.href = "extra_search.html";
			}
		});
	};
	var handleHorizontalMenu = function() {
		//handle hor menu search form toggler click
		$('.header').on('click', '.hor-menu .hor-menu-search-form-toggler', function(e) {
			if ($(this).hasClass('hide')) {
				$(this).removeClass('hide');
				$('.header .hor-menu .search-form').hide();
			} else {
				$(this).addClass('hide');
				$('.header .hor-menu .search-form').show();
			}
			e.preventDefault();
		});

		//handle hor menu search button click
		$('.header').on('click', '.hor-menu .search-form .btn', function(e) {
			window.location.href = "extra_search.html";
			e.preventDefault();
		});

		//handle hor menu search form on enter press
		$('.header').on('keypress', '.hor-menu .search-form input', function(e) {
			if (e.which == 13) {
				window.location.href = "extra_search.html";
				return false;
			}
		});
	};
	var handleGoTop = function() {
		/* set variables locally for increased performance */
		jQuery('.footer').on('click', '.go-top', function(e) {
			App.scrollTo();
			e.preventDefault();
		});
	};
	var handlePortletTools = function() {
		jQuery('body').on('click', '.portlet .tools a.remove', function(e) {
			e.preventDefault();
			var removable = jQuery(this).parents(".portlet");
			if (removable.next().hasClass('portlet') || removable.prev().hasClass('portlet')) {
				jQuery(this).parents(".portlet").remove();
			} else {
				jQuery(this).parents(".portlet").parent().remove();
			}
		});

		jQuery('body').on('click', '.portlet .tools a.reload', function(e) {
			e.preventDefault();
			var el = jQuery(this).parents(".portlet");
			App.blockUI(el);
			window.setTimeout(function() {
				App.unblockUI(el);
			}, 1000);
		});

		jQuery('body').on('click', '.portlet .tools .collapse, .portlet .tools .expand', function(e) {
			e.preventDefault();
			var el = jQuery(this).closest(".portlet").children(".portlet-body");
			if (jQuery(this).hasClass("collapse")) {
				jQuery(this).removeClass("collapse").addClass("expand");
				el.slideUp(200);
			} else {
				jQuery(this).removeClass("expand").addClass("collapse");
				el.slideDown(200);
			}
		});
	};
	var handleUniform = function() {
		if (!jQuery().uniform) {
			return;
		}
		var test = $("input[type=checkbox]:not(.toggle), input[type=radio]:not(.toggle, .star)");
		if (test.size() > 0) {
			test.each(function() {
				if ($(this).parents(".checker").size() == 0) {
					$(this).show();
					$(this).uniform();
				}
			});
		}
	};
	var handleAccordions = function() {
		$(".accordion").collapse().height('auto');

		var lastClicked;

		//add scrollable class name if you need scrollable panes
		jQuery('body').on('click', '.accordion.scrollable .accordion-toggle', function() {
			lastClicked = jQuery(this);
		});
		//move to faq section

		jQuery('body').on('shown', '.accordion.scrollable', function() {
			jQuery('html,body').animate({
				scrollTop : lastClicked.offset().top - 150
			}, 'slow');
		});
	};
	var handleTabs = function() {

		// function to fix left/right tab contents
		var fixTabHeight = function(tab) {
			$(tab).each(function() {
				var content = $($($(this).attr("href")));
				var tab = $(this).parent().parent();
				if (tab.height() > content.height()) {
					content.css('min-height', tab.height());
				}
			});
		}
		// fix tab content on tab shown
		$('body').on('shown', '.nav.nav-tabs.tabs-left a[data-toggle="tab"], .nav.nav-tabs.tabs-right a[data-toggle="tab"]', function() {
			fixTabHeight($(this));
		});

		$('body').on('shown', '.nav.nav-tabs', function() {
			handleSidebarAndContentHeight();
		});

		//fix tab contents for left/right tabs
		fixTabHeight('.nav.nav-tabs.tabs-left > li.active > a[data-toggle="tab"], .nav.nav-tabs.tabs-right > li.active > a[data-toggle="tab"]');

		//activate tab if tab id provided in the URL
		if (location.hash) {
			var tabid = location.hash.substr(1);
			$('a[href="#' + tabid + '"]').click();
		}
	};
	var handleScrollers = function() {
		$('.scroller').each(function() {
			$(this).slimScroll({
				size : '7px',
				color : '#a1b2bd',
				position : isRTL ? 'left' : 'right',
				height : $(this).attr("data-height"),
				alwaysVisible : ($(this).attr("data-always-visible") == "1" ? true : false),
				railVisible : ($(this).attr("data-rail-visible") == "1" ? true : false),
				disableFadeOut : true
			});
		});
	};
	var handleTooltips = function() {
		if (App.isTouchDevice()) {// if touch device, some tooltips can be skipped in order to not conflict with click events
			jQuery('.tooltips:not(.no-tooltip-on-touch-device)').tooltip();
		} else {
			jQuery('.tooltips').tooltip();
		}
	};
	var handleDropdowns = function() {
		$('body').on('click', '.dropdown-menu.hold-on-click', function(e) {
			e.stopPropagation();
		})
	};
	var handlePopovers = function() {
		jQuery('.popovers').popover();
	};
	var handleChoosenSelect = function() {
		if (!jQuery().chosen) {
			return;
		}

		$(".chosen").each(function() {
			$(this).chosen({
				allow_single_deselect : $(this).attr("data-with-diselect") === "1" ? true : false
			});
		});
	};
	var handleFancybox = function() {
		if (!jQuery.fancybox) {
			return;
		}

		if (jQuery(".fancybox-button").size() > 0) {
			jQuery(".fancybox-button").fancybox({
				groupAttr : 'data-rel',
				prevEffect : 'none',
				nextEffect : 'none',
				closeBtn : true,
				helpers : {
					title : {
						type : 'inside'
					}
				}
			});
		}
	};
	var handleTheme = function() {

		var panel = $('.color-panel');

		if ($('body').hasClass('page-boxed') == false) {
			$('.layout-option', panel).val("fluid");
		}

		$('.sidebar-option', panel).val("default");
		$('.header-option', panel).val("fixed");
		$('.footer-option', panel).val("default");

		//handle theme layout
		var resetLayout = function() {
			$("body").removeClass("page-boxed").removeClass("page-footer-fixed").removeClass("page-sidebar-fixed").removeClass("page-header-fixed");

			$('.header > .navbar-inner > .container').removeClass("container").addClass("container-fluid");

			if ($('.page-container').parent(".container").size() === 1) {
				$('.page-container').insertAfter('.header');
			}

			if ($('.footer > .container').size() === 1) {
				$('.footer').html($('.footer > .container').html());
			} else if ($('.footer').parent(".container").size() === 1) {
				$('.footer').insertAfter('.page-container');
			}

			$('body > .container').remove();
		}
		var lastSelectedLayout = '';

		var setLayout = function() {

			var layoutOption = $('.layout-option', panel).val();
			var sidebarOption = $('.sidebar-option', panel).val();
			var headerOption = $('.header-option', panel).val();
			var footerOption = $('.footer-option', panel).val();

			if (sidebarOption == "fixed" && headerOption == "default") {
				alert('Default Header with Fixed Sidebar option is not supported. Proceed with Default Header with Default Sidebar.');
				$('.sidebar-option', panel).val("default");
				sidebarOption = 'default';
			}

			resetLayout();
			// reset layout to default state

			if (layoutOption === "boxed") {
				$("body").addClass("page-boxed");

				// set header
				$('.header > .navbar-inner > .container-fluid').removeClass("container-fluid").addClass("container");
				var cont = $('.header').after('<div class="container"></div>');

				// set content
				$('.page-container').appendTo('body > .container');

				// set footer
				if (footerOption === 'fixed' || sidebarOption === 'default') {
					$('.footer').html('<div class="container">' + $('.footer').html() + '</div>');
				} else {
					$('.footer').appendTo('body > .container');
				}
			}

			if (lastSelectedLayout != layoutOption) {
				//layout changed, run responsive handler:
				runResponsiveHandlers();
			}
			lastSelectedLayout = layoutOption;

			//header
			if (headerOption === 'fixed') {
				$("body").addClass("page-header-fixed");
				$(".header").removeClass("navbar-static-top").addClass("navbar-fixed-top");
			} else {
				$("body").removeClass("page-header-fixed");
				$(".header").removeClass("navbar-fixed-top").addClass("navbar-static-top");
			}

			//sidebar
			if (sidebarOption === 'fixed') {
				$("body").addClass("page-sidebar-fixed");
			} else {
				$("body").removeClass("page-sidebar-fixed");
			}

			//footer
			if (footerOption === 'fixed') {
				$("body").addClass("page-footer-fixed");
			} else {
				$("body").removeClass("page-footer-fixed");
			}

			handleSidebarAndContentHeight();
			// fix content height
			handleFixedSidebar();
			// reinitialize fixed sidebar
			handleFixedSidebarHoverable();
			// reinitialize fixed sidebar hover effect
		}
		// handle theme colors
		var setColor = function(color) {
			$('#style_color').attr("href", "assets/css/themes/" + color + ".css");
			$.cookie('style_color', color);
		}

		$('.icon-color', panel).click(function() {
			$('.color-mode').show();
			$('.icon-color-close').show();
		});

		$('.icon-color-close', panel).click(function() {
			$('.color-mode').hide();
			$('.icon-color-close').hide();
		});

		$('li', panel).click(function() {
			var color = $(this).attr("data-style");
			setColor(color);
			$('.inline li', panel).removeClass("current");
			$(this).addClass("current");
		});

		$('.layout-option, .header-option, .sidebar-option, .footer-option', panel).change(setLayout);
	};
	var handleFixInputPlaceholderForIE = function() {
		//fix html5 placeholder attribute for ie7 & ie8
		if (isIE8 || isIE9) {// ie7&ie8
			// this is html5 placeholder fix for inputs, inputs with placeholder-no-fix class will be skipped(e.g: we need this for password fields)
			jQuery('input[placeholder]:not(.placeholder-no-fix), textarea[placeholder]:not(.placeholder-no-fix)').each(function() {

				var input = jQuery(this);

				if (input.val() == '' && input.attr("placeholder") != '') {
					input.addClass("placeholder").val(input.attr('placeholder'));
				}

				input.focus(function() {
					if (input.val() == input.attr('placeholder')) {
						input.val('');
					}
				});

				input.blur(function() {
					if (input.val() == '' || input.val() == input.attr('placeholder')) {
						input.val(input.attr('placeholder'));
					}
				});
			});
		}
	};

	//* END:CORE HANDLERS *//

	return {

		//main function to initiate template pages
		init : function() {

			//IMPORTANT!!!: Do not modify the core handlers call order.

			//core handlers
			handleInit();
			handleResponsiveOnResize();
			// set and handle responsive
			handleUniform();
			handleScrollers();
			// handles slim scrolling contents
			handleResponsiveOnInit();
			// handler responsive elements on page load

			//layout handlers
			handleFixedSidebar();
			// handles fixed sidebar menu
			handleFixedSidebarHoverable();
			// handles fixed sidebar on hover effect
			handleSidebarMenu();
			// handles main menu
			handleHorizontalMenu();
			// handles horizontal menu
			handleSidebarToggler();
			// handles sidebar hide/show
			handleFixInputPlaceholderForIE();
			// fixes/enables html5 placeholder attribute for IE9, IE8
			handleGoTop();
			//handles scroll to top functionality in the footer
			handleTheme();
			// handles style customer tool

			//ui component handlers
			handlePortletTools();
			// handles portlet action bar functionality(refresh, configure, toggle, remove)
			handleDropdowns();
			// handle dropdowns
			handleTabs();
			// handle tabs
			handleTooltips();
			// handle bootstrap tooltips
			handlePopovers();
			// handles bootstrap popovers
			handleAccordions();
			//handles accordions
			handleChoosenSelect();
			// handles bootstrap chosen dropdowns
			App.addResponsiveHandler(handleChoosenSelect);
			// reinitiate chosen dropdown on main content resize. disable this line if you don't really use chosen dropdowns.
			handleAjaxPageContent();
		},

		fixContentHeight : function() {
			handleSidebarAndContentHeight();
		},

		addResponsiveHandler : function(func) {
			responsiveHandlers.push(func);
		},

		// useful function to make equal height for contacts stand side by side
		setEqualHeight : function(els) {
			var tallestEl = 0;
			els = jQuery(els);
			els.each(function() {
				var currentHeight = $(this).height();
				if (currentHeight > tallestEl) {
					tallestColumn = currentHeight;
				}
			});
			els.height(tallestEl);
		},

		// wrapper function to scroll to an element
		scrollTo : function(el, offeset) {
			pos = el ? el.offset().top : 0;
			jQuery('html,body').animate({
				scrollTop : pos + ( offeset ? offeset : 0)
			}, 'slow');
		},

		scrollTop : function() {
			App.scrollTo();
		},

		// wrapper function to  block element(indicate loading)
		blockUI : function(el, centerY) {
			var el = jQuery(el);
			el.block({
				message : '<img src="./media/image/select2-spinner.gif" align="">',
				centerY : centerY != undefined ? centerY : true,
				css : {
					top : '10%',
					border : 'none',
					padding : '2px',
					backgroundColor : 'none'
				},
				overlayCSS : {
					backgroundColor : '#000',
					opacity : 0.05,
					cursor : 'wait'
				}
			});
		},

		// wrapper function to  un-block element(finish loading)
		unblockUI : function(el) {
			jQuery(el).unblock({
				onUnblock : function() {
					jQuery(el).removeAttr("style");
				}
			});
		},

		// initializes uniform elements
		initUniform : function(els) {

			if (els) {
				jQuery(els).each(function() {
					if ($(this).parents(".checker").size() == 0) {
						$(this).show();
						$(this).uniform();
					}
				});
			} else {
				handleUniform();
			}

		},

		// initializes choosen dropdowns
		initChosenSelect : function(els) {
			$(els).chosen({
				allow_single_deselect : true
			});
		},

		initFancybox : function() {
			handleFancybox();
		},

		getActualVal : function(el) {
			var el = jQuery(el);
			if (el.val() === el.attr("placeholder")) {
				return "";
			}

			return el.val();
		},

		getURLParameter : function(paramName) {
			var searchString = window.location.search.substring(1), i, val, params = searchString.split("&");

			for ( i = 0; i < params.length; i++) {
				val = params[i].split("=");
				if (val[0] == paramName) {
					return unescape(val[1]);
				}
			}
			return null;
		},

		// check for device touch support
		isTouchDevice : function() {
			try {
				document.createEvent("TouchEvent");
				return true;
			} catch (e) {
				return false;
			}
		},

		isIE8 : function() {
			return isIE8;
		},

		isRTL : function() {
			return isRTL;
		},

		getLayoutColorCode : function(name) {
			if (layoutColorCodes[name]) {
				return layoutColorCodes[name];
			} else {
				return '';
			}
		},
		initAjaxDef : function() {
			//初始化FORM表单验证
			var $p = $('.page-content .page-content-body' || document);
			$("form.required-validate", $p).each(function(){
				var $form = $(this);
				$form.validate({
	                errorElement: 'span', //default input error message container
	                errorClass: 'help-inline', // default input error message class
	                focusInvalid: false, // do not focus the last invalid input
	                ignore: "",
	                highlight: function (element) { // hightlight error inputs
	                    $(element)
	                        .closest('.help-inline').removeClass('ok'); // display OK icon
	                    $(element)
	                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
	                },
	                unhighlight: function (element) { // revert the change dony by hightlight
	                    $(element)
	                        .closest('.control-group').removeClass('error'); // set error class to the control group
	                },
	                success: function (label) {
	                    label
	                        .addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
	                    .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
	                }
	            });
			});
			
			//jQuery('.page-content .page-content-body a.ajaxDef').unbind("click");
			
		},
		
		forwardAjax : function(url, type,loadNode) {
			App.scrollTop();
			var pageContent = $('.page-content');
			var pageContentBody = $('.page-content .page-content-body');
			if(loadNode){
				pageContent = loadNode;
				pageContentBody=loadNode;
			}
			
			App.blockUI(pageContent, false);
			if ("get" == type) {
				$.get(url, {}, function(res) {
					
					if(res=='{"code":"-1","info":"sessionout"}'){
							location.href="";
							return;
						}
					App.unblockUI(pageContent);
					pageContentBody.html(res);
					App.fixContentHeight();
					// fix content height
					App.initUniform();
					// initialize uniform elements
					App.initAjaxDef();
					App.navigationHtmlHandle();
					App.handleDatepiker();
				});
			} else {
				$.post(url, {}, function(res) {
					if(res=='{"code":"-1","info":"sessionout"}'){
							location.href="";
							return;
						}
					App.unblockUI(pageContent);
					pageContentBody.html(res);
					App.fixContentHeight();
					// fix content height
					App.initUniform();
					// initialize uniform elements
					App.initAjaxDef();
					App.navigationHtmlHandle();
					App.handleDatepiker();
				});
			}
		},
			//页面导航
		 navigationHtmlHandle:function(){
		 	var navNode=$(".nav-collapse ul>li.active");
		 	$(".breadcrumb").empty();
		 	var depth=navNode.length;
		 	navNode.each(function(index){
		 		var html="";
		 		var aNode=$(this).children('a');
	 			var module="";
	 			if(index==0&&$(this).find(".title").length==1){
	 				module=aNode.children('.title').text();
	 			}else{
	 				module = aNode.text();
	 			}
		 		if(index+1<depth){
		 			
		 			html='<li>'+aNode.children('i').get(0).outerHTML+'<a> '+module+'</a><i class="icon-angle-right"></i></li>';
		 		}else{
		 			html='<li>'+aNode.children('i').get(0).outerHTML+'<a> '+module+'</li>';
		 		}
		 		$("ul.breadcrumb").append(html);
		 	});
		 	
		 },
		 handleDatepiker:function(){
		 	$('.date-picker').datepicker({
                rtl : App.isRTL(),
                language :'zh',
                format :'yyyy-mm-dd',
                clearBtn:true
            });
		}
	};

}(); 