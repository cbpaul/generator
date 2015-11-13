 package ${basepackage}.dao;
 
 import java.util.List;
 import java.util.Map;
 import javax.annotation.Resource;
 import org.springframework.jdbc.core.JdbcTemplate;
 import org.springframework.stereotype.Repository;
 
 @Repository
 public class ManagerAuthorityTemplateDao
 {
   @Resource
   JdbcTemplate jt;
   
   public List<Map<String, Object>> listAuthrityMap(Long parentId)
   {
     StringBuilder sql = new StringBuilder();
     sql.append(" SELECT a.id,a.authorityName text,a.description value,      ");
     sql.append(" IF(ISNULL(c.idTo),'false','true') hasChildren,             ");
     sql.append(" IF(ISNULL(a.id),'true','false') complete                   ");
     sql.append(" FROM manager_authority a LEFT JOIN(                        ");
     sql.append(" SELECT COUNT(0) idTo,b.parentId FROM manager_authority b   ");
     sql.append(" WHERE b.showType > 0 GROUP BY b.parentId) c on             ");
     sql.append(" c.parentId=a.id WHERE a.parentId=? and a.showType > 0 ORDER BY a.sort,a.id asc");
     List<Map<String, Object>> list = this.jt.queryForList(sql.toString(), new Object[] { parentId });
     
     return list;
   }
 }





