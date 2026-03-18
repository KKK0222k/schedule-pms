package com.kkk.schedulepms.schedule.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kkk.schedulepms.schedule.service.ScheduleService;
import com.kkk.schedulepms.schedule.service.ScheduleVO;
import com.kkk.schedulepms.schedule.service.UserVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("scheduleService")
public class ScheduleServiceImpl extends EgovAbstractServiceImpl implements ScheduleService {

    @Resource(name = "scheduleMapper")
    private ScheduleMapper scheduleMapper;

    @Override
    public List<ScheduleVO> selectScheduleList(ScheduleVO searchVO) throws Exception {
        return scheduleMapper.selectScheduleList(searchVO);
    }

    @Override
    public List<ScheduleVO> selectScheduleMapList(ScheduleVO searchVO) throws Exception {
        return scheduleMapper.selectScheduleMapList(searchVO);
    }

    @Override
    public ScheduleVO selectSchedule(ScheduleVO searchVO) throws Exception {
        return scheduleMapper.selectScheduleDetail(searchVO);
    }

    @Override
    public void insertSchedule(ScheduleVO scheduleVO) throws Exception {
        scheduleMapper.insertSchedule(scheduleVO);
    }

    @Override
    public void updateSchedule(ScheduleVO scheduleVO) throws Exception {
        scheduleMapper.updateSchedule(scheduleVO);
    }

    @Override
    public void deleteSchedule(ScheduleVO scheduleVO) throws Exception {
        scheduleMapper.deleteSchedule(scheduleVO);
    }

    @Override
    public UserVO selectUser(UserVO userVO) throws Exception {
        // Here we could implement SHA-256 for userVO.getUsrPwd() before query if needed
        return scheduleMapper.selectUser(userVO);
    }

    @Override
    public int checkUserId(String usrId) throws Exception {
        return scheduleMapper.checkUserId(usrId);
    }

    @Override
    public void insertUser(UserVO userVO) throws Exception {
        // Also encrypt pwd here if doing logic in service
        scheduleMapper.insertUser(userVO);
    }
}
