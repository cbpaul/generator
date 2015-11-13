<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp" %>
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
		<!-- BEGIN SAMPLE FORM PORTLET-->
		<div class="portlet box grey">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-pencil"></i>修改密码
				</div>
				<div class="actions">
					<a action="${r"${base }"}changePwd" class="btn blue saveData" formId="form-save"><i class="icon-save"></i> 保存</a> 
					<a href="${r"${base}"}list" type="get" class="btn red ajaxDef">
						<iclass="icon-chevron-left"></i> 取消
					</a>
					<div class="btn-group"></div>
				</div>
			</div>
			<div class="portlet-body form">
				<!-- BEGIN FORM-->
					<form   id="form-save" class="form-horizontal form-bordered form-row-stripped required-validate">
						<input type="hidden" name="id" value="${r"${id }"/>
						<div class="control-group">
							<label class="control-label">密码<span class="required">*</span>
							</label>
							<div class="controls">
								<input name="newPwd" id="password" type="password"
									data-required="1" value=""
									class="large m-wrap required password" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">确认密码<span class="required">*</span>
							</label>
							<div class="controls">
								<input type="password" data-required="1" equalto="#password"
									value="" class="large m-wrap required password" />
							</div>
						</div>
						
				</form>
				<!-- END FORM-->
			</div>
		</div>
		<!-- END SAMPLE FORM PORTLET-->
	</div>
</div>

