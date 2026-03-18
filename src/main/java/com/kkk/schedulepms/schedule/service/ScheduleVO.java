package com.kkk.schedulepms.schedule.service;

import java.io.Serializable;
import java.util.Date;

public class ScheduleVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer scheduleSn;
    private String scheduleNm;
    private String scheduleCn;
    private String scheduleAdres;
    private Double locLon;
    private Double locLat;
    private String scheduleStartDe;  // Using String to easily map from datepicker (YYYY-MM-DD)
    private String scheduleEndDe;    // Using String for dates from UI
    private String scheduleFilePath;
    private String scheduleFileNm;
    private String scheduleFileOrgNm;
    private Date registDe;
    private String registId;
    private Date updateDe;
    private String updateId;
    private String searchMonth;

    public Integer getScheduleSn() { return scheduleSn; }
    public void setScheduleSn(Integer scheduleSn) { this.scheduleSn = scheduleSn; }

    public String getScheduleNm() { return scheduleNm; }
    public void setScheduleNm(String scheduleNm) { this.scheduleNm = scheduleNm; }

    public String getScheduleCn() { return scheduleCn; }
    public void setScheduleCn(String scheduleCn) { this.scheduleCn = scheduleCn; }

    public String getScheduleAdres() { return scheduleAdres; }
    public void setScheduleAdres(String scheduleAdres) { this.scheduleAdres = scheduleAdres; }

    public Double getLocLon() { return locLon; }
    public void setLocLon(Double locLon) { this.locLon = locLon; }

    public Double getLocLat() { return locLat; }
    public void setLocLat(Double locLat) { this.locLat = locLat; }

    public String getScheduleStartDe() { return scheduleStartDe; }
    public void setScheduleStartDe(String scheduleStartDe) { this.scheduleStartDe = scheduleStartDe; }

    public String getScheduleEndDe() { return scheduleEndDe; }
    public void setScheduleEndDe(String scheduleEndDe) { this.scheduleEndDe = scheduleEndDe; }

    public String getScheduleFilePath() { return scheduleFilePath; }
    public void setScheduleFilePath(String scheduleFilePath) { this.scheduleFilePath = scheduleFilePath; }

    public String getScheduleFileNm() { return scheduleFileNm; }
    public void setScheduleFileNm(String scheduleFileNm) { this.scheduleFileNm = scheduleFileNm; }

    public String getScheduleFileOrgNm() { return scheduleFileOrgNm; }
    public void setScheduleFileOrgNm(String scheduleFileOrgNm) { this.scheduleFileOrgNm = scheduleFileOrgNm; }

    public String getSearchMonth() { return searchMonth; }
    public void setSearchMonth(String searchMonth) { this.searchMonth = searchMonth; }

    public Date getRegistDe() { return registDe; }
    public void setRegistDe(Date registDe) { this.registDe = registDe; }

    public String getRegistId() { return registId; }
    public void setRegistId(String registId) { this.registId = registId; }

    public Date getUpdateDe() { return updateDe; }
    public void setUpdateDe(Date updateDe) { this.updateDe = updateDe; }

    public String getUpdateId() { return updateId; }
    public void setUpdateId(String updateId) { this.updateId = updateId; }

}
