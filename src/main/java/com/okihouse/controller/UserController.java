package com.okihouse.controller;

import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UserController {

	@RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    @RequestMapping(value = {"/error/accessdenied"}, method = RequestMethod.GET)
    public String accessdenied() {
        return "error/accessdenied";
    }

    @PreAuthorize("hasAnyAuthority('USER','ADMIN')")
    @RequestMapping(value = "/mypage", method = RequestMethod.GET)
    public String mypage(Model model, HttpServletRequest request, Authentication authentication) {
        List<String> cookies = new ArrayList<>();
        Cookie[] originCookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : originCookies) {
                cookies.add(String.format("%s=%s", cookie.getName(), cookie.getValue()));
            }
        }

        model.addAttribute("authentication", authentication);
        model.addAttribute("sessionId", request.getSession().getId());
        model.addAttribute("cookie", cookies);
        return "user/mypage";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(Model model, Authentication authentication) {
        model.addAttribute("authentication", authentication);
        return "user/admin";
    }

}
