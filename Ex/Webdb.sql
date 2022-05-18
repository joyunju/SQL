-- >> DDL(Data Definition Language, 데이터 정의어) --> 테이블 관리
-- 테이블 생성 : create table 테이블명();
CREATE TABLE book (
    book_id  NUMBER(5),
    title    VARCHAR2(50),
    author   VARCHAR2(10),
    pub_date DATE
);

-- ■ 컬럼추가
ALTER TABLE book ADD (pubs VARCHAR2(50));

--■ 컬럼수정
-- : title VARCHAR2(100) --> 문자열 50->100으로 수정
ALTER TABLE book MODIFY (title VARCHAR2(100));
-- 닉네임 title -> subject 로 수정 : RENAME
ALTER TABLE book RENAME COLUMN title TO subject;

--■ 컬럼삭제
--author 컬러명 라인 삭제
ALTER TABLE book DROP (author);





SELECT
    * FROM book;




    
-- 테이블 명 수정
RENAME book TO article;

-- 테이블 삭제
DROP TABLE article;