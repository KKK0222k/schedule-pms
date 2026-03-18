-- User Table
CREATE TABLE "USER" (
    USR_ID VARCHAR2(50) PRIMARY KEY, -- 아이디
    USR_PWD VARCHAR2(100),           -- SHA-256 암호화
    EMAIL VARCHAR2(100),             -- 이메일
    AUTH_CD VARCHAR2(10),            -- 권한 코드(AUTH001 관리자, AUTH002 일반사용자)
    REGIST_DE DATE                   -- 등록일
);

-- Schedule Table
CREATE TABLE SCHEDULE (
    SCHEDULE_SN NUMBER(10) PRIMARY KEY,       -- PK (일련번호)
    SCHEDULE_NM VARCHAR2(100),                -- 일정명
    SCHEDULE_CN VARCHAR2(2000),               -- 일정내용
    SCHEDULE_START_DE DATE,                   -- 시작일
    SCHEDULE_END_DE DATE,                     -- 종료일
    SCHEDULE_FILE_PATH VARCHAR2(200),         -- 파일 경로
    SCHEDULE_FILE_NM VARCHAR2(200),           -- 서버 저장 파일명
    SCHEDULE_FILE_ORG_NM VARCHAR2(200),       -- 원본 파일명
    REGIST_DE DATE,                           -- 등록일
    REGIST_ID VARCHAR2(50),                   -- 등록자
    UPDATE_DE DATE,                           -- 수정일
    UPDATE_ID VARCHAR2(50)                    -- 수정자
);

-- Sequence for Schedule SN
CREATE SEQUENCE SEQ_SCHEDULE_SN
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
