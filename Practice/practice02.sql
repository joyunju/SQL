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