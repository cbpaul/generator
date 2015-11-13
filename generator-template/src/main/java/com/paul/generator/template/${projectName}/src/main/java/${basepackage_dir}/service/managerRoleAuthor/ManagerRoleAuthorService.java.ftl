package ${basepackage}.service.managerRoleAuthor;

import ${basepackage}.entity.ManagerRoleAuthor;
import ${basepackage}.service.BaseManager;

public abstract interface ManagerRoleAuthorService
  extends BaseManager<ManagerRoleAuthor, Long>
{
  public abstract Long isExist(Long paramLong1, Long paramLong2);
  
  public abstract void deleteRoleAuthor(Long paramLong);
  
  public abstract void saveRoleAuthor(Long paramLong1, Long paramLong2);
}





