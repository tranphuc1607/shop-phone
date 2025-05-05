package com.example.demo.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;

//import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class HeaderAdvanceController {
    @Autowired
    private  UserService userService;

    @ModelAttribute("currentUser")
   public User getCurrentUser() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    if (authentication != null && authentication.isAuthenticated()
        && !"anonymousUser".equals(authentication.getPrincipal())) {

        String userEmail = authentication.getName();

        try {
            User currentUser = userService.getUserByEmail(userEmail);
            return currentUser;
        } catch (Exception e) {
            return null;
        }

    }

    return null;
}

}
