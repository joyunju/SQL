/*■ 혼합 SQL 문제입니다.*/

/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/

/*
문제2.
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하
세요
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/

/*
문제3
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매
니저별최대급여 입니다.
(9건)
*/

/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/

/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

SELECT
    rn,
    employee_id "직원의사번",
    first_name "이름",
    department_name "부서명",
    salary "급여",
    hire_date "입사일"
FROM
    (
        SELECT
            ROWNUM rn,
            employee_id,
            first_name,
            department_name,
            salary,
            hire_date
        FROM
            (
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
            )
    )
WHERE
        rn >= 11
    AND rn <= 20;


/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름
(department_name)은?
*/

/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 연봉(salary)을 조회하시오.
*/

/*
문제8.
평균 급여(salary)가 가장 높은 부서는?
*/

/*
문제9.
평균 급여(salary)가 가장 높은 지역은?
*/

/*
문제10.
평균 급여(salary)가 가장 높은 업무는?
*/
