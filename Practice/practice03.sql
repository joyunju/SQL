-- ■ 테이블간 조인(JOIN) SQL 문제입니다.
-- 0513 문제1,2,3,4,6,7,8

/*문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 조회하여
부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
(106건)*/

-- ■ 처리방법
-- from : employees, departments
-- WHERE : em.department_id = de.department_id;
-- GROUP BY : 
-- having :
-- SELECT / 출력 :  em.department_id, first_name, last_name, department_name
-- ORDER BY / 정렬 : department_name 오름차순 ASC, employee_id 내림차순 DESC

SELECT
    em.department_id   "직원들의 사번",
    em.first_name         "이름",
    em.last_name          "성",
    de.department_name "부서명"
FROM
    employees   em,
    departments de
WHERE
    em.department_id = de.department_id
ORDER BY
    department_name ASC,
    employee_id DESC;
    

/*문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현재업무(job_title)를
사번(employee_id) 오름차순 으로 정렬하세요.
※ 부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)*/

-- ■ 처리방법
-- from : employees, departments, jobs
-- WHERE : 
-- em.department_id = de.department_id and em.department_id = jo.job_id
-- GROUP BY : 
-- having :
-- SELECT / 출력 : employee_id "직원들의 사번", firt_name "이름", salary "급여", department_name "부서명", jobs.job_title "현재업무"
-- ORDER BY / 정렬 : employee_id 오름차순 ASC

SELECT
    em.employee_id     "직원들의 사번",
    em.first_name      "이름",
    em.salary          "급여",
    de.department_name "부서명",
    jo.job_title       "현재업무"
FROM
    employees   em,
    departments de,
    jobs        jo
WHERE
        em.department_id = de.department_id
    AND em.job_id = jo.job_id
ORDER BY
    em.employee_id ASC;


/*문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)*/

-- ■ 처리방법
-- from : employees, departments, jobs
-- WHERE : em.department_id = de.department_id and em.department_id = jo.job_id
-- ㄴ NULL이 올 수 있는 쪽 조건에 (+)를 붙인다.
-- GROUP BY : 
-- having :
-- SELECT / 출력 : employee_id "직원들의 사번", firt_name "이름", salary "급여", department_name "부서명", jobs.job_title "현재업무"
-- ORDER BY / 정렬 : employee_id 오름차순 ASC

SELECT
    em.employee_id     "직원들의 사번",
    em.first_name      "이름",
    em.salary          "급여",
    de.department_name "부서명",
    jo.job_title       "현재업무"
FROM
    employees   em,
    departments de,
    jobs        jo
WHERE
        em.department_id = de.department_id (+)
    AND em.job_id = jo.job_id
ORDER BY
    em.employee_id ASC;


/*문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를
도시아이디(오름차순)로 정렬하여 출력하세요
부서가 없는 도시는 표시하지 않습니다.
(27건)*/

-- ■ 처리방법
-- from : departments, locations
-- WHERE : departments.department_id = locations.location_id
-- GROUP BY : 
-- having :
-- SELECT / 출력 : location_id "도시아이디", city "도시명", department_name "부서명", department_id "부서아이디"
-- ORDER BY / 정렬 : 도시아이디 오름차순 location_id  ASC

SELECT
    loc.location_id    "도시아이디",
    loc.city           "도시명",
    de.department_name "부서명",
    de.department_id   "부서아이디"
FROM
    departments de,
    locations   loc
WHERE
    de.location_id = loc.location_id
ORDER BY
    loc.location_id ASC;
    

/*문제3-1.
문제3에서 부서가 없는 도시도 표시합니다.
(43건)*/

SELECT
    loc.location_id    "도시아이디",
    loc.city           "도시명",
    de.department_name "부서명",
    de.department_id   "부서아이디"
FROM
    departments de,
    locations   loc
WHERE
    de.location_id (+) = loc.location_id
ORDER BY
    loc.location_id ASC;

/*문제4.
지역(regions)에 속한 나라들을 
지역이름(region_name), 나라이름(country_name)으로 출력하되
지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)*/

-- ■ 처리방법
-- from : countries, regions 
-- WHERE : countries.country_id = regions.region_id
-- GROUP BY : 
-- having :
-- SELECT / 출력 : region_name "지역이름", country_name "나라이름"
-- ORDER BY / 정렬 : region_name ASC, country_name DESC

SELECT
    re.region_name  "지역이름",
    co.country_name "나라이름"
FROM
    countries co,
    regions re
WHERE
    co.region_id = re.region_id
ORDER BY
    region_name ASC,
    country_name DESC;
    
/*문제5. -- self join
자신의 매니저보다 채용일(hire_date)이 빠른 사원의
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입사일(hire_date)을 조회하세요.
(37건)*/ 

-- ■ 처리방법
-- from : employees em1, employees em2
-- WHERE : 
-- GROUP BY : 
-- having :
-- SELECT / 출력 : employee_id "사번", first_name "이름, hire_date "채용일", first_name "매니저이름", hire_date "매니저입사일"
-- ORDER BY / 정렬 : 

SELECT
    emp.employee_id " 사번",
    emp.first_name  "이름",
    emp.hire_date   "채용일",
    man.first_name  "매니저이름",
    man.hire_date   "매니저입사일"
FROM
    employees emp,
    employees man
WHERE
        emp.manager_id = man.employee_id
    AND emp.hire_date < man.hire_date;

/*SELECT
    hire_date 
    FROM employees;*/

/*문제6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를
나라명(오름차순)로 정렬하여 출력하세요.
값이 없는 경우 표시하지 않습니다.
(27건)*/

-- ■ 처리방법
-- from : departments, loactions, countries
-- WHERE : 
-- GROUP BY : 
-- having :
-- SELECT / 출력 : country_name "나라명", country_id "나라아이디", city "도시명", location_id "도시아이디", department_name "부서명", department_id "부서아이디"
-- ORDER BY / 정렬 : country_name ASC

SELECT
    co.country_name    "나라명",
    co.country_id      "나라아이디",
    lo.city            "도시명",
    lo.location_id    "도시아이디",
    de.department_name "부서명",
    de.department_id   "부서아이디"
FROM
    departments de,
    locations   lo,
    countries   co
WHERE
        de.location_id = lo.location_id
    AND lo.country_id = co.country_id
ORDER BY
    co.country_name ASC;


/*문제7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한
사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
(2건)*/

-- ■ 처리방법
-- from : job_history, employees
-- WHERE : 테이블 연결 and 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한
-- GROUP BY : 
-- having :
-- SELECT / 출력 : 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력
-- ORDER BY / 정렬 : 

SELECT
    em.employee_id "사원의 사번",
    first_name || ' ' || last_name AS "이름(풀네임)",
    joh.job_id "업무아이디",
    joh.start_date "시작일",
    joh.end_date "종료일"
FROM
    job_history joh,
    employees   em
WHERE
        em.employee_id = joh.employee_id
    AND joh.job_id = 'AC_ACCOUNT';


/*문제8.
각 부서(department)에 대해서
부서번호(department_id), 부서이름(department_name),
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름
(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)*/

-- ■ 처리방법
-- from : employees
-- WHERE : 테이블 연결 and 
-- GROUP BY : 
-- having :
-- SELECT / 출력 : 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력
-- ORDER BY / 정렬 : 

SELECT
    de.department_id   "부서번호",
    de.department_name  "부서이름",
    em.first_name       "매니저이름",
    lo.city       "위치한 도시",
    co.country_name   "나라이름",
    re.region_name     "지역이름"
FROM
    employees   em,
    departments de,
    locations   lo,
    countries   co,
    regions     re
WHERE
        em.employee_id = de.manager_id
    AND de.location_id = lo.location_id
    AND lo.country_id = co.country_id
    AND co.region_id = re.region_id;



/*
문제9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/