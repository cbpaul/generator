<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.controller;

import java.io.Writer;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ${basepackage}.entity.${className};
import ${basepackage}.service.${className}Manager;
import ${basepackage}.service.BaseManager;
import ${basepackage}.utils.MD5Utils;
import ${basepackage}.utils.ServiceUtils;
import ${basepackage}.controller.BaseController;
@Controller
@RequestMapping(value = "/controller/${className}")
public class ${className}Controller extends BaseController<${className}>{
	@Autowired
	private ${className}Manager ${classNameLower}Manager;
	@Override
	protected BaseManager<${className}, Long> getManager() {
		// TODO Auto-generated method stub
		return ${classNameLower}Manager;
	}

	@RequestMapping(value = { "/add", "/edit" }, method = RequestMethod.POST)
	public void save(Writer writer, ${className} bean) {
		try {
			${classNameLower}Manager.save(bean);
			ServiceUtils.successedMVC("保存成功！", writer);
		} catch (Exception e) {
			e.printStackTrace();
			ServiceUtils.errorMVC(500, "保存失败！", writer);
		}
	}
	@Override
	protected void setListCommonModel(Model model) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void setEditCommonModel(Model model, Long id) {
		// TODO Auto-generated method stub
		
	}
	

}
