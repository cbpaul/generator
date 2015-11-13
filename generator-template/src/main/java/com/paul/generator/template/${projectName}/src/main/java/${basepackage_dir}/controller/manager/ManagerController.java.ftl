 package ${basepackage}.controller.manager;
 
 import ${basepackage}.entity.Manager;
 import ${basepackage}.service.BaseService;
 import ${basepackage}.service.manager.ManagerService;
 import ${basepackage}.service.managerRole.ManagerRoleService;
 import ${basepackage}.utils.MD5Utils;
 import ${basepackage}.utils.ObjectUtils;
 import ${basepackage}.utils.ServiceUtils;
 import ${basepackage}.controller.BaseController;
 import java.io.Writer;
 import javax.servlet.http.HttpServletRequest;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Controller;
 import org.springframework.ui.Model;
 import org.springframework.web.bind.annotation.RequestMapping;
 
 @Controller
 @RequestMapping({"/controller/Manager"})
 public class ManagerController
   extends BaseController<Manager>
 {
   @Autowired
   private ManagerService managerService;
   @Autowired
   private ManagerRoleService managerRoleManager;
   
   @RequestMapping(value={"/add", "/edit"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
   public void saveRole(Writer writer, Manager bean)
   {
     try
     {
       this.managerService.saveManager(bean);
       ServiceUtils.successedMVC("保存成功！", writer);
     }
     catch (Exception e)
     {
       e.printStackTrace();
       ServiceUtils.errorMVC(500, "保存失败！", writer);
     }
   }
   
   @RequestMapping(value={"/resetpwd"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
   public void resetpwd(Writer writer, Long id)
   {
     try
     {
       Manager bean = (Manager)this.managerService.get(id);
       bean.setPassword(MD5Utils.MD5("123456"));
       this.managerService.save(bean);
       ServiceUtils.successedMVC("操作成功！", writer);
     }
     catch (Exception e)
     {
       e.printStackTrace();
       ServiceUtils.errorMVC(500, "操作失败！", writer);
     }
   }
   
   @RequestMapping(value={"changePwd"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
   public String changePwd(Long id, Model model)
   {
     model.addAttribute("id", id);
     setCommonModel(model);
     return "manager/managerChangePwd";
   }
   
   @RequestMapping(value={"changePwd"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
   public void changePwd(Long id, String oldPwd, String newPwd, Writer writer)
   {
     try
     {
       Manager manager = (Manager)this.managerService.get(id);
       manager.setPassword(MD5Utils.MD5(newPwd));
       this.managerService.save(manager);
       ServiceUtils.successedMVC("修改成功！", writer);
     }
     catch (Exception e)
     {
       e.printStackTrace();
       ServiceUtils.errorMVC(500, "修改失败！", writer);
     }
   }
   
   @RequestMapping(value={"/validEl"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
   public void validEl(Writer writer, HttpServletRequest request, String id, String el)
   {
     if (ObjectUtils.isNotNull(el))
     {
       String val = request.getParameter(el);
       if ("loginName".equals(el))
       {
         ServiceUtils.writer(writer, this.managerService.validLoginName(id, val));
         
         return;
       }
       if ("mobile".equals(el))
       {
         ServiceUtils.writer(writer, this.managerService.validMobile(id, val));
         
         return;
       }
     }
     ServiceUtils.writer(writer, Boolean.valueOf(true));
   }
   
   protected void setListCommonModel(Model model) {}
   
   protected void setEditCommonModel(Model model, Long id)
   {
     model.addAttribute("roleList", this.managerRoleManager.getAll());
   }
 }

