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