package ${basepackage}.dao;

import ${basepackage}.entity.Manager;
import java.util.List;

public abstract interface ManagerDao
  extends BaseRepository<Manager, Long>
{
  public abstract Manager findByLoginNameAndPassword(String paramString1, String paramString2);
  
  public abstract List<Manager> findByLoginName(String paramString);
  
  public abstract List<Manager> findByMobile(String paramString);
}





