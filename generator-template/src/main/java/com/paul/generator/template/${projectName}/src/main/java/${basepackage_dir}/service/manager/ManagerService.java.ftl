package cn.interfocus.hf.service.manager;

import cn.interfocus.hf.entity.Manager;
import ${basepackage}.entity.ManagerRole;
import ${basepackage}.service.BaseManager;
import ${basepackage}.controller.manager.AuthDTO;
import java.util.List;
import org.springframework.ui.Model;

public abstract interface ManagerService
  extends BaseManager<Manager, Long>
{
  public abstract Manager login(String paramString1, String paramString2, Model paramModel);
  
  public abstract List<AuthDTO> getRoleAvailableMenu(Long paramLong, Integer... paramVarArgs);
  
  public abstract void saveManager(Manager paramManager);
  
  public abstract Boolean validLoginName(String paramString1, String paramString2);
  
  public abstract Boolean validMobile(String paramString1, String paramString2);
  
  public abstract void reloadAuth(ManagerRole paramManagerRole);
}





