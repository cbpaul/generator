<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
${gg.setOverride(true)}
package ${basepackage}.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import ${basepackage}.entity.IdEntity;

import java.io.Serializable;


/**
 * entity.
 */
@Entity
@Table(name="${table.sqlName}")
public class ${className}  extends IdEntity implements Serializable {

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public ${className}(){
	}
	public ${className}(Long id) {
		this.id = id;
	}
	<#list table.columns as column>
	<#if !column.pk>
	/**
	 * ${column.remarks}
	 */
	private ${column.javaType}  ${column.columnName?uncap_first};
	public ${column.javaType} get${column.columnName}() {
		return ${column.columnName?uncap_first};
	}	
	public void set${column.columnName}(${column.javaType} ${column.columnName?uncap_first}) {
		this.${column.columnName?uncap_first}=${column.columnName?uncap_first};
	}
	</#if>
	</#list>

}