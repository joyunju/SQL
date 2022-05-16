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



