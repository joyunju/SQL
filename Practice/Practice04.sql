-- 서브쿼리(SUBQUERY) SQL 문제입니다.

/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)*/

--1) 평균 급여는?

SELECT
    -- AVG(salary)  --> 6462
    round(AVG(salary), 0)
FROM
    employees;

--2) 평균 급여보다 적은 급여를 받는 직원은 몇명?

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary < (
                SELECT
                    --round(AVG(salary), 0)
                    AVG(salary)
                FROM
                    employees
            );

/*
문제2.
평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를
급여의 오름차순으로 정렬하여 출력하세요
(51건)*/

-- 1) 평균급여, 최대급여
SELECT
    round(AVG(salary), 0) "평균급여",  -- 6462
    MAX(salary)           "최대급여"   -- 24000
FROM
    employees;
    
-- 2)급여의 오름차순으로 정렬하여 출력 : ASC
SELECT
    employee_id "직원번호",
    first_name  "이름",
    salary      "급여"
FROM
    employees
WHERE   
        salary >= ( -- 평균급여 이상
            SELECT
                AVG(salary)
            FROM
                employees
        )
    AND salary <= ( -- 최대급여 이하
        SELECT
            MAX(salary)
        FROM
            employees
    )
ORDER BY
    salary ASC;


/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)*/

-- 출력 확인
SELECT
    *
FROM
    locations;
--
SELECT
    first_name,
    last_name
FROM
    employees
WHERE
        first_name = 'Steven'
    AND last_name = 'King';
    
-- 
SELECT
    lo.location_id "도시아이디",
    lo.street_address "거리명",
    lo.postal_code "우편번호",
    lo.city "도시명",
    lo.state_province "주",
    lo.country_id "나라아이디",
    em.first_name || ' ' || last_name AS full_name
FROM
    locations   lo,
    departments de,
    employees   em
WHERE
        lo.location_id = de.location_id
    AND de.department_id = em.department_id
    AND ( first_name, last_name ) IN (
                                        SELECT
                                            first_name, last_name
                                        FROM
                                            employees
                                        WHERE
                                                first_name = 'Steven'
                                            AND last_name = 'King'
                                    );



/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은
직원의 사번,이름,급여를
급여의 내림차순으로 출력하세요 --desc
-ANY연산자 사용
(74건)*/

-- job_id 가 'ST_MAN' 인 직원의 급여 : 5800-8200
SELECT
    job_id,
    salary
FROM
    employees
WHERE
    job_id = 'ST_MAN';

-- ANY연산자 사용
SELECT
    employee_id  "직원의 사번",
    first_name || ' ' || last_name AS 이름,
    salary "급여"
FROM
    employees
WHERE
    salary < ANY ( -- job_id 가 'ST_MAN' 인 직원의 급여
                    SELECT
                        salary
                    FROM
                        employees
                    WHERE
                        job_id = 'ST_MAN'
                )
ORDER BY salary DESC;



/*
문제5.
각 부서별로 최고의 급여를 받는 사원의
직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요
※ 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. -DESC
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)*/

-- 조건) 각 부서별 최고 급여
SELECT
    department_id "부서번호",
    MAX(salary)   "최고급여"
FROM
    employees
GROUP BY
    department_id;
    
-- 1) 조건절비교 방법    
SELECT
    employee_id   "직원번호",
    first_name    "이름",
    salary        "급여",
    department_id "부서번호"
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
                                )
order by salary desc;

-- 2) 테이블조인
SELECT
    em.employee_id   "직원번호",
    em.first_name    "이름",
    em.salary        "급여",
    em.department_id "부서번호"
FROM
    employees em,
                    ( -- s 테이블 생성
                        SELECT
                            department_id,
                            MAX(salary) maxsalary
                        FROM
                            employees
                        GROUP BY
                            department_id
                    ) s
WHERE
        em.department_id = s.department_id
    AND em.salary = s.maxsalary
ORDER BY
    salary DESC;

/*문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
연봉 총합이 가장 높은 업무부터 - desc
업무명(job_title)과 연봉 총합을 조회하시오
(19건)*/

SELECT
    * FROM jobs;

-- 조건) 각 업무(job)별로 연봉(salary)의 총합
-- from : employees em, jobs jo
-- 방법 : 조건절에서 비교
SELECT
    jo.job_title "업무명",
    --jo.job_id,
    SUM(em.salary) "연봉총합"
FROM
    jobs      jo,
    employees em
WHERE
    em.job_id = jo.job_id
GROUP BY
    jo.job_title, jo.job_id
ORDER BY
    SUM(em.salary) DESC;


/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은
직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요
(38건)*/

-- 자신의 부서 평균 급여
SELECT
    department_id,
    round(AVG(salary), 0) "평균 급여"
FROM
    employees
GROUP BY
    department_id;
    
-- 방법 : 조건절에서 비교     --결과 70건 .. 수정 중 
SELECT
    employee_id   "직원번호",
    first_name    "이름",
    salary        "급여",
    department_id "부서아이디"
FROM
    employees
WHERE
    salary > ANY (
        SELECT
            round(AVG(salary), 0) "평균 급여"
        FROM
            employees
        GROUP BY
            department_id
    );
    
-- 방법 : 테이블에서 조인
SELECT
    em.employee_id "직원번호",
    em.first_name  "이름",
    em.salary      "급여"
    -- s.avgsalary "평균급여"
FROM
    employees em,
                    ( -- 평균급여 테이블 s 
                        SELECT
                            department_id,
                            AVG(salary) avgsalary
                        FROM
                            employees
                        GROUP BY
                            department_id
                    )s
WHERE
        em.department_id = s.department_id
    AND em.salary > s.avgsalary;

/*
문제8. -- >> rownum 사용
직원 입사일이     -- hire_date
11번째에서 15번째의    -- WHERE rn >= 11 AND rn <= 15
직원의 사번, 이름, 급여, 입사일을    -- employee_id, first_name, salary, hire_date
입사일 순서로 출력하세요   -- hire_date asc;
*/

-- 1) 입사일 순서로 출력
SELECT
    employee_id "직원의 사번",
    first_name "이름",
    salary "급여",
    hire_date "입사일"
FROM
    employees
ORDER BY
    hire_date ASC;

-- 2) rownum 사용        
SELECT
    ROWNUM rn,
    ot.employee_id,
    ot.first_name,
    ot.salary,
    ot.hire_date
FROM
    ( -- 정렬시킨 ot 테이블 생성 : (order 해결)
        SELECT
            employee_id,
            first_name,
            salary,
            hire_date
        FROM
            employees
        ORDER BY
            hire_date ASC
    )ot ;

-- 3) 직원 입사일이 11번째에서 15번째 조건 붙이시
SELECT
    ort.rn,
    ort.employee_id "직원의 사번",
    ort.first_name  "이름",
    ort.salary      "급여",
    ort.hire_date   "입사일"
FROM
    ( --rownum 생성 : (조건절 해결)
        SELECT
            ROWNUM rn,
            ot.employee_id,
            ot.first_name,
            ot.salary,
            ot.hire_date
        FROM
            ( -- 정렬시킨 ot 테이블 생성 : (order 해결)
                SELECT
                    employee_id,
                    first_name,
                    salary,
                    hire_date
                FROM
                    employees
                ORDER BY
                    hire_date ASC
            ) ot
    ) ort  -- >> 정렬+ ROWNUM시킨 ort 테이블 생성
WHERE
        rn >= 11
    AND rn <= 15;
