<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.dao;



import java.io.Serializable;
import org.springframework.data.jpa.dao.JpaRepository;
import org.springframework.data.jpa.dao.JpaSpecificationExecutor;

/**
* @包名：   ${basepackage}
* @文件名： BaseRepository.java
* @描述: TODO
* @作者：   paul 
* @时间：<#if now??>${now?string('yyyy.MM.dd')}</#if>
* @版本： V ${codeversion}
*/
@NoRepositoryBean
public interface BaseRepository<T, ID extends Serializable> extends  JpaRepository<T, ID>,JpaSpecificationExecutor<T> {
	
}
