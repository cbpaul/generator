<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- BEGIN PAGE HEADER-->
<div class="row-fluid">
	<div class="span12">
		<input type="hidden" id="baseUrl" value="${r"${base}">
		<!-- BEGIN PAGE TITLE & BREADCRUMB-->
		<h3 class="page-title"></h3>
		<ul class="breadcrumb">
		</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
	</div>
</div>

<!-- END PAGE HEADER-->

<!-- BEGIN PAGE CONTENT-->
<div class="row-fluid">
	<div class="span12">
		<div class="portlet box grey">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-search"></i>快捷搜索
				</div>
				<div class="tools">
					<a class="expand" href="javascript:;"></a>
				</div>
			</div>
			<div class="portlet-body" style="display: none">
				<form class="form-horizontal searchForm" fortableId="manager_listTable"
					style="border: 1px solid #EFEFEF;">
					<input type="hidden" id="desc" name="desc" value="id" >
					<input type="hidden" id="hidden" name="search_EQ_hidden" value="0" >
					<div class="row-fluid">
						<div class="span4">
							<div class="control-group" style="padding-top: 10px;">
								<label class="control-label">账户：</label>
								<div class="controls">
									<input type="text" class="m-wrap span10"
										name="search_LIKE_loginName" placeholder="帐号"
										style="margin-top:0px;">
								</div>
							</div>
						</div>
						<div class="span4">
							<div class="control-group" style="padding-top: 10px;">
								<label class="control-label">手机：</label>
								<div class="controls">
									<input type="text" class="m-wrap span10" placeholder="手机号码"
										name="search_LIKE_mobile" style="margin-top:0px;">
								</div>
							</div>
						</div>
						<div class="span4">
							<div class="control-group" style="padding-top: 10px;">
								<label class="control-label">姓名</label>
								<div class="controls">
									<input type="text" class="m-wrap span10" placeholder="姓名"
										id="name" name="search_LIKE_realName" style="margin-top:0px;">
								</div>
							</div>
						</div>
					</div>
					<div class="form-actions">
						<button class="btn blue search" type="button">搜索</button>
						<button class="btn clearnSearch" type="button">查看全部</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="row-fluid">
	<div class="span12 responsive" data-tablet="span12 fix-offset"
		data-desktop="span12">
		<!-- BEGIN EXAMPLE TABLE PORTLET-->
		<div class="portlet box grey">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-table"></i>账户管理
				</div>
				<div class="actions">
					<t:roleCheck url="${r"${base}"}add">
						<a href="${r"${base}"}add" type="get" class="btn blue ajaxDef"><i class="icon-pencil"></i>新建账户</a>
					</t:roleCheck>
					<t:roleCheck url="${r"${base}"}delete">
						<a fortableId="manager_listTable" logicaldel="1" class="btn red batch_delete"><i class="icon-trash"></i>批量删除</a>
					</t:roleCheck>
					<div class="btn-group"></div>
				</div>
			</div>
			<div class="portlet-body">
				<table class="table table-striped table-hover table-bordered"
					id="manager_listTable">
					<thead>
						<tr>
							<th style="width:8px;"><input type="checkbox"
								class="group-checkable" data-set="#manager_listTable .checkboxes" />
							</th>
							<th style="width:10%;">帐号</th>
							<th style="width:10%;">角色</th>
							<th style="width:10%;">姓名</th>
							<th style="width:10%;">性别</th>
							<th style="width:12%;">手机号码</th>
							<th style="width:15%;">添加日期</th>
							<th>操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<!-- END EXAMPLE TABLE PORTLET-->
	</div>
</div>
<script>
	jQuery(document).ready(function() {
		TableCommon.delayInit(
			"manager_listTable",
			"${r"${base}"}list",
			null,[
				{
					"mData" : "id",
					"mRender" : function(data, type, full) {
						return data != 1?'<input type="checkbox" class="checkboxes" value="'+data+'" />':'';
					}
				},
				{
					"mData" : "loginName"
					
				},
				{
					"mData" : "role.roleName"
				},
				{
					"mData" : "realName"
				},
				{
					"mData" : "sex",
					"mRender" : function(data, type, full) {
						return (data==1?"男":(data==0?"女":""));
					}
				},
				{
					"mData" : "mobile"
				},
				{
					"mData" : "formatCreateOn"
				},
				{
					"mData" : "id",
					"mRender" : function(data, type, full) {
						var ret ='';
			   			<t:roleCheck url="${r"${base}"}show">
		   			 		ret += '<a class="btn mini green ajaxDef" type="get" href="${r"${base}"}show?id='+data+'"><i class="icon-search"></i> 查看</a> ';
		   				</t:roleCheck>
		   				<t:roleCheck url="${r"${base}"}edit">
		   			 		ret += '<a class="btn mini green ajaxDef" type="get" href="${r"${base}"}edit?id='+data+'"><i class="icon-edit"></i> 修改</a> ';
		   				</t:roleCheck>
		   				<t:roleCheck url="${r"${base}"}changePwd">
		   					ret += '<a class="btn mini green ajaxDef" type="get" href="${r"${base}"}changePwd?id='+data+'"><i class="icon-trash"></i> 修改密码</a> ';
		   				</t:roleCheck>
		   				<t:roleCheck url="${r"${base}"}resetpwd">
		   					ret += '<a class="btn mini red" onclick="resetpwd('+data+')"><i class="icon-undo"></i> 重置密码</a> ';
		   				</t:roleCheck>
			   			if(data != 1){
			   				<t:roleCheck url="${r"${base}"}delete">
			   					ret += '<a class="btn mini red deleteItem" logicaldel="1" fortableId="manager_listTable" delId="'+data+'"><i class="icon-trash"></i> 删除</a> ';
			   				</t:roleCheck>
			   			}
						return ret;
					}
				} ], true);
	});
	
	function resetpwd(id){
		var confirm = TableCommon.confirm('确认是否重置该帐号的密码?',function(){
			$.get('${r"${base}"}resetpwd?id='+id, {}, function (res) {
				  			if(res.code == 200){
	                        	TableCommon.success(res.info);//提示操作成功
				  			}else{
				  				TableCommon.error(res.info);//提示操作失败
				  			}
				  			confirm.close();//关闭确认框
	                    },'json');
		});
		confirm.show();
	}
</script>
<!-- END PAGE CONTENT-->

