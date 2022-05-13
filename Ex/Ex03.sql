/* ■ 그룹함수 JOIN*/
SELECT
    employee_id,
    first_name,
    salary,
    department_id
FROM
    employees;
-- ■ 직원의 이름과 직원이 속한 부서명을 함께 보고 싶다면
SELECT
    *
FROM
    employees, departments;
    
-- ■ EQUI Join
/*106건임(107건X)
양쪽다 만족하는 경우만 조인됨
null은 조인안됨(제외됨)*/
SELECT
    first_name,
    em.department_id,
    department_name,
    de.department_id
FROM
    employees   em,
    departments de
WHERE
    em.department_id = de.department_id;

-- 
SELECT
    employee_id,
    first_name,
    salary,
    department_name
FROM
    employees,
    departments
WHERE
    employees.employee_id = departments.department_id;
    -- em.department_id = de.department_id;
    
-- ■ 카티젼 프로덕트(Cartesian Product)
-- 올바른 Join조건을 WHERE 절에 부여 해야 함.
SELECT
    employee_id,
    first_name,
    salary,
    department_name,
    employees.department_id,
    departments.department_id
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

--  ■ 조인(join) - 테이별별명(Table alias)
-- 테이블의 명칭이 너무 긴 경우 원래의 테이블 명칭 대신에 사용하는 별도의 이름울 줘서 사용하는데 이를 Table Alias라고 한다.
SELECT
    employees.employee_id,
    em.first_name,
    em.salary,
    em.department_name,
    em.department_id   "e_did",
    de.department_id "d_did"
FROM
    -- 테이블명 테이블명별명
    employees em,
    departments de
WHERE
    em.department_id = de.department_id;
    
-- 예제
-- 모든 직원이름, 부서이름, 업무명 을 출력하세요
-- 처리방법 : 연결 테이블 join 
-- SELECT : employees.first_name, departments.department_name, jobs.job_title,
-- FROM : employees, departments, jobs
-- WHERE : em.department_id = de.department_id and em.job_id = jobs.job_id;

SELECT
    em.first_name,
    de.department_name,
    jo.job_title,
    ---- 확인용 출력 
    em.department_id,
    de.department_id,
    em.job_id,
    jo.job_id,
    -- 조건 추가확인 출력
    em.salary
    
--FROM 절에 필요로 하는 테이블을 모두 적는다.
FROM
    -- Table 이름에 Alias(별명=약자) 사용
    employees   em,
    departments de,
    jobs        jo
-- 적절한 Join 조건을 Where 절에 부여
WHERE
        em.department_id = de.department_id
    AND em.job_id = jo.job_id
    AND em.salary >= 7000
ORDER BY
    em.salary ASC;
    