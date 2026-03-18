package com.kkk.schedulepms.schedule.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kkk.schedulepms.schedule.service.ScheduleService;
import com.kkk.schedulepms.schedule.service.ScheduleVO;
import com.kkk.schedulepms.schedule.service.UserVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

    @Resource(name = "scheduleService")
    private ScheduleService scheduleService;

    @org.springframework.beans.factory.annotation.Value("${schedule.kakao.api.key}")
    private String kakaoApiKey;

    @org.springframework.beans.factory.annotation.Value("${schedule.vworld.api.key}")
    private String vworldApiKey;
    // ----- HTML View Mappings -----
    
    @RequestMapping(value = "/main.do", method = RequestMethod.GET)
    public String mainView(ModelMap model) throws Exception {
        return "schedule/main";
    }

    @RequestMapping(value = "/list.do", method = RequestMethod.GET)
    public String listView(ModelMap model) throws Exception {
        return "schedule/list";
    }

    @RequestMapping(value = "/detail.do", method = RequestMethod.GET)
    public String detailView(@ModelAttribute("searchVO") ScheduleVO searchVO, ModelMap model) throws Exception {
        model.addAttribute("kakaoApiKey", kakaoApiKey);
        model.addAttribute("vworldApiKey", vworldApiKey);
        model.addAttribute("scheduleSn", searchVO.getScheduleSn());
        return "schedule/detail";
    }

    @RequestMapping(value = "/insert.do", method = RequestMethod.GET)
    public String insertView(ModelMap model) throws Exception {
        model.addAttribute("kakaoApiKey", kakaoApiKey);
        return "schedule/insert";
    }

    @RequestMapping(value = "/update.do", method = RequestMethod.GET)
    public String updateView(@ModelAttribute("searchVO") ScheduleVO searchVO, ModelMap model) throws Exception {
        model.addAttribute("kakaoApiKey", kakaoApiKey);
        model.addAttribute("scheduleSn", searchVO.getScheduleSn());
        return "schedule/update";
    }

    @RequestMapping(value = "/map.do", method = RequestMethod.GET)
    public String mapView(ModelMap model) throws Exception {
        model.addAttribute("kakaoApiKey", kakaoApiKey);
        model.addAttribute("vworldApiKey", vworldApiKey);
        return "schedule/map";
    }

    // ----- API Mappings -----
    
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectScheduleList(@ModelAttribute("searchVO") ScheduleVO searchVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<ScheduleVO> list = scheduleService.selectScheduleList(searchVO);
        resultMap.put("resultList", list);
        return resultMap;
    }

    @RequestMapping(value = "/map/data", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectScheduleMapList(@org.springframework.web.bind.annotation.RequestParam("searchMonth") String searchMonth) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        ScheduleVO searchVO = new ScheduleVO();
        searchVO.setSearchMonth(searchMonth); // Used solely for this mapping
        List<ScheduleVO> list = scheduleService.selectScheduleMapList(searchVO);
        resultMap.put("resultList", list);
        return resultMap;
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectScheduleDetail(@PathVariable("id") Integer id, @ModelAttribute("searchVO") ScheduleVO searchVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        searchVO.setScheduleSn(id);
        ScheduleVO result = scheduleService.selectSchedule(searchVO);
        resultMap.put("result", result);
        return resultMap;
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertSchedule(MultipartHttpServletRequest multiRequest, @ModelAttribute("scheduleVO") ScheduleVO scheduleVO, HttpSession session) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        
        UserVO userInfo = (UserVO) session.getAttribute("userInfo");
        if(userInfo != null) {
            scheduleVO.setRegistId(userInfo.getUsrId());
        } else {
            scheduleVO.setRegistId("SYSTEM");
        }
        
        Map<String, MultipartFile> files = multiRequest.getFileMap();
        MultipartFile file = files.get("attachFile");
        if (file != null && !file.isEmpty()) {
            scheduleVO.setScheduleFileNm(file.getOriginalFilename());
            scheduleVO.setScheduleFileOrgNm(file.getOriginalFilename());
            scheduleVO.setScheduleFilePath("/upload/" + file.getOriginalFilename());
        }

         scheduleService.insertSchedule(scheduleVO);
        resultMap.put("success", true);
        return resultMap;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateSchedule(MultipartHttpServletRequest multiRequest, @ModelAttribute("scheduleVO") ScheduleVO scheduleVO, HttpSession session) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        
        UserVO userInfo = (UserVO) session.getAttribute("userInfo");
        if(userInfo != null) {
            scheduleVO.setUpdateId(userInfo.getUsrId());
        } else {
            scheduleVO.setUpdateId("SYSTEM");
        }
        
        Map<String, MultipartFile> files = multiRequest.getFileMap();
        MultipartFile file = files.get("attachFile");
        if (file != null && !file.isEmpty()) {
            scheduleVO.setScheduleFileNm(file.getOriginalFilename());
            scheduleVO.setScheduleFileOrgNm(file.getOriginalFilename());
            scheduleVO.setScheduleFilePath("/upload/" + file.getOriginalFilename());
        }

        scheduleService.updateSchedule(scheduleVO);
        resultMap.put("success", true);
        return resultMap;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteSchedule(@ModelAttribute("scheduleVO") ScheduleVO scheduleVO) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        scheduleService.deleteSchedule(scheduleVO);
        resultMap.put("success", true);
        return resultMap;
    }
}
