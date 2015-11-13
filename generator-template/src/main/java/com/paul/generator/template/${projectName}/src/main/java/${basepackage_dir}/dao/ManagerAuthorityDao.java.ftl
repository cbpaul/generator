package ${basepackage}.dao;

import ${basepackage}.entity.ManagerAuthority;
import java.util.List;

public abstract interface ManagerAuthorityDao
  extends BaseRepository<ManagerAuthority, Long>
{
  public abstract List<ManagerAuthority> findByParentIdAndShowType(Long paramLong, Integer paramInteger);
}





