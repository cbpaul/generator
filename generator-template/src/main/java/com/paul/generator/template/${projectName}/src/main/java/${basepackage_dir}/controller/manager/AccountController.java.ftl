 package ${basepackage}.controller.manager;
 
 import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ${basepackage}.entity.Manager;
import ${basepackage}.service.manager.ManagerService;
import ${basepackage}.utils.ObjectUtils;
import ${basepackage}.utils.RequestUtils;
 
 @Controller
 public class AccountController
 {
   @Autowired
   private ManagerService managerService;
   @Autowired
   private ObjectMapper objectMapper;
   
   @RequestMapping(value={"login"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
   public String managerlogin(String account, String password, Integer remember, HttpServletRequest request, HttpServletResponse response, Model mav)
   {
     if (ObjectUtils.anyIsEmpty(new Object[] { account, password }))
     {
       mav.addAttribute("error", "登陆名和密码必须输入。");
       return null;
     }
     Manager manager = this.managerService.login(account, password, mav);
     Object uid = null;
     Long roleId = null;
     boolean isMerchant = false;
     if (manager == null)
     {
       mav.addAttribute("account", account);
       mav.addAttribute("password", password);
       mav.addAttribute("remember", Integer.valueOf(1));
       mav.addAttribute("error", "账号不存在");
       return "manager/login";
     }
     uid = manager.getId();
     roleId = manager.getRole().getId();
     isMerchant = false;
     if ((remember != null) && (remember.intValue() == 1))
     {
       RequestUtils.setCookie(response, "account", account, "account");
       RequestUtils.setCookie(response, "password", password, "account");
     }
     else
     {
       RequestUtils.deleteCookie(response, RequestUtils.getCookie(request, "account"), "account");
       RequestUtils.deleteCookie(response, RequestUtils.getCookie(request, "password"), "account");
     }
     HttpSession session = request.getSession();
     session.setAttribute("sessionUid", uid);
     session.setAttribute("sessionUSER", account);
     session.setAttribute("roleId", roleId);
     session.setAttribute("ismerchant", Boolean.valueOf(isMerchant));
     return "redirect:/";
   }
   
   @RequestMapping({"logout"})
   public String logout(HttpSession session)
   {
     session.invalidate();
     return "redirect:/";
   }
 }
