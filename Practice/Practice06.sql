-- author 테이블 만들기

CREATE TABLE author (
    author_id   NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY ( author_id )
);

-- author 테이블 생성확인
SELECT
    * FROM author;

/*오류 보고 -
ORA-00955: name is already used by an existing object
문제 상황 : 작가 시퀀스 seq_author_id만드려했는데 오류발생
원인 : 시퀀스 이름 사용중
해결 : 시퀀스 삭제*/
    
-- 시퀀스 삭제
drop sequence seq_author_id;
    
-- 작가 시퀀스 만들기
CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1 
nocache;

-- author 테이블 컬럼 생성
-- seq_author_id.nextval 1정보 생성
INSERT INTO author VALUES (
    seq_author_id.nextval,      -- 알아서 1 인식
    '김문열',
    '경북 영양'
);

-- seq_author_id.nextval 2정보 생성
INSERT INTO author (
    author_id,
    author_name,
    author_desc
) VALUES (
    seq_author_id.nextval,
    '박경리',
    '경상남도 통영'
);

-- seq_author_id.nextval 3정보 생성
INSERT INTO author VALUES (
    seq_author_id.nextval,
    '유시민',
    '17대 국회의원'
);

-- seq_author_id.nextval 4정보 생성
INSERT INTO author VALUES (
    seq_author_id.NEXTVAL,
    '기안84',
    '기안동에서 산 84년생'
);

-- seq_author_id.nextval 5정보 생성
INSERT INTO author VALUES (
    seq_author_id.NEXTVAL,
    '강풀',
    '온라인 만화가 1세대'
);

-- seq_author_id.nextval 6정보 생성
INSERT INTO author VALUES (
    seq_author_id.NEXTVAL,
    '김영하',
    '알쓸신잡'
);

-- author 테이블/시퀀스 생성확인
SELECT
    * FROM author;
    
-- book 테이블 삭제
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

-- book 테이블 생성확인
SELECT
    * FROM book;
    
-- 시퀀스 삭제
drop sequence seq_book_id;
    
-- book 시퀀스 만들기 : 시퀀스 seq_book_id
CREATE SEQUENCE seq_book_id
INCREMENT BY 1
START WITH 1 
nocache;

-- book 테이블 컬럼 생성
-- seq_book_id.nextval 1정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '우리들의 일그러진 영웅',
    '다림',
    '1998-02-22',
    1
);

-- seq_book_id.nextval 2정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '삼국지',
    '민음사',
    '2002-03-11',
    1
);

-- seq_book_id.nextval 3정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '토지',
    '마로니에북스',
    '2012-08-15',
    2
);

-- seq_book_id.nextval 4정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '유시민의 글쓰기 특강',
    '생각의 길',
    '2015-04-01',
    3
);

-- seq_book_id.nextval 5정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '패션왕',
    '중앙북스(books)',
    '2012-02-22',
    4
);

-- seq_book_id.nextval 6정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '순정만화',
    '재미주의',
    '2011-08-03',
    5
);

-- seq_book_id.nextval 7정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '오직두사람',
    '문학동네',
    '2017-05-04',
    6
);

-- seq_book_id.nextval 8정보 생성
INSERT INTO book VALUES (
    seq_book_id.NEXTVAL,
    '26년',
    '재미주의',
    '2012-02-04',
    5
);

-- book 테이블/시퀀스 생성확인
SELECT
    * FROM book;

-- ■ 강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요
UPDATE author
SET
    author_desc = '서울특별시'
WHERE
    author_id = 5;

-- update 반영 확인
SELECT
    * FROM author;

-- ■ author 테이블에서 기안84 데이터를 삭제해 보세요  삭제 안됨
DELETE FROM author
WHERE
    author_id = 4;
    
/*
오류 보고
ORA-02292: integrity constraint (WEBDB.BOOK_FK) violated - child record found
문제 발생 : author 테이블에서 기안84 데이터를 삭제 불가
원인 : 현재 삭제할려는 테이블의 데이타가 다른 테이블의 데이타의 PK값일 경우에 발생

해결 방법 : 해당 테이블의 자식 레코드 삭제 후 원래 삭제하려던 테이블을 삭제
ㄴ 해당 에러문의 제약조건명 TEST123을 기억해뒀다가
SELECT CONSTRAINT_NAME, TABLE_NAME, R_CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'TEST123';
위의 쿼리문을 입력하여 삭제해야 할 데이터의 테이블명을 확인하고 삭제해준다.
*/


-- ■ book 테이블과 author 테이블 join
SELECT
    bo.book_id,
    bo.title,
    bo.pubs,
    bo.pub_date,
    bo.author_id,
    au.author_name,
    au.author_desc
FROM
    book   bo,
    author au
WHERE
    bo.author_id = au.author_id;


