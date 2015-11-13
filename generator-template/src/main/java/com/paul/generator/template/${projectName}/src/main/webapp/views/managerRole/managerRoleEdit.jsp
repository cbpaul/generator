<%@ page contentType="text/html;charset=UTF-8"%>
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
					<i class="icon-pencil"></i>${r"${bean.id == null ?"新建角色":"修改角色"}
				</div>
				<div class="actions">
					<a  class="btn blue saveData" formId="form-save"><i class="icon-save"></i> 保存</a> 
					<a href="${r"${base}"}list" type="get" class="btn red ajaxDef"><i class="icon-chevron-left"></i> 取消</a>
					<div class="btn-group"></div>
				</div>
			</div>
			<div class="portlet-body form">
				<!-- BEGIN FORM-->
				<form action="#" id="form-save" class="form-horizontal required-validate">
					<input type="hidden" id="id" name="id" value="${r"${bean.id }" />
					<h4 class="form-section">角色信息</h4>
					<div class="control-group">
						<label class="control-label">角色名称<span class="required">*</span>
						</label>
						<div class="controls">
							<input name="roleName" type="text" data-required="1" value="${r"${bean.roleName }"
								class="large m-wrap required roleName" maxlength="50"/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">角色描述 </label>
						<div class="controls">
							<textarea name="description" rows="3" maxlength="100"
								class="large m-wrap">${r"${bean.description}</textarea>
						</div>
					</div>
					<h4 class="form-section">权限设置</h4>
					<table style="font-size: 12px;">
						<tr id="tr_0">
							<td>
								<div id="div_space_0" style="display: inline-block;width:10;">&nbsp;</div>
								<img src="media/tree/tree/elbow-plus-nl.gif" class="oc_0" id="0"
								onclick="closeOpenTbody(this)" /> <input type="checkbox"
								name="treeCheckbox" id="ck_0" value="0" checked="checked"
								onclick="treeCheckboxClick(this)" /> <span id="inSpan_0">所有后台操作权限</span>
							</td>
						</tr>
					</table>
				</form>
				<!-- END FORM-->
			</div>
		</div>
		<!-- END SAMPLE FORM PORTLET-->
	</div>
</div>
<!-- END PAGE CONTENT-->

<script src="media/tree/tree_suyin.js"></script>
<script>
	jQuery(document).ready(
			function() {
				if ($("#id").val()) {
					treeVar.roleId = $("#id").val();
				}
				openFirstNode();
			});
</script>
<!-- END PAGE CONTENT-->

