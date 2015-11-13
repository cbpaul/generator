var TableCommon = function() {
	var valArr;
	var dataTable;
	return {
		/**
		 * 初始化dataTable
		 * @param tableid datatable的标识ID
		 * @param ajaxurl 请求的URL
		 * @param aoColumnDefs 默认通用列
		 * @param aoColumns 定义列
		 * @param bCheckbox 是否需要多选，如果需要填写true，且需要在表头和列数据中定义复选框
		 * @param userData 用户的请求数据对象，JSON对象
		 * @returns
		 */
		init : function(tableid, ajaxurl, aoColumnDefs, aoColumns, bCheckbox,
				userData) {
			valArr= new Array();
			if($("#initSelected").val() && eval($("#initSelected").val()).length>0){
				TableCommon.initSelectedIds(eval($("#initSelected").val()));
			}
			dataTable=$('#' + tableid).dataTable({
				"bPaginate" : true,// 开关，是否显示分页器
				"bInfo" : true, // 开关，是否显示表格的一些信息
				"aLengthMenu" : [ 
				        [ 10, 20, 30 ],
						[ 10, 20, 30 ] // change per page// values here
				],
				"bLengthChange" : true, // 开关，是否显示每页大小的下拉框
				"iDisplayLength" : 10,// 默认查询10条数据
				"bFilter" : false,// 开关，是否启用客户端过滤器
				"bSort" : false,// 开关，是否启用各列具有按列排序的功能
				"bProcessing" : false,// 开发，是否展示加载提示信息
				"sDom" : "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
				"sPaginationType" : "bootstrap",
				"oLanguage" : {
					"sProcessing" : "正在加载中......",
					"sLengthMenu" : "每页显示 _MENU_ 条记录",
					"sZeroRecords" : "对不起，查询不到相关数据！",
					"sEmptyTable" : "表中无数据存在！",
					"sInfo" : "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
					"sInfoEmpty":"当前显示 0 到 0 条，共 0 条记录",
					"sInfoFiltered" : "数据表中共为 _MAX_ 条记录",
					"sSearch" : "搜索",
					"oPaginate" : {
						"sFirst" : "首页",
						"sPrevious" : "上一页",
						"sNext" : "下一页",
						"sLast" : "末页"
					}
				}, // 多语言配置
				"aoColumnDefs" : aoColumnDefs,
				"aoColumns" : aoColumns,
				"bRetrieve":true,
				"bServerSide" : true,// 异步请求必须设置
				"bStateSave":false,//开关，是否打开客户端状态记录功能。这个数据是记录在cookies中的，打开了这个记录后，即使刷新一次页面，或重新打开浏览器，之前的状态都是保存下来的
				"sAjaxSource" : ajaxurl + "?rand="+ Math.random(),// 异步请求的地址，一般是指servlet或者action。
				"fnServerData" : function(sSource, aoData,fnCallback) {
					var searchParam=$(".searchForm[fortableId='"+tableid+"']").serialize();
					$.ajax({
						"type" : "POST",
						"contentType" : "application/json",
						"url" : sSource+"&aoData="+JSON.stringify(aoData)+"&"+searchParam,
						"dataType" : "json",
						//"data" : {aoData : JSON.stringify(aoData),userData : JSON.stringify(userData)},// 以json格式传递
						"success" : function(resp) {
							if(resp.code==-1){
								location.href="";
							}
							fnCallback(resp);
							$('#'+tableid+' .checkboxes').each(function(){
								var value = $(this).val();
								if(valArr&&valArr.indexOf(value)!=-1){
									$(this).attr("checked",true);
								}else{
									$(this).attr("checked",false);
								}
							});
							jQuery.uniform.update('#'+tableid+'  .checkboxes');
							var set = $($('#'+tableid+' .group-checkable').attr("data-set")).not('input:checked');
							if($($('#'+tableid+'  .group-checkable').attr("data-set")).lengt=0||set.length>0){
								$('#'+tableid+'  .group-checkable').attr("checked",false);
							}else{
								$('#'+tableid+'  .group-checkable').attr("checked",true);
							}
							
							jQuery.uniform.update('#'+tableid+'  .group-checkable');
							if($(".trchild").length>0){
                        		$("#listTable thead th:first").not('.sorting_disabled').remove();
                        		initTabeTr();
                    		}
						},
						"error":function(){
							location.href="";
						}
					});
				},
				"fnDrawCallback" : function() {
					$("input").uniform();
					App.initAjaxDef();
					jQuery(".fancybox-button-msginfo").fancybox({
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
			});
			
			if (bCheckbox == true) {
				jQuery('#' + tableid + ' .group-checkable').change(function() {
					var set = jQuery(this).attr("data-set");
					var checked = jQuery(this).is(":checked");
					jQuery(set).each(function() {
						var id = parseInt($(this).val());
						if (checked) {
							if(valArr.indexOf(id)==-1){
								valArr.push(id);
							}
							$(this).attr("checked", true);
						} else {
							if(valArr.indexOf(id)!=-1){
								valArr.splice(valArr.indexOf(id),1);
							}
							$(this).attr("checked", false);
						}
					});
					try{
						selectCallBack();
					}catch(e){}
					jQuery.uniform.update(set);
				});
			}
			
		},
		delayInit : function(tableid, ajaxurl, aoColumnDefs, aoColumns, bCheckbox,
					userData){
			setTimeout(function(){
				TableCommon.init(tableid, ajaxurl, aoColumnDefs, aoColumns, bCheckbox,
						userData);
			},200);
		},
		/**
		 * 获取选择行的数据
		 * @param tableid datatable的标识ID
		 * @returns
		 */
		getSelectedIDs : function(tableid) {
			if(!valArr){
				valArr = new Array();
			}
			/**
			if(tableid){
				var set = jQuery('#' + tableid + ' .group-checkable').attr(
						"data-set");
				jQuery(set).each(function() {
					if ($(this).attr("checked")) {
						valArr.push($(this).val());
					}
				});
			}**/
			return valArr;
		},
		clearSelectedArray:function(){
			valArr = new Array();
		},
		initSelectedIds:function(arr){
			valArr = arr;
		},
			
	
		/**
		 * 重新加载第一页数据
		 * @param tableid datatable的标识ID
		 * @returns
		 */
		reloadFirstPage:function(tableid){
			$("#"+tableid).dataTable().fnPageChange("first"); //返回到第一页
		},
		/**
		 * 成功提示框
		 * @param info 提示信息
		 * @returns
		 */
		success:function(info){
			$.scojs_message(info, $.scojs_message.TYPE_OK);//提示操作成功
		},
		/**
		 * 错误提示框
		 * @param info 提示信息
		 * @returns
		 */
		error:function(info){
			$.scojs_message(info, $.scojs_message.TYPE_ERROR);//提示操作失败
		},
		/**
		 * 确认框
		 * @param info 确认提示信息
		 * @param fun 确认后的执行函数
		 * @returns
		 */
		confirm:function(info,fun){
			var confirm = $.scojs_confirm({
				  content: '<p><span class="icon icon-warning-sign"></span>'+info+'</p>',
				  action: fun
				});
			confirm.show();
			return confirm;
		},
		/**
		 * 通用删除数据的操作，服务器成功删除后返回格式为："{\"code\":\"200\",\"info\":\"删除成功！\"}"，
		 * 失败的格式为："{\"code\":\"500\",\"info\":\"删除失败！\"}"
		 * @param url 删除的请求地址，需要附件参数
		 * @param tableid datatable的标识ID,可用于重新加载用户分页数据
		 * @returns
		 */
		deleteConfirm:function(url,tableid,confirmMsg){
			var confirm = $.scojs_confirm({
				  content: '<p><span class="icon icon-warning-sign"></span>'+(confirmMsg||"确认是否删除选择数据?")+'</p>',
				  action: function(){
					  	TableCommon.clearSelectedArray();
				  		$.ajax({
							"type" : "GET",
							"contentType" : "application/json",
							"url" : url,
							"dataType" : "json",
							"success" : function(res) {
								if(res.code==-1){
									location.href="";
									return;
								}
								if(res.code == 200){
	                        		TableCommon.success(res.info);//提示操作成功
	                        	if(tableid){
	                        		TableCommon.reloadFirstPage(tableid); //返回到第一页
	                        	}
					  			}else{
					  				TableCommon.error(res.info);//提示操作失败
					  			}
				  				confirm.close();//关闭确认框
							},
							"error":function(){
								location.href="";
							}
						});
					 /**$.get(url, {}, function (res) {
				  			if(res.code == 200){
	                        	TableCommon.success(res.info);//提示操作成功
	                        	if(tableid){
	                        		TableCommon.reloadFirstPage(tableid); //返回到第一页
	                        	}
				  			}else{
				  				TableCommon.error(res.info);//提示操作失败
				  			}
				  			confirm.close();//关闭确认框
	                    },'json');**/
				  }
				});
			confirm.show();
		},
		/**
		 * 通用排序保存操作，服务器成功保存后返回格式为："{\"code\":\"200\",\"info\":\"\"}"，
		 * @param url 排序的请求地址，需要附件参数
		 * @param tableid datatable的标识ID,可用于重新加载用户分页数据
		 * @returns
		 */
		saveObj:function(url,method,tableid){
			$.ajax({
				type : method,
				contentType : "application/json",
				url : url,
				dataType : "json",
				success : function(res) {
					if(res.code==-1){
						location.href="";
					}
					if(res.code == 200){
	                	if(tableid){
	                		TableCommon.reloadFirstPage(tableid); //返回到第一页
	                	}
		  			}
				}
				,
				error:function(){
					location.href="";
				}
				});
		},
		/**
		 * 通用保存数据操作，服务器成功删除后返回格式为："{\"code\":\"200\",\"info\":\"保存成功！\"}"，
		 * 失败的格式为："{\"code\":\"500\",\"info\":\"保存失败！\"}"，操作成功后页面转向指定地址
		 * @param saveUrl 保存的URL，需要附件参数
		 * @param forwardUrl 成功后转向的URL，当参数为null时停留在该页面
		 * @returns
		 */
		saveComfirm:function(saveUrl,forwardUrl,loadNode,methodType,confirmMsg){
			var url="";
			var param="";
			if(saveUrl.indexOf("?")!=-1){
				var urlArry = saveUrl.split("?");
				url = urlArry[0];
				param = urlArry[1];
			}
			
			var confirm = $.scojs_confirm({
				  content: '<p><span class="icon icon-warning-sign"></span>'+(confirmMsg||'确认是否保存数据?')+'</p>',
				  action: function(){
					  $.ajax({
							"type" : methodType||"POST",
							"url" : url,
							"data":param,
							"dataType" : "json",
							"success" : function(res) {
								if(res.code==-1){
									location.href="";
									return;
								}
								if(res.code == 200){
		                        	TableCommon.success(res.info);//提示操作成功
		                        	if(forwardUrl){
		                        		App.forwardAjax(forwardUrl,"get",loadNode);
		                        	}
					  			}else{
					  				TableCommon.error(res.info);//提示操作失败
					  			}
					  			confirm.close();//关闭确认框
							},
							"error":function(){
								location.href="";
							}
						});
				  }
				});
			confirm.show();
		},
		saveComfirmLoadFirstPage:function(saveUrl,methodType,confirmMsg,tableId){
			var confirm = $.scojs_confirm({
				  content: '<p><span class="icon icon-warning-sign"></span>'+(confirmMsg||'确认是否保存数据?')+'</p>',
				  action: function(){
				  	TableCommon.clearSelectedArray();
					  $.ajax({
							"type" : methodType||"POST",
							"contentType" : "application/json",
							"url" : saveUrl,
							"dataType" : "json",
							"success" : function(res) {
								if(res.code==-1){
									location.href="";
									return;
								}
								if(res.code == 200){
									TableCommon.success(res.info);
		                        	TableCommon.reloadFirstPage(tableId); //返回到第一页
					  			}else{
					  				TableCommon.error(res.info);//提示操作失败
					  			}
					  			confirm.close();//关闭确认框
							},
							"error":function(){
								location.href="";
							}
						});
				  }
				});
			confirm.show();
		},
		getPageParam:function(){
			return dataTable.fnSettings();
		}
	}
}();