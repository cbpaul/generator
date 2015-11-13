 package ${basepackage}.entity;
 
 import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import ${basepackage}.utils.ObjectUtils;
 
 @Entity
 @Table(name="manager")
 public class Manager
   extends IdEntity
 {
   private String realName;
   private String loginName;
   private String password;
   private String mobile;
   private ManagerRole role;
   private Integer hidden;
   private Integer sex;
   private String remark;
   private Long createdOn;
   
   public Manager() {}
   
   public Manager(Long id)
   {
     this.id = id;
   }
   
   public void setRealName(String realName)
   {
     this.realName = realName;
   }
   
   @Column(name="realName", length=50)
   public String getRealName()
   {
     return this.realName;
   }
   
   public void setLoginName(String loginName)
   {
     this.loginName = loginName;
   }
   
   @Column(name="loginName", length=50)
   public String getLoginName()
   {
     return this.loginName;
   }
   
   public void setPassword(String password)
   {
     this.password = password;
   }
   
   @Column(name="password", length=50)
   public String getPassword()
   {
     return this.password;
   }
   
   public void setMobile(String mobile)
   {
     this.mobile = mobile;
   }
   
   @Column(name="mobile", length=50)
   public String getMobile()
   {
     return this.mobile;
   }
   
   @ManyToOne
   @JoinColumn(name="roleId", referencedColumnName="id")
   public ManagerRole getRole()
   {
     return this.role;
   }
   
   public void setRole(ManagerRole role)
   {
     this.role = role;
   }
   
   public void setHidden(Integer hidden)
   {
     this.hidden = hidden;
   }
   
   @Column(name="hidden")
   public Integer getHidden()
   {
     return this.hidden;
   }
   
   public void setSex(Integer sex)
   {
     this.sex = sex;
   }
   
   @Column(name="sex")
   public Integer getSex()
   {
     return this.sex;
   }
   
   public void setRemark(String remark)
   {
     this.remark = remark;
   }
   
   @Column(name="remark", length=500)
   public String getRemark()
   {
     return this.remark;
   }
   
   public void setCreatedOn(Long createdOn)
   {
     this.createdOn = createdOn;
   }
   
   @Column(name="createdOn")
   public Long getCreatedOn()
   {
     return this.createdOn;
   }
   
   @Transient
   public String getFormatCreateOn()
   {
     if (this.createdOn != null) {
       return ObjectUtils.dateTimeToStr(this.createdOn.longValue(), "yyyy-MM-dd HH:mm:ss");
     }
     return "";
   }
 }





