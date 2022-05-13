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
    MAX(salary) "최고임금",
    MIN(salary) "최저임금",
    MAX(salary)-MIN(salary) "최고임금 – 최저임금"
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