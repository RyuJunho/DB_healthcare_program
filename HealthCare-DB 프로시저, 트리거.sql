SELECT DISTINCT 질환.질환명
FROM 질환, 회원수치
WHERE 질환.조사항목 = 회원수치.조사항목 AND
      회원수치.ID = '1' AND
      회원수치.이상유무 = '1' AND
      회원수치.검사날짜 = '2022/11/25';

-- User_suspected_disease 프로시저 : 이상 수치에 따라 의심되는 질병을 알려주는 프로시저
-- 구현 미완료
create or replace NONEDITIONABLE PROCEDURE USER_suspected_disease(
    Pi_조사항목 IN 질환.조사항목%TYPE,
    Po_의심질환 OUT 질환.질환명%TYPE)
AS
BEGIN
    select 질환명 INTO Po_의심질환
    from 질환
    where 조사항목 = Pi_조사항목
    group by 질환명;
END;


-- User_avg 프로시저 : 회원 수치의 평균을 계산하는 프로시저
-- 조사항목별 수치값의 평균
CREATE OR REPLACE PROCEDURE User_avg (
    Pi_ID IN NUMBER,
    Pi_조사항목 IN NCHAR,
    Po_평균값 OUT NUMBER )
AS
BEGIN
    SELECT AVG(수치값) INTO Po_평균값
    FROM (  SELECT 수치값
            FROM 회원수치
            WHERE ID = Pi_ID AND
                  조사항목 = Pi_조사항목 );
END;

-- User_normal 프로시저 : 회원 수치를 정상 범위(최소정상값~최고정상값)와 비교해 
--                       정상인지 이상인지 확인하는 기능을 수행하는 프로시저

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE User_normal(
    Pi_조사항목 IN NCHAR,
    Pi_성별값 IN NCHAR,
    Pi_수치값 IN NUMBER,
    Po_이상유무 OUT CHAR )
AS
    V_최소정상값 NUMBER(10);
    V_최고정상값 NUMBER(10);
BEGIN
    SELECT 최소정상값 INTO V_최소정상값
    FROM 질환
    WHERE 조사항목 = Pi_조사항목 AND
          성별값 = Pi_성별값;
    SELECT 최고정상값 INTO V_최고정상값
    FROM 질환
    WHERE 조사항목 = Pi_조사항목 AND
          성별값 = Pi_성별값;
    IF V_최소정상값 IS NULL THEN -- 최소/최고 정상값이 NULL일 경우
        BEGIN
            V_최소정상값 := 0;
        END;
    END IF;
    IF V_최고정상값 IS NULL THEN
        BEGIN
            V_최고정상값 := 1000;
        END;
    END IF;
    IF Pi_수치값 >= V_최소정상값 AND Pi_수치값 <= V_최고정상값 THEN -- 정상수치
        BEGIN
            Po_이상유무 := '0';
        END;
    ELSE    -- 이상수치
        BEGIN
            Po_이상유무 := '1';
        END;
    END IF;
END;

-- User_data_insert 트리거 : 회원수치 테이블에 데이터가 INSERT 됐을 때 
--                          User_normal 프로시저를 호출하는 트리거
CREATE OR REPLACE TRIGGER User_data_insert
    BEFORE INSERT
    ON 회원수치
    FOR EACH ROW
DECLARE
    V_이상유무 CHAR(1);
BEGIN
    User_normal(:NEW.조사항목, :NEW.성별값, :NEW.수치값, V_이상유무);
    :NEW.이상유무 := V_이상유무;
END;


-- User_delete 트리거 : 회원 테이블에 데이터가 DELETE 되면 회원수치 테이블의 데이터도 삭제
CREATE OR REPLACE TRIGGER User_delete
    AFTER DELETE
    ON 회원
    FOR EACH ROW
DECLARE
    --변수 선언부
BEGIN
    DELETE FROM 회원수치 WHERE ID = :OLD.ID;
END;
















