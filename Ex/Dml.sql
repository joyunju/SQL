-- author 테이블 만들기

CREATE TABLE author (
    author_id   NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY ( author_id )
);

-- 컬럼 생성
INSERT INTO author VALUES (
    1,
    '박경리',
    '토지 작가'
);

INSERT INTO author (
    author_id,
    author_name,
    author_desc
) VALUES (
    2,
    '이문열',
    '삼국지 작가'
);

-- 확인
SELECT
    * FROM author;

-- 삭제
DELETE FROM author;

/*
■ SEQUENCE(시퀀스)
: 연속적인 일렬번호 생성PK에 주로 사용됨
*/

/* 시퀀스 생성 방법
CREATE SEQUENCE 시퀀스이름작명
INCREMENT BY : 시퀀스 실행 시 증가시킬 값
START WITH : 시퀀스의 시작값이다. (MINVALUE과 같거나 커야 한다)
NOCACHE | CACHE : NOCACHE(사용안함), CACHE(캐시를 사용하여 미리 값을 할당해 놓아서 속도가 빠르며, 동시 사용자가 많을 경우 유리)
;
*/

-- 작가 시퀀스 만들기
CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1 
nocache;


INSERT INTO author VALUES (
    seq_author_id.nextval,      -- 알아서 1 인식
    '박경리',
    '토지 작가'
);

INSERT INTO author (
    author_id,
    author_name,
    author_desc
) VALUES (
    seq_author_id.nextval,      -- 알아서 2 인식
    '이문열',
    '삼국지 작가'
);

INSERT INTO author VALUES (
    seq_author_id.nextval,      -- 알아서 3 인식
    '기안84',
    '웹툰 작가'
);

INSERT INTO author VALUES (
    seq_author_id.nextval,      
    '완두콩',
    'java'
);

INSERT INTO author VALUES (
    seq_author_id.nextval,      
    '유재석',
    '개그맨'
);

-- 오라클 오류 : ORA-00001
-- ORA-00001: unique constraint (WEBDB.SYS_C007015) violated / 유일성 제약조건에 위배됩니다
/*Solution : UK, IK, PK, FK와 같이 테이블에 단 하나만 존재해야하는 key를 중복해서 넣을때 발생하는
에러이므로 db에 insert되는 데이터를 점검해서 key값이 중복되지 않게 해야 합니다.*/

-- ex)  seq_author_id 3번까지 있어서 오류가 났는데, 4번은 비어 있어서 4번일때 유재석의 값이 들어감

SELECT
    * FROM author;

--  전체 시퀀스 조회  
SELECT
    *
FROM
    user_sequences;


-- ※ 가상의 테이블 : dual
/* ■ 해당 시퀀스 값 조회
ㄴ seq_author_id.currval : 현재까지 생성된 번호 알려줘 */
SELECT
    seq_author_id.currval
FROM
    dual;
    
-- 다음에 생성될 번호 알려줘
-- 문제: 번호 확인만 하는 것이 아니라 다음 번호를 실행해서 조회할 때마다 번호 올라감
SELECT
    seq_author_id.nextval
FROM
    dual;

-- 시퀀스 삭제
drop sequence seq_author_id;

-- rollback;
-- commit;

-- commit : 여기까지 저장?
-- ㄴ 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어
commit;

-- 이효리 데이터 추가 /  커밋은 안함
INSERT INTO author VALUES (
    seq_author_id.nextval,      
    '이효리',
    '가수'
);

-- 이효리 데이터 보이지만 커밋은 안된 상태
SELECT
    * FROM author;

-- 롤백 : 마지막 commit으로 이동
rollback;

-- 이효리 데이터 없어짐
SELECT
    * FROM author;
    
-- 작가 테이블 삭제
DROP TABLE author;

-- 작가 시퀀스 삭제
DROP SEQUENCE seq_author_id;

-- 작가 테이블 만들기 
CREATE TABLE author (
    author_id   NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY ( author_id )
);

-- 작가 테이블 생성 확인용
SELECT
    * FROM author;
    
-- 작가 시퀀스 만들기
CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1 
nocache;

-- 작가 시퀀스 조회하기
SELECT
    *
FROM
    user_sequences;

-- 작가 데이터 추가
INSERT INTO author VALUES (
    seq_author_id.NEXTVAL,
    '박경리',
    '토지 작가'
);

INSERT INTO author VALUES (
    seq_author_id.NEXTVAL,
    '이문열',
    '삼국지 작가'
);

INSERT INTO author VALUES (
    seq_author_id.NEXTVAL,
    '기안84',
    '웹툰 작가'
);

-- update
UPDATE author
SET
    author_name = '자취 84',
    author_desc = '나혼자산다 출연'
WHERE
    author_id = 3;
    
-- 작가 테이블 조회하기 
SELECT
    * FROM author;
    
-- 작가 시퀀스 조회하기
SELECT
    *
FROM
    user_sequences;

