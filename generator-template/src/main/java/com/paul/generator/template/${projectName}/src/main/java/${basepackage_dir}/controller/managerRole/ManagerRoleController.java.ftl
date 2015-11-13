 package ${basepackage}.controller.managerRole;
 
 import ${basepackage}.entity.ManagerRole;
 import ${basepackage}.service.managerRole.ManagerRoleService;
 import ${basepackage}.utils.ServiceUtils;
 import ${basepackage}.controller.BaseController;
 import java.io.PrintStream;
 import java.io.Writer;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Controller;
 import org.springframework.ui.Model;
 import org.springframework.web.bind.annotation.RequestMapping;
 
 @Controller
 @RequestMapping({"/controller/ManagerRole"})
 public class ManagerRoleController
   extends BaseController<ManagerRole>
 {
   @Autowired
   private ManagerRoleService roleService;
   
   @RequestMapping(value={"/add", "/edit"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
   public void saveRole(Writer writer, ManagerRole bean, Long... treeCheckbox)
   {
     try
     {
       this.roleService.saveRole(bean, treeCheckbox);
       ServiceUtils.successedMVC("保存成功！", writer);
     }
     catch (Exception e)
     {
       e.printStackTrace();
       ServiceUtils.errorMVC(500, "保存失败！", writer);
     }
   }
   
   @RequestMapping({"/getAuthrityListJSON"})
   public void getAuthrityListJSON(Writer writer, Long id, Long roleId)
   {
     String json = this.roleService.getAuthrityListJSON(id, roleId);
     System.out.println(json);
     ServiceUtils.writer(writer, json);
   }
   
   protected GenericManager<ManagerRole, Long> getManager()
   {
     return this.roleService;
   }
   
   protected void setListCommonModel(Model model) {}
   
   protected void setEditCommonModel(Model model, Long id) {}
 }
