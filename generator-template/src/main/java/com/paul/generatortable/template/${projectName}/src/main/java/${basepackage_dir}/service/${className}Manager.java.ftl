<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.service;

import ${basepackage}.entity.${className};
import ${basepackage}.service.BaseManager;


public interface ${className}Manager extends  BaseManager<${className}, Long> {
}