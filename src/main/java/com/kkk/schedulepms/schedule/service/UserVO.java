package com.kkk.schedulepms.schedule.service;

import java.io.Serializable;
import java.util.Date;

public class UserVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String usrId;        // 아이디
    private String usrPwd;       // 패스워드
    private String email;        // 이메일
    private String authCd;       // 권한코드 (AUTH001, AUTH002)
    private Date registDe;       // 등록일

    public String getUsrId() { return usrId; }
    public void setUsrId(String usrId) { this.usrId = usrId; }

    public String getUsrPwd() { return usrPwd; }
    public void setUsrPwd(String usrPwd) { this.usrPwd = usrPwd; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAuthCd() { return authCd; }
    public void setAuthCd(String authCd) { this.authCd = authCd; }

    public Date getRegistDe() { return registDe; }
    public void setRegistDe(Date registDe) { this.registDe = registDe; }
}
