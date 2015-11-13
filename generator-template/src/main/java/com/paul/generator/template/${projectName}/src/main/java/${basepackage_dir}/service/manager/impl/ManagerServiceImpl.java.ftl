 package ${basepackage}.service.manager.impl;
 
 import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import ${basepackage}.Constants;
import ${basepackage}.entity.Manager;
import ${basepackage}.entity.ManagerAuthority;
import ${basepackage}.entity.ManagerRole;
import ${basepackage}.dao.ManagerDao;
import ${basepackage}.dao.ManagerRoleDao;
import ${basepackage}.service..impl.BaseManagerImpl;
import ${basepackage}.service.manager.ManagerService;
import ${basepackage}.utils.MD5Utils;
import ${basepackage}.utils.ObjectUtils;
import ${basepackage}.controller.manager.AuthDTO;
 
 @Component
 @Transactional
 public class ManagerServiceImpl
   extends BaseManagerImpl<Manager, Long>
   implements ManagerService
 {
   private ManagerDao managerDao;
   @Autowired
   private ManagerRoleDao roleDao;
   
   @Autowired
   public void setManagerDao(ManagerDao managerDao)
   {
     this.managerDao = managerDao;
     this.dao = managerDao;
   }
   
   public Manager login(String account, String password, Model mav)
   {
     if (password.length() != 32) {
       password = MD5Utils.MD5(password);
     }
     Manager manager = this.managerDao.findByLoginNameAndPassword(account, password);
     if (manager == null) {
       return null;
     }
     ManagerRole role = manager.getRole();
     if (role != null)
     {
       Set<ManagerAuthority> auth = (Set)Constants.roleAuthMap.get(role.getId());
       if (auth == null) {
         reloadAuth(role);
       }
     }
     return manager;
   }
   
   public void reloadAuth(ManagerRole role)
   {
     Set<ManagerAuthority> auth = new HashSet();
     List<ManagerAuthority> authorities = this.roleDao.findByRoleId(role.getId(), Arrays.asList(new Integer[] { Integer.valueOf(0), Integer.valueOf(1), Integer.valueOf(2) }));
     
     auth.addAll(authorities);
     Constants.roleAuthMap.put(role.getId(), auth);
   }
   
   public List<AuthDTO> getRoleAvailableMenu(Long roleId, Integer... types)
   {
     List<ManagerAuthority> authorities = null;
     if ((roleId.longValue() != 1L) && (types != null) && (types.length > 0)) {
       authorities = this.roleDao.findByRoleId(roleId, Arrays.asList(types));
     } else {
       authorities = this.roleDao.findAllShowAuth();
     }
     List<AuthDTO> authDTOs = new ArrayList();
     List<AuthDTO> resuList = new ArrayList();
     if ((authorities != null) && (authorities.size() > 0))
     {
       Iterator<ManagerAuthority> authIterator = authorities.iterator();
       while (authIterator.hasNext())
       {
         ManagerAuthority authority = (ManagerAuthority)authIterator.next();
         if ((authority.getParentId() == null) || (authority.getParentId().longValue() == 0L))
         {
           AuthDTO authDTO = new AuthDTO(authority.getId());
           if (!authDTOs.contains(authDTO))
           {
             BeanUtils.copyProperties(authority, authDTO);
             authDTOs.add(authDTO);
           }
           authIterator.remove();
         }
       }
       if (authorities.size() != 0) {
         resuList = recurAuths(authorities, authDTOs, resuList);
       }
     }
     return resuList;
   }
   
   private List<AuthDTO> recurAuths(List<ManagerAuthority> handlerAuths, List<AuthDTO> levelAuths, List<AuthDTO> resultAuths)
   {
     if (handlerAuths != null)
     {
       Iterator<ManagerAuthority> authIterator = handlerAuths.iterator();
       List<AuthDTO> nextLevlAuths = new ArrayList();
       while (authIterator.hasNext())
       {
         ManagerAuthority authority = (ManagerAuthority)authIterator.next();
         AuthDTO parentAuthDTO = new AuthDTO(authority.getParentId());
         if (levelAuths.contains(parentAuthDTO))
         {
           AuthDTO parentAuth = (AuthDTO)levelAuths.get(levelAuths.indexOf(parentAuthDTO));
           
           List<AuthDTO> childers = parentAuth.getChilderns();
           if (childers == null)
           {
             childers = new ArrayList();
             parentAuth.setChilderns(childers);
           }
           AuthDTO authDTO = new AuthDTO(authority.getId());
           BeanUtils.copyProperties(authority, authDTO);
           childers.add(authDTO);
           Collections.sort(childers);
           nextLevlAuths.add(authDTO);
           authIterator.remove();
         }
       }
       if (handlerAuths.size() > 0) {
         recurAuths(handlerAuths, nextLevlAuths, resultAuths);
       }
       for (AuthDTO auth : levelAuths) {
         if (resultAuths.contains(auth))
         {
           List<AuthDTO> childList = ((AuthDTO)resultAuths.get(resultAuths.indexOf(auth))).getChilderns();
           
           Collections.sort(childList);
           auth.setChilderns(childList);
         }
       }
       List<AuthDTO> newAuths = new ArrayList();
       Collections.sort(levelAuths);
       newAuths.addAll(levelAuths);
       resultAuths = newAuths;
     }
     return resultAuths;
   }
   
   public void saveManager(Manager bean)
   {
     if (ObjectUtils.isEmpty(bean.getId()))
     {
       bean.setCreatedOn(Long.valueOf(ObjectUtils.getNowDateTime()));
       bean.setHidden(Integer.valueOf(0));
       bean.setPassword(MD5Utils.MD5(bean.getPassword()));
       this.managerDao.save(bean);
     }
     else
     {
       bean.setPassword(((Manager)this.managerDao.findOne(bean.getId())).getPassword());
       this.managerDao.save(bean);
     }
   }
   
   public Boolean validLoginName(String id, String loginName)
   {
     if (ObjectUtils.isNotNull(loginName))
     {
       List<Manager> list = this.managerDao.findByLoginName(loginName);
       if ((ObjectUtils.isNotEmpty(list)) && (list.size() > 0))
       {
         if (list.size() > 1) {
           return Boolean.valueOf(false);
         }
         if (ObjectUtils.isNotNull(id))
         {
           Manager bean = (Manager)list.get(0);
           if (bean.getId().longValue() != ObjectUtils.toLong(id).longValue()) {
             return Boolean.valueOf(false);
           }
         }
         else
         {
           return Boolean.valueOf(false);
         }
       }
     }
     return Boolean.valueOf(true);
   }
   
   public Boolean validMobile(String id, String mobile)
   {
     if (ObjectUtils.isNotNull(mobile))
     {
       List<Manager> list = this.managerDao.findByMobile(mobile);
       if ((ObjectUtils.isNotEmpty(list)) && (list.size() > 0))
       {
         if (list.size() > 1) {
           return Boolean.valueOf(false);
         }
         if (ObjectUtils.isNotNull(id))
         {
           Manager bean = (Manager)list.get(0);
           if (bean.getId().longValue() != ObjectUtils.toLong(id).longValue()) {
             return Boolean.valueOf(false);
           }
         }
         else
         {
           return Boolean.valueOf(false);
         }
       }
     }
     return Boolean.valueOf(true);
   }
 }





