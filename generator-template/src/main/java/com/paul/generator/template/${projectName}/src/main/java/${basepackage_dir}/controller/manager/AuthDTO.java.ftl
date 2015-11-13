 package ${basepackage}.web.manager;
 
 import java.util.List;
 
 public class AuthDTO
   implements Comparable<Object>
 {
   private Long id;
   private Integer showType;
   private String authorityName;
   private String authorityLink;
   private Integer isDefault;
   private Integer sort;
   private String description;
   private List<AuthDTO> childerns;
   private String iconCss;
   
   public AuthDTO() {}
   
   public AuthDTO(Long id)
   {
     this.id = id;
   }
   
   public Long getId()
   {
     return this.id;
   }
   
   public void setId(Long id)
   {
     this.id = id;
   }
   
   public Integer getShowType()
   {
     return this.showType;
   }
   
   public void setShowType(Integer showType)
   {
     this.showType = showType;
   }
   
   public String getAuthorityName()
   {
     return this.authorityName;
   }
   
   public void setAuthorityName(String authorityName)
   {
     this.authorityName = authorityName;
   }
   
   public String getAuthorityLink()
   {
     return this.authorityLink;
   }
   
   public void setAuthorityLink(String authorityLink)
   {
     this.authorityLink = authorityLink;
   }
   
   public Integer getIsDefault()
   {
     return this.isDefault;
   }
   
   public void setIsDefault(Integer isDefault)
   {
     this.isDefault = isDefault;
   }
   
   public Integer getSort()
   {
     return this.sort;
   }
   
   public void setSort(Integer sort)
   {
     this.sort = sort;
   }
   
   public String getDescription()
   {
     return this.description;
   }
   
   public void setDescription(String description)
   {
     this.description = description;
   }
   
   public List<AuthDTO> getChilderns()
   {
     return this.childerns;
   }
   
   public void setChilderns(List<AuthDTO> childerns)
   {
     this.childerns = childerns;
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
     result = 31 * result + (this.id == null ? 0 : this.id.hashCode());
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
     AuthDTO other = (AuthDTO)obj;
     if (this.id == null)
     {
       if (other.id != null) {
         return false;
       }
     }
     else if (!this.id.equals(other.id)) {
       return false;
     }
     return true;
   }
   
   public int compareTo(Object o)
   {
     AuthDTO comObj = (AuthDTO)o;
     if (getSort().intValue() - comObj.getSort().intValue() > 0) {
       return 1;
     }
     return -1;
   }
 }

