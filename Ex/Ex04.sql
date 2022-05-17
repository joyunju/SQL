/* ■ SubQuery
 : 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태*/

/*[예제]
‘Den’ 보다 급여를 많은 사람의 이름과 급여는?*/
-- 1) DEN의 급여 확인
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name = 'Den'; -- Den 의 급여가 11000이라는 것 확인
    
-- 2) DEN의 급여보다 많은 사람의 이름과 급여 출력    
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 11000
ORDER BY
    salary DESC;

/* ■ 위의 예제 SubQuery로 작성 
ㄴ where 절의 연산자 오른쪽에 위치해야 하며 괄호로 묶어야한다.
ㄴ 가급적 order by 를 하지 않는다.*/

SELECT
    first_name,
    salary
FROM
    employees
    WHERE salary > (SELECT salary
                        FROM
                            employees
                        WHERE
                            first_name = 'Den');
                            
/* ■ 단일행 SubQuery
ㄴ 연산자 : = , > , >=, < , <=, <>(같지않다)*/

/*[예제]
급여를 가장 적게 받는 사람의 
이름, 급여, 사원번호는?*/

/*처리 방법
1. 가장 적은 급여를 구한다 -- 2100이 가장 적은 급여라고 나옴
SELECT MIN(salary)
    FROM employees
2. 이 조건을 WHERE 질의문에 넣는다.*/

SELECT
    first_name,
    salary,
    employee_id
FROM
    employees
    WHERE salary = (SELECT MIN(salary)
                        FROM
                            employees);

/*[예제]
평균 급여보다 적게 받는 사람의
이름, 급여를 출력하세요?*/

SELECT
    first_name "이름",
    salary "급여"
FROM
    employees
    WHERE salary < (SELECT AVG(salary)
                        FROM
                            employees);

/*예제. 부서번호가 110인 직원의 급여와 같은 모든 직원의
사번, 이름, 급여를 출력하세요*/

SELECT
    *
FROM
    employees
WHERE
    department_id = 110;
    
SELECT
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
        salary = 12008
    AND salary = 8300;
    
/*■ 다중행 SubQuery in 사용
ㄴ subQuery의 결과가 여러 Row인 경우 크다 작다인 부등호 사용 >,< 대신 in 사용해야함
ㄴ 연산자 : ANY, ALL, IN */

SELECT
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
    salary IN
          (SELECT salary 
           FROM employees
           WHERE department_id =110);  -- 12008, 8300

/* ■ SubQuery
: 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태 */

-- 예제

SELECT
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
    salary IN (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    );
                
-- [예제] : 각 부서별로 최고급여를 받는 사원을 출력하세요
-- 마케팅 유재석 10000
-- 배송 정우성 20000
-- 관리 이효리 30000

SELECT
    department_id,
    MAX(salary)
FROM
    employees
GROUP BY
    department_id;

-- 다중행 IN 은 동시에 여러가지 값을 비교할 수 있다.
-- 단 형태가 같아야 한다. 단 형태가 같아야 한다.
SELECT
    employee_id,
    first_name,
    salary,
    department_id
FROM
    employees
WHERE
    ( department_id, salary ) IN ( ( 10, 4400 ), ( 20, 13000 ) );
    
    
-- ■ 다중행 SubQuery : in
-- : 다중행 IN 은 동시에 여러가지 값을 비교할 수 있다.
SELECT
    employee_id,
    first_name,
    salary,
    department_id
FROM
    employees
WHERE
    ( department_id, salary ) IN (
        SELECT
            department_id, MAX(salary)
        FROM
            employees
        GROUP BY
            department_id
    );

-- ■ 다중행 SubQuery : ANY (or)

/* 예제 : 
부서번호가 110인 직원의 급여 보다 큰 모든 직원의
사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰) */

--1) 
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > 12008
    OR salary > 8300;

-- 2) 부서번호가 110인 (12008, 8300) 
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > ANY (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    );
                                
 
-- ■ 다중행 SubQuery : ALL (and)
-- all과 any 문법 비교하기위해 같은 예제

/* 예제 : 
부서번호가 110인 직원의 급여 보다 큰 모든 직원의
사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰) */   

-- 1) 부서번호가 110 인 직원의 급여  --> 12008, 8300

SELECT
    first_name,
    salary,
    department_id
FROM
    employees
WHERE
    department_id = 110;
    
-- 2) 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.
-- (and연산--> 12008보다 큰)

SELECT
    department_id "사번",
    first_name    "이름",
    salary        "급여"
FROM
    employees
WHERE
    salary > ALL (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    );
    
/* SubQuery : 조건절에서 비교 vs 테이블에서 조인조건절에서 비교 vs 테이블에서 조인
* 두개의 결과값 비교해볼것*두개의 결과값 비교해볼것 */

-- 예제 : 각 부서별로 최고급여를 받는 사원을 출력하세요각 부서별로 최고급여를 받는 사원을 출력하세요

-- 1) 각 부서 개수 확인 : 12그룹
SELECT
    *
FROM
    employees;
    
--2) 부서별 최고 급여 확인 
SELECT
    department_id,
    MAX(salary) "Maximum"
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id DESC;
    
-- 3) in 사용 
SELECT
    *
FROM
    employees
WHERE
    ( department_id, salary ) IN ( ( 100, 12008 ), (30, 11000) );

-- 4) where in 조건에 2번식 대입 -> 조건절에서 비교
SELECT
    -- *
    first_name,
    salary,
    department_id
FROM
    employees
WHERE
    ( department_id, salary ) IN (
                                    SELECT
                                        department_id, MAX(salary)
                                    FROM
                                        employees
                                    GROUP BY
                                        department_id
                                );
    
-- 예제 : 각 부서별로 최고급여를 받는 사원을 출력하세요
-- 테이블에서 조인하는 방법 

/*SELECT
    * FROM employees em, (테이블 자리);*/
    
-- 106건 
SELECT
    -- *
    em.first_name,
    em.salary,
    em.department_id,
    s.department_id,
    s.MAXSalary
FROM
    employees em,(  SELECT
                        department_id,
                        MAX(salary) MAXSalary
                    FROM
                        employees
                    GROUP BY
                        department_id ) s 
WHERE em.department_id = s.department_id
AND em.salary = s.MAXSalary;

-- 부서별 최고 급여 확인 
SELECT
department_id,
    max(salary)
FROM
    employees
GROUP BY
    department_id;





