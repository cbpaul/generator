 package ${basepackage}.entity;
 
 import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
 
 @Entity
 @Table(name="manager_role_author")
 public class ManagerRoleAuthor
   extends IdEntity
 {
   private Long roleId;
   private Long authorId;
   
   public ManagerRoleAuthor() {}
   
   public ManagerRoleAuthor(Long id)
   {
     this.id = id;
   }
   
   public void setRoleId(Long roleId)
   {
     this.roleId = roleId;
   }
   
   @Column(name="roleId")
   public Long getRoleId()
   {
     return this.roleId;
   }
   
   public void setAuthorId(Long authorId)
   {
     this.authorId = authorId;
   }
   
   @Column(name="authorId")
   public Long getAuthorId()
   {
     return this.authorId;
   }
 }





