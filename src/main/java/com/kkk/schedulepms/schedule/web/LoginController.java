package com.kkk.schedulepms.schedule.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kkk.schedulepms.schedule.service.ScheduleService;
import com.kkk.schedulepms.schedule.service.UserVO;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Resource(name = "scheduleService")
    private ScheduleService scheduleService;

    @RequestMapping(value = "/view.do", method = RequestMethod.GET)
    public String loginView(ModelMap model) throws Exception {
        return "schedule/login";
    }
    
    @RequestMapping(value = "/join.do", method = RequestMethod.GET)
    public String joinView(ModelMap model) throws Exception {
        return "schedule/join"; 
    }

    @RequestMapping(value = "/action.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> loginAction(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        
        // Hash password with SHA-256 before DB lookup
         if (userVO.getUsrPwd() != null && !userVO.getUsrPwd().isEmpty()) {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            md.update(userVO.getUsrPwd().getBytes());
            byte[] byteData = md.digest();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
            userVO.setUsrPwd(sb.toString());
        }
        
        // Use scheduleService or userService to query user info
        UserVO resultVO = scheduleService.selectUser(userVO);

        if (resultVO != null) {
            request.getSession().setAttribute("userInfo", resultVO);
            resultMap.put("success", true);
        } else {
            resultMap.put("success", false);
            resultMap.put("message", "Invalid credentials or unapproved user.");
        }
        
        return resultMap;
    }
    
    @RequestMapping(value = "/logout.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String logout(HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        if(session != null) {
            session.invalidate();
        }
        return "redirect:/login/view.do";
    }

    // 아이디 중복확인
    @RequestMapping(value = "/checkId.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checkId(@ModelAttribute("userVO") UserVO userVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int count = scheduleService.checkUserId(userVO.getUsrId());
        resultMap.put("isDuplicated", count > 0);
        return resultMap;
    }
    
    // 회원 가입 처리
    @RequestMapping(value = "/register.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> registerUser(@ModelAttribute("userVO") UserVO userVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        scheduleService.insertUser(userVO);
        resultMap.put("success", true);
        return resultMap;
    }
}
