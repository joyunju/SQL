/*그룹함수*/
-- 여러행으로부터 하나의 결과값을 반환

/*SELECT
    first_name,
    SUM(salary)
FROM
    employees;*/

SELECT
    SUM(salary)
FROM
    employees;

-- >> 그룹함수 - count()
-- : 함수에 입력되는 데이터의 총 건수를 구하는 함수
-- COUNT(*) / COUNT(컬럼명)
SELECT
    COUNT(*),    -- null 포함
    COUNT(commission_pct),    -- null 제외
    COUNT(manager_id)
FROM
    employees;

-- 예제 : count()
SELECT
    -- *
    COUNT(*)
FROM
    employees
WHERE
    salary > 16000;

-- >> 그룹함수 : sum()
-- 입력된 데이터들의 합계 값을 구하는 함수
SELECT
    COUNT(*),
    SUM(salary)
FROM
    employees;
    
-- >> 그룹함수 : avg()
-- : 입력된 값들의 평균값을 구하는 함수
-- : 주의: null 값이 있는 경우 빼고 계산함 – nvl 함수와 같이 사용
SELECT
    COUNT(*),
    SUM(salary),
    AVG(salary)
FROM
    employees;
    
-- 반올림함수 ROUND(n,반올림할 위치)
SELECT
    COUNT(*),
    SUM(salary),
    AVG(nvl(salary, 0)),
    round(AVG(salary), 0) -- 반올림
FROM
    employees;
-- 그룹함수 - max() / min()
-- : 입력된 값들중 가장 큰값/작은값 을 구하는 함수
SELECT
    COUNT(*),
    MAX(salary) "가장 큰값",
    MIN(salary) "가장 작은값"
FROM
    employees;
    
/*GROUP BY절*/
SELECT
    first_name
FROM
    employees
WHERE
    salary > 16000
ORDER BY
    salary DESC;
    
--  GROUP BY 절
SELECT
    department_id,
    AVG(salary),  -- GROUP BY 설정으로 부서별 평균 가능해짐
    SUM(salary),   -- 부서별 합계가 된다.
    COUNT(salary)  -- 부서별 총 개수
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id ASC;
    
-- 자주나는 오류 case 1
/*SELECT
    department_id, -- 부서별 
    AVG(salary)  -- 전체 평균이고
FROM
    employees
ORDER BY
    department_id ASC;*/

-- ■ GROUP BY 절 예제
/*연봉(salary)의 합계가 20000 이상인 부서의 
부서 번호와 , 인원수, 급여합계를 출력하세요*/

-- 오류 자주 나는 case
SELECT
    department_id,
    COUNT(*),
    SUM(salary)
FROM
    employees
/*WHERE
    sum(salary) >= 20000*/
    -- *** where 절에서는 그룹함수를 쓸 수 없다.
GROUP BY
    department_id;

-- ■ 오류 having절로 해결
-- : 그룹함수인데 조건이 붙는 경우 , having 사용 
-- 정상 작동
SELECT
    department_id,
    COUNT(*),
    SUM(salary)
FROM
    employees
GROUP BY
    department_id
HAVING SUM(salary) >= 20000
       AND SUM(salary) <= 100000
       AND department_id >= 90;

-- ■ having절 오류 case
SELECT
    department_id,
    COUNT(*),
    SUM(salary)
FROM
    employees
GROUP BY
    department_id
HAVING SUM(salary) >= 20000
       AND SUM(salary) <= 100000
       AND department_id >= 90;
       --AND hire_date >= '04/01/01';  --오류
    -- 오류 이유 : having 절에는 그룹함수 와 Group by에 참여한 컬럼만 사용할 수 있다.

-- ■ CASE ~ END문
/*CASE 
    WHEN 조건 THEN 출력1
    WHEN 조건 THEN 출력2  필요시 추가
    ELSE 출력3
END “컬럼명”*/

SELECT
    employee_id,
    first_name,
    job_id,
    salary,
    salary + salary * 0.1 "realSalary"
FROM
    employees;

-- CASE ~ END 적용
-- if ~else if~else 문과 유사
SELECT
    employee_id,
    salary,
    CASE
        WHEN job_id = 'AC_ACCOUNT' THEN
            salary + salary * 0.1
        WHEN job_id = 'SA_REP'     THEN
            salary + salary * 0.2
        WHEN job_id = 'ST_CLERK'   THEN
            salary + salary * 0.3
        ELSE
            salary
    END realsalary
    -- END "컬럼명" → CASE문에 적용할 컬럼명 작성
FROM
    employees;

-- ■ DECODE 문 (CASE ~ END 비교)
-- == 일때만 가능
-- case문과 비교
SELECT
    employee_id,
    salary,
    CASE
        WHEN job_id = 'AC_ACCOUNT' THEN
            salary + salary * 0.1
        WHEN job_id = 'SA_REP'     THEN
            salary + salary * 0.2
        WHEN job_id = 'ST_CLERK'   THEN
            salary + salary * 0.3
        ELSE
            salary
 -- END "컬럼명" → CASE문에 적용할 컬럼명 작성
    END realsalary
FROM
    employees;
    
-- 위의 case문을 DECODE 문으로 똑같이 작성
SELECT
    employee_id,
    salary,
    decode(job_id, 'AC_ACCOUNT', salary + salary * 0.1, 'SA_REP', salary + salary * 0.2,
           'ST_CLERK', salary + salary * 0.3, salary) realsalary
FROM
    employees;
    
--[예제]
/*직원의 이름, 부서, 팀을 출력하세요
팀은 코드로 결정하며 
부서코드가 10~50 이면 ‘A-TEAM’
60~100이면 ‘B-TEAM’ 
110~150이면 ‘C-TEAM’ 
나머지는 ‘팀없음’ 으로 출력하세요.*/

-- 처리 방법
-- form : employees
-- 조건 : CASE ~ END문 / and 사용 
-- select : 직원의 이름, 부서, 팀을 출력

SELECT
    first_name || ' ' || last_name  "직원의 이름",
    department_id "부서",
    CASE
        WHEN department_id >= 10 AND department_id <= 50 THEN 'A-TEAM'
        WHEN department_id >= 60
             AND department_id <= 100 THEN
            'B-TEAM'
        WHEN department_id >= 110
             AND department_id <= 150 THEN
            'C-TEAM'
        ELSE
            '팀없음'
        END  "team"
FROM
    employees;