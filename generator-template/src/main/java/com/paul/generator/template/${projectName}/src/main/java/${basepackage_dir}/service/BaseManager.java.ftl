<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort.Direction;

/**
* 业务基类接口
* @包名:	${basepackage}.service.base
* @文件名： ${className}Manager.java
* @描述: 	TODO
* @作者：   paul 
* @时间：	<#if now??>${now?string('yyyy.MM.dd')}</#if>
* @版本：	V${codeversion}
*/
public interface BaseManager<T, PK extends Serializable> {
	/**
	 * 得到所有数据默认排序
	 */
	List<T> getAll();
	/**
	 * 得到所有数据指定排序
	 */
	List<T> getAll(Direction sortType,String...sortProperties);
    
    /**
     * 根据主键得到数据对象
     */
    T get(PK id);

    /**
     * 根据主键检查数据对象是否存在
     */
    boolean exists(PK id);

    /**
     * 保存对象
     */
    T save(T object);

    /**
     * 删除对象
     */
    void remove(T object);
    /**
    * 批量删除
    */
    void remove(PK...id);

    /**
     * 根据主键删除
     */
    void remove(PK id);

    /**
     *查询
     */
    List<T> search(Map<String, Object> searchParams, Direction sortType,String...sortProperties);
    /**
     * 分页查询
     * @param page
     * @return
     */
    public Page<T> findPage(int pageNumber, int pageSize, String sortType, Map<String, Object> searchParams,String... properties);
    
    void deleteLogical(String tableName,Long... id);
    
    List<T> listNoHidden(final Direction sortType,final String...properties);
    
}
