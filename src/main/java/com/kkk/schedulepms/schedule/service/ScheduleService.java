package com.kkk.schedulepms.schedule.service;

import java.util.List;

public interface ScheduleService {
    
    // Schedule Methods
    List<ScheduleVO> selectScheduleList(ScheduleVO searchVO) throws Exception;
    
    List<ScheduleVO> selectScheduleMapList(ScheduleVO searchVO) throws Exception;
    
    ScheduleVO selectSchedule(ScheduleVO searchVO) throws Exception;
    
    void insertSchedule(ScheduleVO scheduleVO) throws Exception;
    
    void updateSchedule(ScheduleVO scheduleVO) throws Exception;
    
    void deleteSchedule(ScheduleVO scheduleVO) throws Exception;

    // User Methods
    UserVO selectUser(UserVO userVO) throws Exception;
    
    int checkUserId(String usrId) throws Exception;
    
    void insertUser(UserVO userVO) throws Exception;
}
