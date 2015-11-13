 package ${basepackage}.entity;
 
 import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
 
 @Entity
 @Table(name="manager_authority")
 public class ManagerAuthority
   extends IdEntity
 {
   private String authorityName;
   private String authorityLink;
   private Long parentId;
   private String description;
   private Integer showType;
   private Integer sort;
   private Integer isDefault;
   private String iconCss;
   private Set<ManagerRole> roles;
   
   public ManagerAuthority() {}
   
   public ManagerAuthority(Long id)
   {
     this.id = id;
   }
   
   public ManagerAuthority(String authorityLink)
   {
     this.authorityLink = authorityLink;
   }
   
   public void setAuthorityName(String authorityName)
   {
     this.authorityName = authorityName;
   }
   
   @Column(name="authorityName", length=50)
   public String getAuthorityName()
   {
     return this.authorityName;
   }
   
   public void setAuthorityLink(String authorityLink)
   {
     this.authorityLink = authorityLink;
   }
   
   @Column(name="authorityLink", length=300)
   public String getAuthorityLink()
   {
     return this.authorityLink;
   }
   
   public void setParentId(Long parentId)
   {
     this.parentId = parentId;
   }
   
   @Column(name="parentId")
   public Long getParentId()
   {
     return this.parentId;
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
   
   public void setShowType(Integer showType)
   {
     this.showType = showType;
   }
   
   @Column(name="showType")
   public Integer getShowType()
   {
     return this.showType;
   }
   
   public void setSort(Integer sort)
   {
     this.sort = sort;
   }
   
   @Column(name="sort")
   public Integer getSort()
   {
     return this.sort;
   }
   
   public void setIsDefault(Integer isDefault)
   {
     this.isDefault = isDefault;
   }
   
   @Column(name="isDefault")
   public Integer getIsDefault()
   {
     return this.isDefault;
   }
   
   public String getIconCss()
   {
     return this.iconCss;
   }
   
   public void setIconCss(String iconCss)
   {
     this.iconCss = iconCss;
   }
   
   public int hashCode()
   {
     int prime = 31;
     int result = 1;
     result = 31 * result + (this.authorityLink == null ? 0 : this.authorityLink.hashCode());
     
     return result;
   }
   
   public boolean equals(Object obj)
   {
     if (this == obj) {
       return true;
     }
     if (obj == null) {
       return false;
     }
     if (getClass() != obj.getClass()) {
       return false;
     }
     ManagerAuthority other = (ManagerAuthority)obj;
     if (this.authorityLink == null)
     {
       if (other.authorityLink != null) {
         return false;
       }
     }
     else if (!this.authorityLink.equals(other.authorityLink)) {
       return false;
     }
     return true;
   }
   
   @ManyToMany(fetch=FetchType.LAZY, mappedBy="authorities", targetEntity=ManagerRole.class, cascade={javax.persistence.CascadeType.PERSIST, javax.persistence.CascadeType.MERGE})
   public Set<ManagerRole> getRoles()
   {
     return this.roles;
   }
   
   public void setRoles(Set<ManagerRole> roles)
   {
     this.roles = roles;
   }
 }





