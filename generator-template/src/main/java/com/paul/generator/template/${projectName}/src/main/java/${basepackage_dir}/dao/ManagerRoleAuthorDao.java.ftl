package ${basepackage}.dao;

import ${basepackage}.entity.ManagerRoleAuthor;
import org.springframework.data.jpa.dao.Modifying;
import org.springframework.data.jpa.dao.Query;

public abstract interface ManagerRoleAuthorDao
  extends BaseRepository<ManagerRoleAuthor, Long>
{
  @Query("select count(a.id) from ManagerRoleAuthor a where a.roleId=?1 and a.authorId=?2")
  public abstract Long isExist(Long paramLong1, Long paramLong2);
  
  @Modifying
  @Query("delete ManagerRoleAuthor a where a.roleId=?1")
  public abstract void deleteRoleAuthor(Long paramLong);
}





