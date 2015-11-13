 package ${basepackage}.service.managerRole.impl;
 
 import ${basepackage}.entity.ManagerAuthority;
 import ${basepackage}.entity.ManagerRole;
 import ${basepackage}.dao.ManagerRoleDao;
 import ${basepackage}.service.impl.BaseManagerImpl;
 import ${basepackage}.service.manager.ManagerService;
 import ${basepackage}.service.managerAuthority.ManagerAuthorityService;
 import ${basepackage}.service.managerRole.ManagerRoleService;
 import ${basepackage}.service.managerRoleAuthor.ManagerRoleAuthorService;
 import ${basepackage}.utils.ObjectUtils;
 import java.util.List;
 import java.util.Map;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Component;
 import org.springframework.transaction.annotation.Transactional;
 
 @Component
 @Transactional
 public class ManagerRoleServiceImpl
   extends BaseManagerImpl<ManagerRole, Long>
   implements ManagerRoleService
 {
   private ManagerRoleDao managerRoleDao;
   @Autowired
   private ManagerAuthorityService authorityService;
   @Autowired
   private ManagerRoleAuthorService managerRoleAuthorService;
   @Autowired
   private ManagerService managerService;
   
   @Autowired
   public void setManagerRoleDao(ManagerRoleDao managerRoleDao)
   {
     this.managerRoleDao = managerRoleDao;
     this.dao = managerRoleDao;
   }
   
   public String getAuthrityListJSON(Long id, Long roleId)
   {
     List<Map<String, Object>> listMap = this.authorityService.listAuthrityMap(id);
     if (ObjectUtils.isEmpty(listMap)) {
       return "[]";
     }
     StringBuilder json = new StringBuilder();
     for (Map<String, Object> map : listMap)
     {
       json.append(json.length() > 0 ? ",{" : "{");
       json.append("\"id\":\"").append(map.get("id")).append("\" ,");
       json.append("\"text\":\"").append(map.get("text")).append("\" ,");
       json.append("\"value\":\"").append(map.get("value")).append("\" ,");
       json.append("\"hasChildren\":\"").append(Boolean.parseBoolean(map.get("hasChildren").toString())).append("\" ,");
       
 
       json.append("\"complete\":\"").append(Boolean.parseBoolean(map.get("complete").toString())).append("\" ,");
       
 
 
       json.append("\"showcheck\":\"").append(true).append("\" ,");
       json.append("\"isexpand\":\"").append(false).append("\" ,");
       if ((roleId == null) || (0L == roleId.longValue()))
       {
         json.append("\"checkState\":\"").append(0).append("\"");
       }
       else
       {
         long checkState = this.managerRoleAuthorService.isExist(roleId, ObjectUtils.toLong(map.get("id"))).longValue();
         
         json.append("\"checkState\":\"").append(checkState).append("\"  ");
       }
       json.append(" }");
     }
     return "]";
   }
   
   public void saveRole(ManagerRole bean, Long... treeCheckbox)
   {
     if (bean.getId() != null) {
       this.managerRoleAuthorService.deleteRoleAuthor(bean.getId());
     }
     this.managerRoleDao.save(bean);
     for (Long authorId : treeCheckbox) {
       if (authorId.longValue() != 0L)
       {
         this.managerRoleAuthorService.saveRoleAuthor(authorId, bean.getId());
         List<ManagerAuthority> list = this.authorityService.listByParentIdAndShowType(authorId, Integer.valueOf(0));
         for (ManagerAuthority ma : list) {
           this.managerRoleAuthorService.saveRoleAuthor(ma.getId(), bean.getId());
         }
       }
     }
     this.managerService.reloadAuth(bean);
   }
 }





