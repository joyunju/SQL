/*
능력단위 평가
[문제1] SQL문을 작성하세요
2005년 이후 입사한 직원중에 입사일이 6번째에서 10번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

SELECT
    ort.rn,
    ort.employee_id "직원의사번",
    ort.first_name "이름",
    ort.department_name "부서명",
    ort.salary "급여",
    ort.hire_date "입사일"
FROM
    ( --rownum 생성 : (조건절 해결)
        SELECT
            ROWNUM rn,
            ot.employee_id,
            ot.first_name,
            ot.department_name,
            ot.salary,
            ot.hire_date
        FROM
            (  -- 정렬시킨 ot 테이블 생성 : (order 해결)
                SELECT
                    employee_id,
                    first_name,
                    department_name,
                    salary,
                    hire_date
                FROM
                    employees   em,
                    departments de
                WHERE
                        em.department_id = de.department_id
                    AND hire_date >= '2005/01/01'
                ORDER BY
                    hire_date ASC
            ) ot
    ) ort  -- >> 정렬+ ROWNUM시킨 ort 테이블 생성
WHERE
        rn >= 6
    AND rn <= 10;
    

/*
[문제2]
아래의 그림의 테이블을 생성하는 SQL문을 작성하세요
*/

-- author 테이블 생성
CREATE TABLE author (
    author_id   NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY ( author_id )
);

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

-- 출력 확인
SELECT
    *
FROM
    author;

SELECT
    *
FROM
    book;