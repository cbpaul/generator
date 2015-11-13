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
}