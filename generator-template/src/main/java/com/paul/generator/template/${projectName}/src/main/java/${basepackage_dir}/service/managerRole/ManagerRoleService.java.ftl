package ${basepackage}.service.managerRole;

import ${basepackage}.entity.ManagerRole;
import ${basepackage}.service.BaseManager;

public abstract interface ManagerRoleService
  extends BaseManager<ManagerRole, Long>
{
  public abstract String getAuthrityListJSON(Long paramLong1, Long paramLong2);
  
  public abstract void saveRole(ManagerRole paramManagerRole, Long... paramVarArgs);
}





