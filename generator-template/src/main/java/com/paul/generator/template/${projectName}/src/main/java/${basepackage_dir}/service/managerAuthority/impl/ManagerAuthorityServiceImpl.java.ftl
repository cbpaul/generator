 package ${basepackage}.service.managerAuthority.impl;
 
 import ${basepackage}.entity.ManagerAuthority;
 import ${basepackage}.dao.ManagerAuthorityDao;
 import ${basepackage}.dao.ManagerAuthorityTemplateDao;
 import ${basepackage}.service.impl.BaseManagerImpl;
 import ${basepackage}.service.managerAuthority.ManagerAuthorityService;
 import java.util.List;
 import java.util.Map;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Component;
 import org.springframework.transaction.annotation.Transactional;
 
 @Component
 @Transactional
 public class ManagerAuthorityServiceImpl
   extends BaseManagerImpl<ManagerAuthority, Long>
   implements ManagerAuthorityService
 {
   private ManagerAuthorityDao managerAuthorityDao;
   private ManagerAuthorityTemplateDao managerAuthorityTemplateDao;
   
   @Autowired
   public void setManagerAuthorityDao(ManagerAuthorityDao managerAuthorityDao)
   {
     this.managerAuthorityDao = managerAuthorityDao;
     this.dao = managerAuthorityDao;
   }
   
   @Autowired
   public void setManagerAuthorityTemplateDao(ManagerAuthorityTemplateDao managerAuthorityTemplateDao)
   {
     this.managerAuthorityTemplateDao = managerAuthorityTemplateDao;
   }
   
   public List<Map<String, Object>> listAuthrityMap(Long parentId)
   {
     return this.managerAuthorityTemplateDao.listAuthrityMap(parentId);
   }
   
   public List<ManagerAuthority> listByParentIdAndShowType(Long parentId, Integer showType)
   {
     return this.managerAuthorityDao.findByParentIdAndShowType(parentId, showType);
   }
 }





