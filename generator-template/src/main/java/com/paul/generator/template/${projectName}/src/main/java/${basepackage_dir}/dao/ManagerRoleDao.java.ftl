package ${basepackage}.dao;

import ${basepackage}.entity.ManagerAuthority;
import ${basepackage}.entity.ManagerRole;
import java.util.List;
import org.springframework.data.jpa.dao.Query;

public abstract interface ManagerRoleDao
  extends BaseRepository<ManagerRole, Long>
{
  @Query("select a from  ManagerAuthority  a inner join a.roles b where  b.id=?1 and a.showType in(?2)")
  public abstract List<ManagerAuthority> findByRoleId(Long paramLong, List<Integer> paramList);
  
  @Query("select a from  ManagerAuthority  a  where a.showType=1")
  public abstract List<ManagerAuthority> findAllShowAuth();
}





