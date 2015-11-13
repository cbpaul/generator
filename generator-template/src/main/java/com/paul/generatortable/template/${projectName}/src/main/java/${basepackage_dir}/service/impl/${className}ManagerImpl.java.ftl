<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import ${basepackage}.entity.${className};
import ${basepackage}.dao.${className}Dao;
import ${basepackage}.service.impl.BaseManagerImpl;
import ${basepackage}.service.${className}Manager;

@Component
@Transactional
public class ${className}ManagerImpl extends BaseManagerImpl<${className}, Long> implements ${className}Manager {
	private ${className}Dao ${classNameLower}Dao;
	@Autowired
	public void set${className}Dao(${className}Dao ${classNameLower}Dao) {
		this.${classNameLower}Dao = ${classNameLower}Dao;
		this.dao = ${classNameLower}Dao;
	}

	<#list table.columns as column>
	<#if column.unique && !column.pk>
	@Transactional(readOnly=true)
	public ${className} getBy${column.columnName}(${column.javaType} ${column.columnName?uncap_first}) {
		return ${classNameLower}Dao.findBy${column.columnName}(${column.columnName?uncap_first});
	}	
	</#if>
	</#list>
}