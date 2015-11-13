 package ${basepackage}.service.managerRoleAuthor.impl;
 
 import ${basepackage}.entity.ManagerRoleAuthor;
 import ${basepackage}.dao.ManagerRoleAuthorDao;
 import ${basepackage}.service.impl.BaseManagerImpl;
 import ${basepackage}.service.managerRoleAuthor.ManagerRoleAuthorService;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Component;
 import org.springframework.transaction.annotation.Transactional;
 
 @Component
 @Transactional
 public class ManagerRoleAuthorServiceImpl
   extends BaseManagerImpl<ManagerRoleAuthor, Long>
   implements ManagerRoleAuthorService
 {
   private ManagerRoleAuthorDao managerRoleAuthorDao;
   
   @Autowired
   public void setManagerRoleAuthorDao(ManagerRoleAuthorDao managerRoleAuthorDao)
   {
     this.managerRoleAuthorDao = managerRoleAuthorDao;
     this.dao = managerRoleAuthorDao;
   }
   
   public Long isExist(Long roleId, Long authorId)
   {
     return this.managerRoleAuthorDao.isExist(roleId, authorId);
   }
   
   public void deleteRoleAuthor(Long roleId)
   {
     this.managerRoleAuthorDao.deleteRoleAuthor(roleId);
   }
   
   public void saveRoleAuthor(Long authorId, Long roleId)
   {
     ManagerRoleAuthor bean = new ManagerRoleAuthor();
     bean.setAuthorId(authorId);
     bean.setRoleId(roleId);
     this.managerRoleAuthorDao.save(bean);
   }
 }





