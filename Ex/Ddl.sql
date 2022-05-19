-- 테이블 생성
/*
create table author(
    컬럼명, 데이터타입, 제약조건 
);
*/

CREATE TABLE author (
    author_id   NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY ( author_id )
);

SELECT
    * FROM author;

-- ■ DML(Data Manipulation Language, 데이터 조작어) --> 테이블 관리
-- 테이블 생성시 정의한 순서에 따라 값 지정

--1) ■ 묵시적 방법
-- 테이블 생성시 정의한 순서에 따라 값 지정
INSERT INTO author VALUES (
    1,
    '박경리',
    '토지 작가 '
);

--2) ■ 명시적 방법
-- 컬럼 이름명시적 사용
INSERT INTO author( author_id, author_name )
VALUES (2, '이문열' );

INSERT INTO author( author_id, author_name )
VALUES (3, '기안84' );

-- TABLE book 삭제
DROP TABLE book;

-- book 테이블 만들기
CREATE TABLE book (
    book_id   NUMBER(10),
    title     VARCHAR2(100) NOT NULL,
    pubs      VARCHAR2(100),
    pub_date  DATE,
    author_id NUMBER(10),
    PRIMARY KEY ( book_id ),
    CONSTRAINT book_fk FOREIGN KEY ( author_id )
    REFERENCES author ( author_id )
);

/*
PRIMARY KEY ( book_id ),
-- book 테이블의 유일한 컬럼으로 book_id에 설정함
CONSTRAINT book_fk FOREIGN KEY ( author_id )
CONSTRAINT 별명 FOREIGN KEY (book테이블의 author_id)
REFERENCES author ( author_id )
누구를 참고 했냐면 author 테이블을 참고 (author 테이블의 author_id)
ㄴ 일반적으로 REFERENCE 테이블의 PK를 참조
ㄴ REFERENCE 테이블 = author 테이블 / author 테이블의 PK = author_id = book테이블의 FOREIGN KEY  = book테이블의 author_id
*/

-- 테이블 book 생성 확인
SELECT
    * FROM book;

-- DML-INSERT
-- 넣을 데이터 : 1, 토지, 마로니에북스, 2012-08-15, 1
INSERT INTO book VALUES (
    1,                   -- book_id
    '토지',               -- title
    '마로니에북스',        -- pubs
    '2012-08-15',         -- pub_date
    1                     -- author_id
);

-- 넣을 데이터 : 2, 삼국지, 민음사, 2002-03-01, 2 
INSERT INTO book VALUES (
    2,
    '삼국지',
    '민음사',
    '2002-03-01',
    2
);


/*INSERT INTO author( author_id, author_name )
VALUES (2, '이문열' );
*/

-- DML-UPDATE
-- 수정 : UPDATE
/*
UPDATE 테이블명
set 수정할 컬럼명 = 컬럼값
where 어떤 것을 바꿀 것인지 반드시 지정! 안그럼 다 바뀜 
*/

-- where절이 없으면 어떻게 되는지 확인하기!!
UPDATE author
SET author_desc = '웹툰 작가';

-- 수정
UPDATE author
SET author_desc = '삼국지 작가'
WHERE author_id = 2 ;

-- 수정 확인
SELECT
    * FROM author;

-- 수정
UPDATE author
SET
    author_name = '김경리',
    author_desc = '토지 작가'
WHERE
    author_id = 1;
    
-- ■ 조건이 없으면 모든 데이터 삭제(주의)
/*아래와 같이 작성시 다 지워짐
DELETE FROM author; */

DELETE FROM book;

-- 데이터 다 지워졌는지 확인
SELECT
    * FROM book;

-- ■ 조건을 만족하는 레코드를 삭제
DELETE FROM author
WHERE
    author_id = 3;
    
-- ■ 테이블 삭제
DROP TABLE author;
DROP TABLE book;

-- 삭제 확인
SELECT
    * FROM book;
    