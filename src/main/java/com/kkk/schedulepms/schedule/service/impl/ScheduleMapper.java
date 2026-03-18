package com.kkk.schedulepms.schedule.service.impl;

import java.util.List;

import com.kkk.schedulepms.schedule.service.ScheduleVO;
import com.kkk.schedulepms.schedule.service.UserVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scheduleMapper")
public interface ScheduleMapper {

    List<ScheduleVO> selectScheduleList(ScheduleVO searchVO) throws Exception;
    
    List<ScheduleVO> selectScheduleMapList(ScheduleVO searchVO) throws Exception;

    ScheduleVO selectScheduleDetail(ScheduleVO searchVO) throws Exception;

    void insertSchedule(ScheduleVO scheduleVO) throws Exception;

    void updateSchedule(ScheduleVO scheduleVO) throws Exception;

    void deleteSchedule(ScheduleVO scheduleVO) throws Exception;

    UserVO selectUser(UserVO userVO) throws Exception;

    int checkUserId(String usrId) throws Exception;

    void insertUser(UserVO userVO) throws Exception;
}
