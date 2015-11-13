package ${basepackage}.controller;

import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import javax.persistence.Table;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.data.domain.Page;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ${basepackage}.service.BaseManager;
import ${basepackage}.utils.GenericsUtils;
import ${basepackage}.utils.ObjectUtils;
import ${basepackage}.utils.RequestUtils;
import ${basepackage}.utils.ServiceUtils;
import ${basepackage}.utils.StringUtils;


/**
* 控制器基类
* @包名：   ${basepackage}
* @文件名： BaseController.java
* @描述: TODO
* @作者：   paul 
* @时间：<#if now??>${now?string('yyyy.MM.dd')}</#if>
* @版本： V ${codeversion}
*/
public abstract class BaseController<T> {
	protected Class<T> entityClass;
	protected String module;
	protected String lowerModule;
	protected String moduleTableName;
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected Writer writer;
	@ModelAttribute
	public void setRequestAndResponse(HttpServletRequest request,HttpServletResponse response) throws IOException{
		this.request =request;
		this.response=response;
		this.writer = response.getWriter();
	}

	@SuppressWarnings("unchecked")
	public BaseController() {
		entityClass = GenericsUtils.getSuperClassGenricType(getClass());
		module = entityClass.getSimpleName();
		lowerModule = StringUtils.toLowerCaseFirstOne(module);
		moduleTableName = getTableName(entityClass);
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public void delete(Writer writer, Integer hidden, Long... id) {
		try {
			if (ObjectUtils.isNotEmpty(hidden) && (1 == hidden.intValue())) {
				getManager().deleteLogical(moduleTableName, id);
			} else {
				if (id != null && id.length > 0) {
					getManager().remove(id);
				}
			}
			ServiceUtils.successedMVC("删除成功！", writer);
		} catch (Exception e) {
			e.printStackTrace();
			ServiceUtils.errorMVC(500, "删除失败！", writer);
		}
	}

	/**
	 * 列表
	 * 
	 * @param aoData
	 * @param userData
	 * @param writer
	 * @param request
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void queryList(String aoData, String userData, Writer writer,
			HttpServletRequest request) {
		try {
			QueryPage queryPage = new QueryPage(aoData, userData);
			String derection = "desc";
			String field = request.getParameter("asc");
			if (ObjectUtils.isNotEmpty(field)) {
				derection = "asc";
			} else {
				field = request.getParameter("desc");
				if (ObjectUtils.isEmpty(field)) {
					field = "id";
				}
			}
			Map<String, Object> searchParams = RequestUtils
					.getParametersStartingWith(request, "search_");
			Page<T> page = getManager().findPage(
					queryPage.getDsplayPageNumber(),
					queryPage.getDisplayLength(), derection, searchParams,
					field);
			List<T> list = page.getContent();
			queryPage.writePageData(writer, list, page.getTotalElements());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String goList(Model model) {
		setCommonModel(model);
		setListCommonModel(model);
		return lowerModule + "/" + lowerModule + "List";
	}

	@RequestMapping(value = { "/edit", "/add" }, method = RequestMethod.GET)
	public String goEdit(Model model, Long id) {
		if (null != id) {
			T bean = getManager().get(id);
			if (bean != null) {
				model.addAttribute("bean", bean);
			}
		}
		setCommonModel(model);
		setEditCommonModel(model, id);
		return lowerModule + "/" + lowerModule + "Edit";
	}

	@RequestMapping(value = "show", method = RequestMethod.GET)
	public String goShow(Model model, Long id,String returnAction) {
		model.addAttribute("returnAction", returnAction);
		if (null != id) {
			T bean = getManager().get(id);
			if (bean != null) {
				model.addAttribute("bean", bean);
			}
		}
		setCommonModel(model);
		setEditCommonModel(model, id);
		return lowerModule + "/" + lowerModule + "Show";
	}

	protected abstract BaseManager<T, Long> getManager();

	protected abstract void setListCommonModel(Model model);

	protected abstract void setEditCommonModel(Model model, Long id);

	public void setCommonModel(Model model) {
		model.addAttribute("base", "controller/" + this.module);
	}

	private String getTableName(Class clazz) {
		Table annotation = (Table) clazz.getAnnotation(Table.class);
		if (annotation != null) {
			return annotation.name();
		}
		return null;
	}

}
