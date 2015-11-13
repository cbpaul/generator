 package ${basepackage}.entity;
 
 import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
 
 @Entity
 @Table(name="manager_role")
 public class ManagerRole
   extends IdEntity
 {
   private String roleName;
   private String description;
   @JsonIgnore
   private Set<ManagerAuthority> authorities;
   
   public ManagerRole() {}
   
   public ManagerRole(Long id)
   {
     this.id = id;
   }
   
   public void setRoleName(String roleName)
   {
     this.roleName = roleName;
   }
   
   @Column(name="roleName", length=50)
   public String getRoleName()
   {
     return this.roleName;
   }
   
   public void setDescription(String description)
   {
     this.description = description;
   }
   
   @Column(name="description", length=200)
   public String getDescription()
   {
     return this.description;
   }
   
   @ManyToMany(fetch=FetchType.LAZY, targetEntity=ManagerAuthority.class, cascade={javax.persistence.CascadeType.PERSIST, javax.persistence.CascadeType.MERGE})
   @JoinTable(name="manager_role_author", joinColumns={@javax.persistence.JoinColumn(name="roleId", referencedColumnName="id")}, inverseJoinColumns={@javax.persistence.JoinColumn(name="authorId", referencedColumnName="id")})
   @OrderBy("parentId asc")
   public Set<ManagerAuthority> getAuthorities()
   {
     return this.authorities;
   }
   
   public void setAuthorities(Set<ManagerAuthority> authorities)
   {
     this.authorities = authorities;
   }
 }





