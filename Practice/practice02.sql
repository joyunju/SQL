/*집계(통계) SQL 문제입니다*/

/*문제1.
매니저가 있는 직원은 몇 명입니까? 
아래의 결과가 나오도록 쿼리문을 작성하세요
결과 : haveMngCnt 106
*/
 -- 처리방법
 -- FROM : employees
 -- 출력 : count(manager_id)

SELECT
    COUNT(manager_id) "haveMngCnt"
    -- ,COUNT(commission_pct) --null 제외
FROM
    employees;

/*문제2.
직원중에 최고임금(salary)과 최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 
두 임금의 차이는 얼마인가요?
“최고임금 – 최저임금”이란 타이틀로 함께 출력해 보세요.*/

 -- 처리방법
 -- FROM : employees
 -- 출력 : max() / min()
 -- salary "최고임금", salary "최저임금", “최고임금 – 최저임금”

SELECT
    --COUNT(*),
    MAX(salary)               "최고임금",
    MIN(salary)               "최저임금",
    MAX(salary) - MIN(salary) "최고임금 – 최저임금"
FROM
    employees;

/*
문제3.
마지막으로 신입사원이 들어온 날은 언제 입니까? 
다음 형식으로 출력해주세요.
예) 2014년 07월 10일*/

 -- 처리방법
 -- FROM : employees
 -- 출력 : to_char(hire_date, 'YYYY년MM월DD일')

SELECT
    -- hire_date,
    to_char(hire_date, 'YYYY"년"MM"월"DD"일"')
FROM
    employees;

/*문제4.
부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
정렬순서는 부서번호(department_id) 내림차순입니다.*/

-- 처리방법
-- from : employees
-- 정렬 : 부서번호(department_id) 내림차순 DESC
-- 출력 : 부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력
-- avg(nvl(salary,0))/ avg(salary), max(salary), min(salary), department_id
-- 그룹함수 :  department_id

SELECT
    --de.department_name     "부서명",
    --round(AVG(salary), 0) "평균임금", -- 평균 반올림
    --  round(avg(nvl(salary,0)),0)
    AVG(nvl(salary, 0)) "평균임금",
    MAX(salary)         "최고임금",
    MIN(salary)         "최저임금",
    department_id       "부서아이디"
FROM
    employees em
GROUP BY
    department_id
ORDER BY
    department_id DESC;

/*문제5.
업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고
정렬 순서는 최저임금 내림차순, 평균임금(소수점 반올림), 오름차순 순입니다.
(정렬순서는 최소임금 2500 구간일때 확인해볼 것)*/

-- 처리방법
-- from : employees
-- GROUP BY / 그룹함수 : job_id
-- GROUP BY :  원하는 그룹별로 행들을 Grouping한다.
-- HAVING : 원하는 조건을 만족하는 그룹만 남긴다.
-- HAVING : 최소임금 2500 구간일때
-- SELECT / 출력 : round(AVG(salary), 0) : 평균임금, MAX(salary) : 최고임금, MIN(salary): 최저임금 / 업무아이디(job_id)와 함께 출력
-- ORDER BY / 정렬 : 최저임금(min_salary) 내림차순 DESC, round(AVG(salary), 0) "평균임금", -- 평균 반올림 asc

SELECT
    round(AVG(salary), 0) "평균임금",  -- 소주점 반올림
    MAX(salary)           "최고임금",
    MIN(salary)           "최저임금",
    job_id                "업무아이디"
FROM
    employees
GROUP BY
    job_id
-- HAVING MIN(salary) >= 2500
ORDER BY
    MIN(salary) DESC,
    round(AVG(salary), 0) ASC;


/*문제6.
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2001-01-13 토요일   */ 

-- 처리방법
-- from : employees
-- GROUP BY :  원하는 그룹별로 행들을 Grouping한다.
-- HAVING : 원하는 조건을 만족하는 그룹만 남긴다.
-- SELECT / 출력 : to_char(MIN(hire_date), 'YYYY-MM-DD DAY')
-- ORDER BY / 정렬 :

SELECT
    --first_name||' '||last_name "직원이름",
    to_char(MIN(hire_date), 'YYYY-MM-DD DAY')
FROM
    employees;
/*GROUP BY
    first_name, last_name, hire_date
ORDER BY hire_date ASC
    */
    

/*문제7.
평균임금과 최저임금의 차이가 2000 미만인
부서(department_id), 평균임금, 최저임금 그리고 (평균임금 – 최저임금)를
(평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.*/

-- 처리방법
-- from : employees
-- GROUP BY : department_id
-- HAVING : AVG(salary) - MIN(salary) < 2000
-- SELECT / 출력 : 부서(department_id), 평균임금, 최저임금, AVG(salary) - MIN(salary) "평균임금 – 최저임금"
-- ORDER BY / 정렬 : (평균임금 – 최저임금)의 내림차순 DESC

SELECT
    department_id             "부서",
    round(AVG(salary), 0)     "평균임금",  -- 소주점 반올림
    --AVG(salary)               "평균임금",
    MIN(salary)               "최저임금",
    AVG(salary) - MIN(salary) "평균임금 – 최저임금"
    -- round(AVG(salary) - MIN(salary), 1) "평균임금 – 최저임금"
FROM
    employees
GROUP BY
    department_id
HAVING
    AVG(salary) - MIN(salary) < 2000
ORDER BY
    AVG(salary) - MIN(salary) DESC;


/*문제8.
업무(JOBS)별로
최고임금과 최저임금의 차이를 출력해보세요.
차이를 확인할 수 있도록 내림차순으로 정렬하세요?*/

-- 처리방법
-- from : employees
-- GROUP BY : job_id
-- SELECT / 출력 : MAX(salary) - MIN(salary) "최고임금 – 최저임금"
-- ORDER BY / 정렬 : (최고임금 – 최저임금)의 내림차순 DESC

SELECT
    MAX(salary) - MIN(salary) "최고임금 – 최저임금"
FROM
    employees
GROUP BY
    job_id
ORDER BY
    MAX(salary) - MIN(salary) DESC;

/*문제9
2005년 이후 입사자 중
관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
출력은 관리자별로 평균급여가 5000이상 중에
평균급여 최소급여 최대급여를 출력합니다.
평균급여의 내림차순으로 정렬하고
평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.*/

-- ■ 처리방법
-- from : employees
-- WHERE : 2005년 이후 입사자 hire_date >= '2005 / 01 / 01'
-- GROUP BY : manager_id
-- having : 관리자별로 평균급여가 5000이상 / AVG(salary) >= 5000
-- SELECT / 출력 : round(AVG(salary), 1) / AVG(salary) "평균급여", MIN(salary) "최소급여", MAX(salary) "최대급여"
-- ORDER BY / 정렬 : (최고임금 – 최저임금)의 내림차순 DESC

SELECT
    round(AVG(salary), 0) "평균급여", -- 소수점 첫째짜리에서 반올림
    MIN(salary)           "최소급여",
    MAX(salary)           "최대급여"
FROM
    employees
WHERE
    hire_date >= '2005 / 01 / 01'
GROUP BY
    manager_id
HAVING
    AVG(salary) >= 5000
ORDER BY
    AVG(salary) DESC;



/*문제10
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다.
입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’
이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.*/


    

