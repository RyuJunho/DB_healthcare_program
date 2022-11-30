----------------------------------------------------------------
------------ 사용자 생성 ------------ 
----------------------------------------------------------------
/* ########  ID : SYSTEM ######## */

ALTER session set "_ORACLE_SCRIPT"=true;
DROP USER health CASCADE; -- 기존 사용자 삭제(현재 접속되어 있으면 삭제 안 됨)
	-- CASCADE option : 관련 스키마 개체들도 함께 삭제.  Default는 No Action
CREATE USER health IDENTIFIED BY 1234  -- 사용자 ID : health, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba TO health; -- 권한 부여

-----------------------------------------------
----------------- 테이블 생성 ------------------
-----------------------------------------------
/*############ ID : health #############*/

CREATE TABLE 회원(
    ID NUMBER(10) PRIMARY KEY,
    PW VARCHAR(20) NOT NULL,
	이름	NCHAR(5) NOT NULL,
	주민등록번호 NCHAR(20) NOT NULL,
	성별	NCHAR(3) NOT NULL
);

CREATE TABLE 질환(
    검진항목 NCHAR(20) NOT NULL,
    질환명 NCHAR(20) NOT NULL,
    조사항목 NCHAR(20) NOT NULL,
    성별값 NCHAR(3) NOT NULL,
    최소정상값 NUMBER(10),
    최고정상값 NUMBER(10),
    CONSTRAINT 질환_PK PRIMARY KEY(조사항목,성별값)
);

CREATE TABLE 회원수치(
    검사날짜 DATE,
    ID NUMBER(10),
    조사항목 NCHAR(20),
    성별값 NCHAR(3),
    수치값 NUMBER(10,2),   -- 실수값 넣기 위해 (10,2)로 수정 (소수점 둘째자리까지)
    이상유무 CHAR(1) CHECK(이상유무 IN ('0','1')),  --오라클에선 BOOLEAN이 없어 0과 1로 표현
    FOREIGN KEY (ID) REFERENCES 회원(ID),
    FOREIGN KEY (조사항목,성별값) REFERENCES 질환(조사항목,성별값),
    CONSTRAINT 회원수치_PK PRIMARY KEY(검사날짜,ID,조사항목,성별값)
);

-----------------------------------------------
----------------- 데이터 입력 ------------------
-----------------------------------------------

-- 회원(ID, PW, 이름, 주민등록번호, 성별)
INSERT INTO 회원 VALUES(1,'1111','정가영','011029-1111111','여');
INSERT INTO 회원 VALUES(2,'2222','류준호','222222-2222222','남');
INSERT INTO 회원 VALUES(3,'3333','윤대호','333333-3333333','남');


-- 질환(검진항목, 질환명, 조사항목, 성별값, 최소정상값, 최고정상값)
-- 남녀 성별따라 정상값이 나뉘는 것은 '남'/'여' 이외 '공통'
INSERT INTO 질환 VALUES('계측 검사','비만','신장','공통',NULL,NULL);
INSERT INTO 질환 VALUES('계측 검사','비만','체중','공통',NULL,NULL);
INSERT INTO 질환 VALUES('계측 검사','비만','허리둘레','남',NULL,90);
INSERT INTO 질환 VALUES('계측 검사','비만','허리둘레','여',NULL,85);
INSERT INTO 질환 VALUES('계측 검사','비만','체질량지수','공통',18.5,24.9);
INSERT INTO 질환 VALUES('계측 검사','시각 이상','시력(좌)','공통',NULL,NULL);
INSERT INTO 질환 VALUES('계측 검사','시각 이상','시력(우)','공통',NULL,NULL);
INSERT INTO 질환 VALUES('계측 검사','청력 이상','청력(좌)','공통',NULL,NULL);
INSERT INTO 질환 VALUES('계측 검사','청력 이상','청력(우)','공통',NULL,NULL);
INSERT INTO 질환 VALUES('계측 검사','고혈압','혈압','공통',80,120);
INSERT INTO 질환 VALUES('요검사','신장질환','요단백','공통',NULL,NULL);
INSERT INTO 질환 VALUES('혈액검사','빈혈','혈색소','남',13,16.5);
INSERT INTO 질환 VALUES('혈액검사','빈혈','혈색소','여',12,15.5);
INSERT INTO 질환 VALUES('혈액검사','당뇨병','식전혈당','공통',NULL,100);
INSERT INTO 질환 VALUES('혈액검사','고혈압이상지질혈증동맥경화','총콜레스테롤','공통',NULL,200);
INSERT INTO 질환 VALUES('혈액검사','고혈압이상지질혈증동맥경화','HDL-콜레스테롤','공통',60,NULL);
INSERT INTO 질환 VALUES('혈액검사','고혈압이상지질혈증동맥경화','트리글리세라이드','공통',100,150);
INSERT INTO 질환 VALUES('혈액검사','고혈압이상지질혈증동맥경화','LDL-콜레스테롤','공통',NULL,100);
INSERT INTO 질환 VALUES('혈액검사','만성신장질환','혈청크레아티닌','공통',NULL,1.5);
INSERT INTO 질환 VALUES('혈액검사','간장질환','AST(SGOT)','공통',NULL,40);
INSERT INTO 질환 VALUES('혈액검사','간장질환','ALT(SGPT)','공통',NULL,35);
INSERT INTO 질환 VALUES('혈액검사','간장질환','감마지티피(y-GTP)','남',11,63);
INSERT INTO 질환 VALUES('혈액검사','간장질환','감마지티피(y-GTP)','여',8,35);
INSERT INTO 질환 VALUES('혈액검사','간장질환','B형간염항원','공통',NULL,NULL);
INSERT INTO 질환 VALUES('혈액검사','간장질환','B형간염항체','공통',NULL,NULL);
INSERT INTO 질환 VALUES('혈액검사','간장질환','감염검사결과','공통',NULL,NULL);
INSERT INTO 질환 VALUES('영상검사','폐결핵흉부질환','흉부방사선검사','공통',NULL,NULL);


-- 회원수치(검사날짜, ID, 조사항목, 성별값, 수치값, 이상유무)
-- 질환에 (조사항목, 성별값) 값이 있어야 됨
-- 이상유무는 NULL : 이상X(정상) NULL : 이상
ALTER session set NLS_DATE_FORMAT = 'YYYY/MM/DD'; --날짜만 넣도록 DATE 포맷 변경
INSERT INTO 회원수치 VALUES('2022/11/25',1,'신장','공통',170,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'체중','공통',52,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'허리둘레','여',70,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'체질량지수','공통',20,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'시력(좌)','공통',0.8,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'시력(우)','공통',0.8,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'청력(좌)','공통',80,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'청력(우)','공통',100,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'혈압','공통',75,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'요단백','공통',50,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'혈색소','여',10,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'식전혈당','공통',90,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'총콜레스테롤','공통',150,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'HDL-콜레스테롤','공통',80,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'트리글리세라이드','공통',140,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'LDL-콜레스테롤','공통',100,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'혈청크레아티닌','공통',1.2,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'AST(SGOT)','공통',50,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'ALT(SGPT)','공통',40,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'감마지티피(y-GTP)','여',30,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'B형간염항원','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'B형간염항체','공통',2.1,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'감염검사결과','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',1,'흉부방사선검사','공통',1,NULL);

INSERT INTO 회원수치 VALUES('2023/10/25',1,'신장','공통',170,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'체중','공통',58,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'허리둘레','여',77,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'체질량지수','공통',23,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'시력(좌)','공통',0.8,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'시력(우)','공통',0.8,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'청력(좌)','공통',85,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'청력(우)','공통',100,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'혈압','공통',70,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'요단백','공통',45,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'혈색소','여',9.5,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'식전혈당','공통',95,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'총콜레스테롤','공통',155,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'HDL-콜레스테롤','공통',83,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'트리글리세라이드','공통',135,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'LDL-콜레스테롤','공통',105,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'혈청크레아티닌','공통',1.2,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'AST(SGOT)','공통',40,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'ALT(SGPT)','공통',35,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'감마지티피(y-GTP)','여',30,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'B형간염항원','공통',1.3,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'B형간염항체','공통',2.5,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'감염검사결과','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2023/10/25',1,'흉부방사선검사','공통',1.5,NULL);

INSERT INTO 회원수치 VALUES('2024/12/25',1,'신장','공통',170,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'체중','공통',55,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'허리둘레','여',75,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'체질량지수','공통',22,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'시력(좌)','공통',0.7,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'시력(우)','공통',0.7,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'청력(좌)','공통',90,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'청력(우)','공통',95,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'혈압','공통',75,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'요단백','공통',48,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'혈색소','여',12,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'식전혈당','공통',87,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'총콜레스테롤','공통',132,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'HDL-콜레스테롤','공통',73,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'트리글리세라이드','공통',111,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'LDL-콜레스테롤','공통',115,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'혈청크레아티닌','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'AST(SGOT)','공통',40,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'ALT(SGPT)','공통',35,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'감마지티피(y-GTP)','여',30,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'B형간염항원','공통',1.4,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'B형간염항체','공통',2.6,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'감염검사결과','공통',1.3,NULL);
INSERT INTO 회원수치 VALUES('2024/12/25',1,'흉부방사선검사','공통',1.0,NULL);


INSERT INTO 회원수치 VALUES('2025/12/12',1,'신장','공통',170,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'체중','공통',69,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'허리둘레','여',76,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'체질량지수','공통',20.2,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'시력(좌)','공통',0.7,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'시력(우)','공통',0.7,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'청력(좌)','공통',93,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'청력(우)','공통',91,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'혈압','공통',85,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'요단백','공통',49,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'혈색소','여',12,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'식전혈당','공통',102,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'총콜레스테롤','공통',189,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'HDL-콜레스테롤','공통',61,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'트리글리세라이드','공통',153,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'LDL-콜레스테롤','공통',95,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'혈청크레아티닌','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'AST(SGOT)','공통',35,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'ALT(SGPT)','공통',32,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'감마지티피(y-GTP)','여',37,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'B형간염항원','공통',1.2,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'B형간염항체','공통',2.6,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'감염검사결과','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2025/12/12',1,'흉부방사선검사','공통',1.1,NULL);

INSERT INTO 회원수치 VALUES('2026/10/12',1,'신장','공통',171,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'체중','공통',73,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'허리둘레','여',86,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'체질량지수','공통',25,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'시력(좌)','공통',0.7,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'시력(우)','공통',0.7,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'청력(좌)','공통',93,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'청력(우)','공통',93,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'혈압','공통',88,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'요단백','공통',43,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'혈색소','여',13,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'식전혈당','공통',105,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'총콜레스테롤','공통',202,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'HDL-콜레스테롤','공통',67,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'트리글리세라이드','공통',153,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'LDL-콜레스테롤','공통',102,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'혈청크레아티닌','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'AST(SGOT)','공통',32,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'ALT(SGPT)','공통',28,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'감마지티피(y-GTP)','여',29,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'B형간염항원','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'B형간염항체','공통',2.6,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'감염검사결과','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2026/10/12',1,'흉부방사선검사','공통',1.1,NULL);



INSERT INTO 회원수치 VALUES('2022/11/25',2,'신장','공통',178,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'체중','공통',75,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'허리둘레','남',80,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'체질량지수','공통',20,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'시력(좌)','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'시력(우)','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'청력(좌)','공통',100,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'청력(우)','공통',100,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'혈압','공통',125,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'요단백','공통',60,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'혈색소','남',16,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'식전혈당','공통',90,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'총콜레스테롤','공통',155,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'HDL-콜레스테롤','공통',90,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'트리글리세라이드','공통',142,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'LDL-콜레스테롤','공통',50,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'혈청크레아티닌','공통',1.8,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'AST(SGOT)','공통',30,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'ALT(SGPT)','공통',40,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'감마지티피(y-GTP)','남',34,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'B형간염항원','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'B형간염항체','공통',2.6,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'감염검사결과','공통',1.1,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',2,'흉부방사선검사','공통',2.3,NULL);

INSERT INTO 회원수치 VALUES('2023/11/23',2,'신장','공통',178,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'체중','공통',70,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'허리둘레','남',77,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'체질량지수','공통',18,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'시력(좌)','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'시력(우)','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'청력(좌)','공통',110,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'청력(우)','공통',103,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'혈압','공통',115,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'요단백','공통',62,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'혈색소','남',16.9,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'식전혈당','공통',85,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'총콜레스테롤','공통',132,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'HDL-콜레스테롤','공통',100,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'트리글리세라이드','공통',121,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'LDL-콜레스테롤','공통',95,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'혈청크레아티닌','공통',2.3,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'AST(SGOT)','공통',21,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'ALT(SGPT)','공통',40,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'감마지티피(y-GTP)','남',45,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'B형간염항원','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'B형간염항체','공통',3.9,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'감염검사결과','공통',3.5,NULL);
INSERT INTO 회원수치 VALUES('2023/11/23',2,'흉부방사선검사','공통',2.2,NULL);


INSERT INTO 회원수치 VALUES('2024/10/23',2,'신장','공통',178,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'체중','공통',82,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'허리둘레','남',88,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'체질량지수','공통',25,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'시력(좌)','공통',1.1,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'시력(우)','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'청력(좌)','공통',110,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'청력(우)','공통',103,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'혈압','공통',121,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'요단백','공통',60,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'혈색소','남',18,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'식전혈당','공통',99,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'총콜레스테롤','공통',132,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'HDL-콜레스테롤','공통',100,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'트리글리세라이드','공통',146,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'LDL-콜레스테롤','공통',98,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'혈청크레아티닌','공통',2.3,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'AST(SGOT)','공통',35,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'ALT(SGPT)','공통',40,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'감마지티피(y-GTP)','남',40,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'B형간염항원','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'B형간염항체','공통',3.2,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'감염검사결과','공통',3.5,NULL);
INSERT INTO 회원수치 VALUES('2024/10/23',2,'흉부방사선검사','공통',2.3,NULL);


INSERT INTO 회원수치 VALUES('2025/10/10',2,'신장','공통',178,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'체중','공통',80,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'허리둘레','남',86,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'체질량지수','공통',23,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'시력(좌)','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'시력(우)','공통',1.0,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'청력(좌)','공통',105,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'청력(우)','공통',106,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'혈압','공통',111,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'요단백','공통',60,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'혈색소','남',18,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'식전혈당','공통',95,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'총콜레스테롤','공통',165,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'HDL-콜레스테롤','공통',123,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'트리글리세라이드','공통',140,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'LDL-콜레스테롤','공통',87,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'혈청크레아티닌','공통',2.5,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'AST(SGOT)','공통',32,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'ALT(SGPT)','공통',43,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'감마지티피(y-GTP)','남',65,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'B형간염항원','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'B형간염항체','공통',3.5,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'감염검사결과','공통',3.5,NULL);
INSERT INTO 회원수치 VALUES('2025/10/10',2,'흉부방사선검사','공통',3.9,NULL);


INSERT INTO 회원수치 VALUES('2026/12/10',2,'신장','공통',178,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'체중','공통',87,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'허리둘레','남',95,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'체질량지수','공통',28,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'시력(좌)','공통',0.9,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'시력(우)','공통',1.1,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'청력(좌)','공통',110,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'청력(우)','공통',110,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'혈압','공통',135,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'요단백','공통',60,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'혈색소','남',18,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'식전혈당','공통',123,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'총콜레스테롤','공통',232,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'HDL-콜레스테롤','공통',123,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'트리글리세라이드','공통',153,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'LDL-콜레스테롤','공통',101,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'혈청크레아티닌','공통',2.5,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'AST(SGOT)','공통',32,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'ALT(SGPT)','공통',48,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'감마지티피(y-GTP)','남',65,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'B형간염항원','공통',3.0,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'B형간염항체','공통',3.5,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'감염검사결과','공통',3.1,NULL);
INSERT INTO 회원수치 VALUES('2026/12/10',2,'흉부방사선검사','공통',4.5,NULL);


INSERT INTO 회원수치 VALUES('2022/11/25',3,'신장','공통',175,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'체중','공통',65,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'허리둘레','남',70,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'체질량지수','공통',21.5,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'시력(좌)','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'시력(우)','공통',1.6,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'청력(좌)','공통',120,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'청력(우)','공통',110,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'혈압','공통',140,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'요단백','공통',30,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'혈색소','남',16.3,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'식전혈당','공통',80,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'총콜레스테롤','공통',155,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'HDL-콜레스테롤','공통',62,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'트리글리세라이드','공통',111,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'LDL-콜레스테롤','공통',32,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'혈청크레아티닌','공통',1.3,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'AST(SGOT)','공통',45,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'ALT(SGPT)','공통',40,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'감마지티피(y-GTP)','남',34,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'B형간염항원','공통',5,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'B형간염항체','공통',4.2,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'감염검사결과','공통',3.5,NULL);
INSERT INTO 회원수치 VALUES('2022/11/25',3,'흉부방사선검사','공통',2.3,NULL);


INSERT INTO 회원수치 VALUES('2023/09/25',3,'신장','공통',175,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'체중','공통',68,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'허리둘레','남',72,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'체질량지수','공통',21.6,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'시력(좌)','공통',1.6,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'시력(우)','공통',1.6,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'청력(좌)','공통',125,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'청력(우)','공통',112,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'혈압','공통',145,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'요단백','공통',60,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'혈색소','남',20,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'식전혈당','공통',120,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'총콜레스테롤','공통',112,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'HDL-콜레스테롤','공통',62,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'트리글리세라이드','공통',111,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'LDL-콜레스테롤','공통',32,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'혈청크레아티닌','공통',1.9,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'AST(SGOT)','공통',80,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'ALT(SGPT)','공통',20,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'감마지티피(y-GTP)','남',63,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'B형간염항원','공통',9,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'B형간염항체','공통',2.1,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'감염검사결과','공통',8.5,NULL);
INSERT INTO 회원수치 VALUES('2023/09/25',3,'흉부방사선검사','공통',2.1,NULL);


INSERT INTO 회원수치 VALUES('2024/09/15',3,'신장','공통',175,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'체중','공통',63,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'허리둘레','남',68,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'체질량지수','공통',17,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'시력(좌)','공통',1.6,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'시력(우)','공통',1.6,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'청력(좌)','공통',133,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'청력(우)','공통',118,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'혈압','공통',110,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'요단백','공통',30,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'혈색소','남',13,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'식전혈당','공통',81,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'총콜레스테롤','공통',89,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'HDL-콜레스테롤','공통',62,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'트리글리세라이드','공통',111,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'LDL-콜레스테롤','공통',91,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'혈청크레아티닌','공통',0.5,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'AST(SGOT)','공통',29,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'ALT(SGPT)','공통',20,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'감마지티피(y-GTP)','남',63,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'B형간염항원','공통',3,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'B형간염항체','공통',5,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'감염검사결과','공통',3.2,NULL);
INSERT INTO 회원수치 VALUES('2024/09/15',3,'흉부방사선검사','공통',5.3,NULL);


INSERT INTO 회원수치 VALUES('2025/12/15',3,'신장','공통',175,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'체중','공통',70,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'허리둘레','남',75,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'체질량지수','공통',20.3,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'시력(좌)','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'시력(우)','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'청력(좌)','공통',140,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'청력(우)','공통',120,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'혈압','공통',113,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'요단백','공통',90,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'혈색소','남',18,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'식전혈당','공통',132,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'총콜레스테롤','공통',165,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'HDL-콜레스테롤','공통',92,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'트리글리세라이드','공통',161,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'LDL-콜레스테롤','공통',132,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'혈청크레아티닌','공통',0.5,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'AST(SGOT)','공통',39,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'ALT(SGPT)','공통',35,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'감마지티피(y-GTP)','남',76,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'B형간염항원','공통',3,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'B형간염항체','공통',5.3,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'감염검사결과','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2025/12/15',3,'흉부방사선검사','공통',6.3,NULL);


INSERT INTO 회원수치 VALUES('2026/12/23',3,'신장','공통',175,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'체중','공통',64,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'허리둘레','남',71,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'체질량지수','공통',18.6,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'시력(좌)','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'시력(우)','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'청력(좌)','공통',116,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'청력(우)','공통',150,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'혈압','공통',131,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'요단백','공통',95,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'혈색소','남',14.2,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'식전혈당','공통',80,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'총콜레스테롤','공통',135,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'HDL-콜레스테롤','공통',132,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'트리글리세라이드','공통',123,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'LDL-콜레스테롤','공통',45,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'혈청크레아티닌','공통',0.6,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'AST(SGOT)','공통',50,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'ALT(SGPT)','공통',35,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'감마지티피(y-GTP)','남',32,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'B형간염항원','공통',3.3,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'B형간염항체','공통',2.3,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'감염검사결과','공통',1.5,NULL);
INSERT INTO 회원수치 VALUES('2026/12/23',3,'흉부방사선검사','공통',6.3,NULL);


COMMIT;
