<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- BEGIN PAGE HEADER-->
<div class="row-fluid">

	<div class="span12">
	<input type="hidden" id="baseUrl" value="${r"${base}">
		<!-- BEGIN PAGE TITLE & BREADCRUMB-->
		<h3 class="page-title">
		</h3>
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
					<i class="icon-pencil"></i>${r"${bean.id == null ?"新建帐号":"修改帐号"}
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
					<input type="hidden" id="hidden" name="hidden" value="${r"${bean.hidden }" />
					<input type="hidden" id="createdOn" name="createdOn" value="${r"${bean.createdOn }" />
					<h4 class="form-section">帐号信息</h4>
					<div class="control-group">
						<label class="control-label">帐号<span class="required">*</span>
						</label>
						<div class="controls">
							<input name="loginName" remote="${r"${base}"}validEl?el=loginName&id=${r"${bean.id}" type="text" data-required="1" value="${r"${bean.loginName }"
								class="large m-wrap required loginName" maxlength="14"/>
						</div>
					</div>
					<c:if test="${r"${bean.id  eq null}">
						<div class="control-group">
							<label class="control-label">密码<span class="required">*</span>
							</label>
							<div class="controls">
								<input id="password" name="password" type="password" data-required="1" value="${r"${bean.password }"
									class="large m-wrap required password" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">确认密码<span class="required">*</span>
							</label>
							<div class="controls">
								<input name="password1" type="password" equalTo="#password" data-required="1" value="${r"${bean.password }"
									class="large m-wrap required" />
							</div>
						</div>
					</c:if>
					<div class="control-group">
						<label class="control-label">角色<span class="required">*</span>
						</label>
						<div class="controls">
							<select class="large m-wrap required" name="role.id">
								<option value="">选择角色...</option>
								<c:forEach items="${r"${roleList}" var="roleBean">
									<option value="${r"${roleBean.id }" ${r"${roleBean.id == bean.role.id ? "selected":"" }>${r"${roleBean.roleName }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">姓名
						</label>
						<div class="controls">
							<input name="realName" type="text" maxlength="16" data-required="1" value="${r"${bean.realName }"
								class="large m-wrap" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">性别</label>
						<div class="controls">
							<label class="radio">
							<input type="radio" name="sex" value="1" ${r"${bean.sex == 1 ? "checked":"" } />
							男
							</label>
							<label class="radio">
							<input type="radio" name="sex" value="0" ${r"${bean.sex == 0 ? "checked":"" } />
							女
							</label>  
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">手机
						</label>
						<div class="controls">
							<input name="mobile" remote="${r"${base}"}validEl?el=mobile&id=${r"${bean.id}" type="text" data-required="1" value="${r"${bean.mobile }"
								class="large m-wrap mobile" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">备注 </label>
						<div class="controls">
							<textarea name="remark" rows="3" maxlength="50"
								class="large m-wrap">${r"${bean.remark}</textarea>
						</div>
					</div>
				</form>
				<!-- END FORM-->
			</div>
		</div>
		<!-- END SAMPLE FORM PORTLET-->
	</div>
</div>

<!-- END PAGE CONTENT-->