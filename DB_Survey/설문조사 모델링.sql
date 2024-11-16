DROP TABLE tbl_user;
CREATE TABLE tbl_user (
      user_no    NUMBER(7)          NOT NULL    PRIMARY KEY
    , user_role  VARCHAR2(1)        NOT NULL    
    , id         VARCHAR2(30)       NOT NULL    CONSTRAINT uq_id     UNIQUE 
    , pw         VARCHAR2(200)      NOT NULL 
    , name       NVARCHAR2(15)      NOT NULL 
    , tel        VARCHAR2(22)       NOT NULL    CONSTRAINT uq_tel    UNIQUE
    , email      VARCHAR2(100)                  CONSTRAINT uq_email  UNIQUE
    , CONSTRAINT ck_userrole  CHECK (user_role IN ('N','Y'))
    , CONSTRAINT ck_tel       CHECK (REGEXP_LIKE  (tel, '^(010|011)\d{8}$'))
    , CONSTRAINT ck_email     CHECK (REGEXP_LIKE (email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'))
);



DROP TABLE tbl_survey;
CREATE TABLE tbl_survey (
      survey_no    NUMBER(3)                           NOT NULL    PRIMARY KEY
    , user_no      NUMBER(7)                           NOT NULL    
    , regdate      DATE            DEFAULT SYSDATE     NOT NULL    
    , start_date   DATE                                NOT NULL 
    , end_date     DATE                                NOT NULL 
    , question     NVARCHAR2(200)                      NOT NULL
    , cate_count   NUMBER(2)       DEFAULT 1           NOT NULL
    , CONSTRAINT fk_tblsurvey_userno FOREIGN KEY (user_no) REFERENCES tbl_user(user_no)
                                                           ON DELETE CASCADE
);



DROP TABLE tbl_cate;
CREATE TABLE tbl_cate (
      survey_no    NUMBER(3)         NOT NULL 
    , cate_content NVARCHAR2(200)    NOT NULL
    , cate_no      NUMBER(3)         NOT NULL    CONSTRAINT uq_cateno    UNIQUE
    , CONSTRAINT pk_tblcate PRIMARY KEY(survey_no,cate_content)
    , CONSTRAINT fk_tblcate_surveyno  FOREIGN KEY (survey_no) REFERENCES tbl_survey(survey_no)
                                                              ON DELETE CASCADE
);


DROP TABLE tbl_vote;
CREATE TABLE tbl_vote (
      survey_no    NUMBER(7)   NOT NULL   
    , user_no      NUMBER(7)   NOT NULL        
    , cate_no      NUMBER(3)   NOT NULL    
    , CONSTRAINT pk_tblvote PRIMARY KEY(survey_no,user_no)
    , CONSTRAINT fk_tblvote_surveyno   FOREIGN KEY (survey_no) REFERENCES tbl_survey(survey_no) ON DELETE CASCADE
    , CONSTRAINT fk_tblvote_userno     FOREIGN KEY (user_no)   REFERENCES tbl_user(user_no)     ON DELETE CASCADE
    , CONSTRAINT fk_tblvote_cateno     FOREIGN KEY (cate_no)   REFERENCES tbl_cate(cate_no)     ON DELETE CASCADE
);

SELECT *
FROM all_constraints
WHERE table_name = 'TBL_USER';

SELECT *
FROM all_constraints
WHERE table_name = 'TBL_SURVEY';

SELECT *
FROM all_constraints
WHERE table_name = 'TBL_CATE';

SELECT *
FROM all_constraints
WHERE table_name = 'TBL_VOTE';


--------------------------------------------------------------------------------------
-- 회원(tbl_user) INSERT
INSERT INTO tbl_user VALUES( 2309001, 'N', 'apple001', 'nonapple1', '김사과', '01055558888', 'apple001@naver.com');
INSERT INTO tbl_user VALUES( 2309002, 'N', 'hong002', 'honghong', '홍길연', '01033334455', 'hong002@gmail.com' );
INSERT INTO tbl_user VALUES( 2309003, 'N', 'lee003', 'lee004', '이순신', '01055112222', 'lee003@naver.com');
INSERT INTO tbl_user VALUES( 2309004, 'N', 'won004', 'oneone4', '원균', '01088885555', 'won004@yahoo.com');
INSERT INTO tbl_user VALUES( 2309005, 'N', 'kim005', 'sunjoe5', '김선조', '01055889449', 'kim005@daun.com');
INSERT INTO tbl_user VALUES ( 2309006, 'N', 'pro2ho1', '12346', '박정육', '01012346666','pgh230906@gmail.com');
INSERT INTO tbl_user VALUES ( 2309007, 'N', 'pro2ho2', '12347', '박정칠', '01023457777','com230907@gmail.com');
INSERT INTO tbl_user VALUES ( 2309008, 'N', 'pro2ho3', '12348', '박정팔', '01134568888','let230908@gmail.com');
INSERT INTO tbl_user VALUES ( 2309009, 'N', 'pro2ho4', '12349', '박정구', '01045679999','zxr230909@gmail.com');
INSERT INTO tbl_user VALUES ( 2309010, 'N', 'pro2ho5', '123410', '박정십', '01056781010','exp230910@gmail.com');
INSERT INTO tbl_user (user_no, user_role, id, pw, name, tel)
       VALUES (2309011, 'N', 'user11_id', 'user1_pswr', '홍길순', '01012341234');
INSERT INTO tbl_user VALUES (2309012, 'Y', 'jane_smith', 'user2_pw', 'Jane Smith', '01198761234', 'johith@example.com');
INSERT INTO tbl_user VALUES (2309013, 'N', 'john_doe', 'user3_pass', '이영수', '01055553333', 'user13@example.com');
INSERT INTO tbl_user (user_no, user_role, id, pw, name, tel)
       VALUES (2309014, 'Y', 'robert_brown', 'user4_p', 'Robert Brown', '01133332222');
INSERT INTO tbl_user VALUES (2309015, 'N', 'alice_kim', 'us', '김민지', '01099992222', 'user15@example.com');


-- 설문(tbl_survey) INSERT
INSERT INTO tbl_survey VALUES ( 1, 2309001, SYSDATE, SYSDATE, SYSDATE+1, 'TEST SURVEY TITLE1', 3);
INSERT INTO tbl_survey VALUES ( 2, 2309002, SYSDATE, SYSDATE, SYSDATE+1, 'TEST SURVEY TITLE2', 2);
INSERT INTO tbl_survey VALUES ( 3, 2309011, TO_DATE('2023-09-07','YYYY-MM-DD'), TO_DATE('2023-09-07','YYYY-MM-DD'), TO_DATE('2023-10-06','YYYY-MM-DD'), '설문조사1 ', 4 );
INSERT INTO tbl_survey VALUES ( 4, 2309011, TO_DATE('2023-09-07','YYYY-MM-DD'), TO_DATE('2023-09-07','YYYY-MM-DD'), TO_DATE('2023-10-07','YYYY-MM-DD'), '설문조사2 ', 2 );
INSERT INTO tbl_survey (survey_no,user_no,regdate, start_date, end_date, question ,cate_count)
       VALUES ( 5,2309011,to_date('2023-07-01', 'YY-MM-DD'), to_date('2023-08-01', 'YY-MM-DD'),to_date('2023-08-05', 'YY-MM-DD'), 'TITLE', 2);
INSERT INTO tbl_survey (survey_no,user_no,regdate, start_date, end_date, question ,cate_count)
       VALUES ( 6,2309012,to_date('2023-06-01', 'YY-MM-DD'), to_date('2023-07-01', 'YY-MM-DD'),to_date('2023-07-05', 'YY-MM-DD'), 'TITLE', 3);


-- 항목(tbl_cate) INSERT
INSERT INTO tbl_cate VALUES ( 1, '항목 1', 1);
INSERT INTO tbl_cate VALUES ( 1, '항목 2', 2);
INSERT INTO tbl_cate VALUES ( 1, '항목 3', 3);
INSERT INTO tbl_cate VALUES ( 2, '항목 1', 4);
INSERT INTO tbl_cate VALUES ( 2, '항목 2', 5);
INSERT INTO tbl_cate VALUES ( 3, '항목 1', 6);
INSERT INTO tbl_cate VALUES ( 3, '항목 2', 7);
INSERT INTO tbl_cate VALUES ( 3, '항목 3', 8);
INSERT INTO tbl_cate VALUES ( 3, '항목 4', 9);
INSERT INTO tbl_cate VALUES ( 4,'항목 1', 10);
INSERT INTO tbl_cate VALUES ( 4,'항목 2', 11);
INSERT INTO tbl_cate VALUES ( 5,'항목 1', 12);
INSERT INTO tbl_cate VALUES ( 5,'항목 2', 13);
INSERT INTO tbl_cate VALUES ( 6,'항목 1', 14);
INSERT INTO tbl_cate VALUES ( 6,'항목 2', 15);
INSERT INTO tbl_cate VALUES ( 6,'항목 3', 16);


-- 설문참여(tbl_vote) INSERT
INSERT INTO tbl_vote VALUES(1,2309001,1);
INSERT INTO tbl_vote VALUES(1,2309002,1);
INSERT INTO tbl_vote VALUES(1,2309003,1);
INSERT INTO tbl_vote VALUES(1,2309010,2);
INSERT INTO tbl_vote VALUES(1,2309004,2);
INSERT INTO tbl_vote VALUES(1,2309005,3);
INSERT INTO tbl_vote VALUES(2,2309009,4);
INSERT INTO tbl_vote VALUES(2,2309015,4);
INSERT INTO tbl_vote VALUES(2,2309013,4);
INSERT INTO tbl_vote VALUES(2,2309010,4);
INSERT INTO tbl_vote VALUES(2,2309002,5);
INSERT INTO tbl_vote VALUES(2,2309001,5);

COMMIT;

SELECT *
FROM tbl_user;

SELECT *
FROM tbl_survey;

SELECT *
FROM tbl_cate;

SELECT *
FROM tbl_vote;


--------------------------------------------------------------------------------------
-- 1번 ----------------------------
-- 설문을 등록하려는 회원이 관리자인지 확인
SELECT user_role
FROM tbl_user
WHERE user_no=2309012;

INSERT INTO tbl_survey
VALUES ( (SELECT MAX(survey_no) FROM tbl_survey)+1
        , 2309001
        , SYSDATE, TO_DATE('2023-09-10','YYYY-MM-DD'), TO_DATE('2023-09-17','YYYY-MM-DD')
        , '가장 좋아하는 여자 연예인은?'
        , 5);

INSERT INTO tbl_cate VALUES((SELECT MAX(survey_no) FROM tbl_survey),'배슬기',(SELECT MAX(cate_no)+1 FROM tbl_cate));
INSERT INTO tbl_cate VALUES((SELECT MAX(survey_no) FROM tbl_survey),'김옥빈',(SELECT MAX(cate_no)+1 FROM tbl_cate));               
INSERT INTO tbl_cate VALUES((SELECT MAX(survey_no) FROM tbl_survey),'아이비',(SELECT MAX(cate_no)+1 FROM tbl_cate));             
INSERT INTO tbl_cate VALUES((SELECT MAX(survey_no) FROM tbl_survey),'한효주',(SELECT MAX(cate_no)+1 FROM tbl_cate));             
INSERT INTO tbl_cate VALUES((SELECT MAX(survey_no) FROM tbl_survey),'김선아',(SELECT MAX(cate_no)+1 FROM tbl_cate));


-- 잘 저장되었는지 확인                       
SELECT *
FROM ( 
    SELECT question, name, regdate, start_date, end_date, cate_count
        , cate_content, s.survey_no
        , CASE WHEN SYSDATE < start_date THEN '예정'
               WHEN SYSDATE BETWEEN start_date AND end_date THEN '진행중'
               ELSE '종료'
          END 상태
    FROM tbl_user u JOIN tbl_survey s ON u.user_no = s.user_no
                    JOIN tbl_cate c ON c.survey_no = s.survey_no
) t
WHERE t.survey_no = (SELECT MAX(survey_no) FROM tbl_survey);                       
                        
                  
COMMIT;


-- 2번 ----------------------------
SELECT survey_no 번호
    , question 질문
    , (SELECT name FROM tbl_user WHERE user_no=s.user_no) 작성자
    , TO_CHAR(start_date, 'YYYY-MM-DD') 시작일
    , TO_CHAR(end_date, 'YYYY-MM-DD') 종료일
    , cate_count 항목수
    , (SELECT COUNT(*) FROM tbl_vote WHERE survey_no=s.survey_no) 참여자수
    , CASE WHEN SYSDATE < start_date THEN '예정'
           WHEN SYSDATE BETWEEN start_date AND end_date THEN '진행중'
           ELSE '종료'
      END 상태
FROM tbl_survey s
ORDER BY survey_no DESC;


-- 3번 ----------------------------
SELECT *
FROM ( 
SELECT question, name, regdate, start_date, end_date, cate_count
    , cate_content, s.survey_no
    , CASE WHEN SYSDATE < start_date THEN '예정'
           WHEN SYSDATE BETWEEN start_date AND end_date THEN '진행중'
           ELSE '종료'
      END 설문상태
FROM tbl_user u JOIN tbl_survey s ON u.user_no = s.user_no
                JOIN tbl_cate c ON c.survey_no = s.survey_no
) t
WHERE t.survey_no = 1;

--총참여자수
SELECT COUNT(*)
FROM tbl_vote
GROUP BY survey_no
HAVING survey_no=1;

--투표결과
SELECT c.cate_content 항목
    , LPAD(' ',COUNT(v.user_no)+1,'■')||COUNT(v.user_no)
      ||' '||ROUND(COUNT(v.user_no)/(SELECT COUNT(*) FROM tbl_vote WHERE survey_no=v.survey_no)*100,2)||'%' 설문결과 
FROM tbl_vote v, tbl_cate c 
WHERE v.survey_no = c.survey_no 
    AND v.cate_no = c.cate_no
GROUP BY v.survey_no,c.cate_content
HAVING v.survey_no=1;

--설문 투표 인서트 쿼리문
INSERT INTO tbl_vote VALUES (1, 2309011
                             ,( SELECT cate_no
                                FROM tbl_cate
                                WHERE survey_no=1 AND cate_content='항목 2'));
                                      
COMMIT;

--총 참여자수
SELECT COUNT(*)
FROM tbl_vote
GROUP BY survey_no
HAVING survey_no=1;

--투표결과
SELECT c.cate_content 항목
    , LPAD(' ',COUNT(v.user_no)+1,'■')||COUNT(v.user_no)
      ||' '||ROUND(COUNT(v.user_no)/(SELECT COUNT(*) FROM tbl_vote WHERE survey_no=v.survey_no)*100,2)||'%' 설문결과 
FROM tbl_vote v, tbl_cate c 
WHERE v.survey_no = c.survey_no 
    AND v.cate_no = c.cate_no
GROUP BY v.survey_no,c.cate_content
HAVING v.survey_no=1;



-- 4번 ----------------------------
-- 설문을 수정하려는 회원이 관리자인지 확인
SELECT user_role
FROM tbl_user
WHERE user_no=2309012;


--5번 설문조사 이름, 시작일, 종료일, 항목수 3으로 변경
SELECT *
FROM ( 
SELECT question, name, regdate, start_date, end_date, cate_count
    , cate_content, s.survey_no
    , CASE WHEN SYSDATE < start_date THEN '예정'
           WHEN SYSDATE BETWEEN start_date AND end_date THEN '진행중'
           ELSE '종료'
      END 설문상태
FROM tbl_user u JOIN tbl_survey s ON u.user_no = s.user_no
                JOIN tbl_cate c ON c.survey_no = s.survey_no
) t
WHERE t.survey_no = 5;


UPDATE tbl_survey 
SET question    = '수정된 타이틀', 
    start_date  = TO_CHAR(SYSDATE + 5,'YYYY-MM-DD'),
    end_date    = TO_CHAR(SYSDATE + 25,'YYYY-MM-DD'),
--    cate_count  = 3   -- 항목수 증가
--    cate_count = 1      -- 항목수 감소
WHERE 
    survey_no = '5'     -- 설문 번호
;

--항목수 증가시 항목 추가 쿼리
INSERT INTO tbl_cate VALUES ( 5, '추가된 항목 3', (SELECT MAX(cate_no)+1 FROM tbl_cate));

--항목수 감소시 항목 감소 쿼리
DELETE tbl_cate
WHERE survey_no = 5 AND cate_no >  ( 
           ( WITH t as(
            SELECT COUNT(*) cnt
            FROM tbl_cate 
            GROUP BY SURVEY_NO 
            HAVING survey_no < 5  
            )
            SELECT SUM(cnt)
            FROM T
            )
        + 
            (SELECT cate_count
            FROM tbl_survey
            WHERE survey_no = '5'
            )
        ) ;


COMMIT;


-- 5번 ----------------------------
SELECT question q, cate_content a
FROM tbl_survey s JOIN tbl_cate c ON s.survey_no=c.survey_no
WHERE end_date >= ALL (SELECT end_date FROM tbl_survey)
      AND end_date >= SYSDATE;

INSERT INTO tbl_vote VALUES (( SELECT survey_no
                               FROM tbl_survey
                               WHERE end_date >= ALL (SELECT end_date FROM tbl_survey)
                                     AND end_date >= SYSDATE)
                             , 2309001
                             ,( SELECT cate_no
                                FROM tbl_cate
                                WHERE survey_no=( SELECT survey_no
                                                  FROM tbl_survey
                                                  WHERE end_date >= ALL (SELECT end_date FROM tbl_survey)
                                                        AND end_date >= SYSDATE )
                                      AND cate_content='항목 2'));

-- 잘 저장되었는지 확인                       
SELECT *
FROM tbl_vote
WHERE survey_no = ( SELECT survey_no
                    FROM tbl_survey
                    WHERE end_date >= ALL (SELECT end_date FROM tbl_survey)
                          AND end_date >= SYSDATE)
      AND user_no=2309001;     


-- 6번 ----------------------------
SELECT *
FROM ( 
SELECT question, name, regdate, start_date, end_date, cate_count
    , cate_content, s.survey_no
    , CASE 
        WHEN SYSDATE BETWEEN start_date AND end_date THEN '진행중'
        ELSE '종료'
    END 설문상태
FROM tbl_user u JOIN tbl_survey s ON u.user_no = s.user_no
                JOIN tbl_cate c ON c.survey_no = s.survey_no
) t
WHERE t.survey_no = 1;

--총참여자수
SELECT survey_no, COUNT(*)
FROM tbl_vote
GROUP BY survey_no;

--투표결과
SELECT c.cate_content 항목
    , LPAD(' ',COUNT(v.user_no)+1,'■')||COUNT(v.user_no)
      ||' '||ROUND(COUNT(v.user_no)/(SELECT COUNT(*) FROM tbl_vote WHERE survey_no=v.survey_no)*100,2)||'%' 설문결과 
FROM tbl_vote v, tbl_cate c 
WHERE v.survey_no = c.survey_no 
    AND v.cate_no = c.cate_no
GROUP BY v.survey_no,c.cate_content
HAVING v.survey_no=1;

--투표수정
UPDATE tbl_vote 
SET cate_no=( SELECT cate_no
              FROM tbl_cate
              WHERE survey_no=1 AND cate_content='항목 1')
WHERE survey_no=1 AND user_no=2309004;

COMMIT;