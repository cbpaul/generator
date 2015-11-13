<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.service.impl;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.transaction.annotation.Transactional;

import ${basepackage}.dao.BaseRepository;
import ${basepackage}.service.BaseManager;
import ${basepackage}.utils.GenericsUtils;
import ${basepackage}.utils.SearchFilter;
import ${basepackage}.utils.DynamicSpecifications;

/**
* 业务基类接口实现
* @包名:	${basepackage}.service.base.impl
* @文件名： ${className}ManagerImpl.java
* @描述: 	TODO
* @作者：   paul 
* @时间：	<#if now??>${now?string('yyyy.MM.dd')}</#if>
* @版本：	V${codeversion}
*/
public class BaseManagerImpl<T, PK extends Serializable> implements BaseManager<T, PK> {
	protected Class<T> entityClass;
    protected final Logger log = LoggerFactory.getLogger(getClass());
    protected BaseRepository<T, PK> dao;
	private PK[] id;



    public BaseManagerImpl(BaseRepository<T, PK> genericDao) {
        this.dao = genericDao;
    }
    protected Class<T> getEntityClass(){
    	return entityClass;
    }
    @SuppressWarnings("unchecked")
	public BaseManagerImpl() {
		entityClass = GenericsUtils.getSuperClassGenricType(getClass());
		if (log.isDebugEnabled()) {
			log.debug("AbstractHibernateDao be Created, and class is :"
					+ entityClass.toString());
		}
	}
    /**
     * {@inheritDoc}
     */
    public List<T> getAll() {
        return dao.findAll();
    }
    public List<T> getAll(Direction sortType,String...sortProperties){
    	return dao.findAll(new Sort(sortType, sortProperties));
    }
    /**
     * {@inheritDoc}
     */
    public T get(PK id) {
        return dao.findOne(id);
    }

    /**
     * {@inheritDoc}
     */
    public boolean exists(PK id) {
        return dao.exists(id);
    }

    /**
     * {@inheritDoc}
     */
    public T save(T object) {
        return dao.save(object);
    }

    /**
     * {@inheritDoc}
     */
    public void remove(T object) {
        dao.delete(object);
    }

    /**
     * {@inheritDoc}
     */
    public void remove(PK id) {
        dao.delete(id);
    }

    /**
     * {@inheritDoc}
     * <p/>
     * Search implementation using Hibernate Search.
     */
	public List<T> search(Map<String, Object> searchParams, Direction sortType,String...sortProperties) {
        if (searchParams == null ||	searchParams.size()==0) {
            return getAll();
        }
        Specification<T> specification= buildSpecification(searchParams);
        return dao.findAll(specification,new Sort(sortType, sortProperties));
    }

	public Page<T> findPage(int pageNumber, int pageSize, String sortType, Map<String, Object> searchParams,String... properties){
		  PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType,properties);
		  Specification<T> specification= buildSpecification(searchParams);
		return dao.findAll(specification,pageRequest);
	}

	/**
     * 创建分页请求.
     */
    public PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType,String... properties) {
        Sort sort = null;
        if ("desc".equals(sortType)) {
            sort = new Sort(Direction.DESC, properties);
        } else if ("asc".equals(sortType)) {
            sort = new Sort(Direction.ASC, properties);
        }
        return new PageRequest(pageNumber, pagzSize, sort);
    }
    
    /**
	 * 创建动态查询条件组合.
	 */
	protected Specification<T> buildSpecification( Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters =new HashMap<String, SearchFilter>();
		if(searchParams!=null){
			filters = SearchFilter.parse(searchParams);
		}
		Specification<T> spec = DynamicSpecifications.bySearchFilter(filters.values(), getEntityClass());
		return spec;
	}
	@Override
	public void remove(PK... id) {
		for(PK pk:id){
			remove(pk);
		}
		
	}
	@Override
	@Transactional
	public void deleteLogical(String tableName, Long... id) {
		//genericTemplateDao.deleteLogical(tableName, id);
	}
	/* (non-Javadoc)
	 * @see cn.interfocus.rmp.service.generic.GenericManager#listNoHidden()
	 */
	@Override
	public List<T> listNoHidden(final Direction sortType,final String...properties) {
		try {
			return dao.findAll(new Specification<T>() {
				@Override
				public Predicate toPredicate(Root<T> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
					// TODO Auto-generated method stub
					return cb.equal(root.get("hidde"), 0);
				}
			}, new Sort(sortType, properties));
		} catch (Exception e) {
			return dao.findAll();
		}
		
	}
}
