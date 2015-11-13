 package ${basepackage}.controller.managerAuthority;
 
 import org.springframework.stereotype.Controller;
 import org.springframework.ui.Model;
 import org.springframework.web.bind.annotation.RequestMapping;
 
 @Controller
 @RequestMapping({"/controller/ManagerAuthority"})
 public class ManagerAuthorityController
 {
   @RequestMapping({"/list"})
   public String goAuthorityList(Model model)
   {
     return "authority/authorityList";
   }
 }
