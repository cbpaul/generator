<#assign className = table.className>  
package ${basepackage}.dao;
import ${basepackage}.entity.${className};
/**
* @包名:	${basepackage}.repository
* @文件名： ${className}Dao.java
* @描述: 	TODO
* @作者：   paul 
* @时间：	<#if now??>${now?string('yyyy.MM.dd')}</#if>
* @版本：	V${codeversion}
*/
public interface ${className}Dao extends BaseRepository<${className}, Long> {
	/**
	 * 根据${table.sqlName}查找对象
	 */
	<#list table.columns as column>
		<#if column.unique && !column.pk>
			public ${className} findBy${column.columnName}(${column.javaType} ${column.columnName?uncap_first});
		</#if>
	</#list>
}