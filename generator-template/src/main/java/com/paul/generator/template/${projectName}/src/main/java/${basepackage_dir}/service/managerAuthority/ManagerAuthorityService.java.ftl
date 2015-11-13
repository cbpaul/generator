package ${basepackage}.service.managerAuthority;

import ${basepackage}.entity.ManagerAuthority;
import ${basepackage}.service.BaseManager;
import java.util.List;
import java.util.Map;

public abstract interface ManagerAuthorityService
  extends BaseManager<ManagerAuthority, Long>
{
  public abstract List<Map<String, Object>> listAuthrityMap(Long paramLong);
  
  public abstract List<ManagerAuthority> listByParentIdAndShowType(Long paramLong, Integer paramInteger);
}





