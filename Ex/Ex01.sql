--일반 행 주석 : ctrl + /
/*범위 주석 : alt + shift + c*/
-- 자동 정렬 : ctrl + f7
-- 현재 쿼리 실행 : ctrl + enter / f9

-- >> SELECT문 기본 
-- : 오라클에서 데이터를 조회하는 명령어는 SELECT
-- 모든 컬럼 조회하기 : * 을 사용
SELECT
    *
FROM
    employees;

SELECT
    *
FROM
    departments;
    
--범위만 선택해서 쿼리 실행 가능! / 원하는 범위 커서 두고 ctrl + enter 가능 

-- 원하는 컬럼만 조회하기 : (원하는 컬럼 이름을 지정)
-- *대신 보고 싶은 열명 작성  
SELECT
    employee_id, first_name, phone_number
FROM
    employees;
   
-----------------------------------------
--05.12.목요일
/***********************
select 문
    select 절
    from 절
    where 절
    order by 절
***********************/

-- 모든 컬럼 조회하기
SELECT
    *
FROM
    employees;

SELECT
    *
FROM
    departments;
    
-- 원하는 컬럼만 조회하기
-- 사원의 이름과 전화번호, 입사일 연봉을 출력하세요
-- SELECT(←데이터 조회해줘 라는 명령어) (조회 하고 싶은 영역쓰기) FROM 테이블명
SELECT
    first_name,
    phone_number,
    hire_date,
    salary
FROM
    employees;

-- 문제) 사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
--  컬럼명이 많을때 표기팁
SELECT
    first_name,
    last_name,
    salary,
    phone_number,
    email,
    hire_date
FROM
    employees;

-- 출력할 때 컬럼에 별명 사용하기
-- 사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
SELECT
    --컬럼 이름을 변경하여 출력(원 컬럼이름은 변경되지 않으며 임시로 보여주는 형태)
    first_name   "이름", 
    phone_number "전화번호",
    hire_date    "입사일",
    salary       "급여"
FROM
    employees;
    
-- 사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
SELECT
    first_name   AS 이름,
    last_name    성,
    salary       "salary",
    phone_number "hp",
    email        "이메일",
    hire_date    입사일
FROM
    employees;

-- 연결연산자 (컬럼을 붙이기)
SELECT
    first_name,
    last_name
FROM
    employees;
-- 연결연산자 ||로 컬럼을 붙이기)
SELECT
    first_name || last_name
FROM
    employees;
    
-- 공백을 주고 싶을 때
SELECT
    first_name
    || ' '
    || last_name
FROM
    employees;
    
-- ''(따옴표)를 사용해 문자를 추가하여 출력할 수 있음

SELECT
    first_name
    || ' hire date is '
    || hire_date AS 입사일
FROM
    employees;
    
-- >> 산술 연산자 사용하기 : +, -, *, / 을 사용할 수 있음
SELECT
    first_name,
    salary,
    salary * 12,  -- 12를 곱해줌
    ( salary + 300 ) * 12
FROM
    employees;
    
-- 산술 연산자사용 예제 오류 찾기 
SELECT
    job_id * 12 
    -- 업무 아이디 *12 결과 값 없어서 오류
FROM
    employees;
    
-- 전체직원의 정보를 다음과 같이 출력하세요
SELECT
    first_name
    || ' - '
    || last_name       "성명",
    salary             "급여",
    salary * 12        "연봉",
    salary * 12 + 5000 "연봉2",
    phone_number       AS 전화번호
FROM
    employees;

-- >> WHERE절
-- 비교연산자
-- =, !=, >, <, >=, <= 연산자 사용
-- 부서번호가 10인 사원의 이름을 구하시오
SELECT
    first_name
FROM
    employees
WHERE
    department_id = 10;
    
-- 예제 : 연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 15000;
    
-- 예제 : 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
-- 문자, 날자는 ‘ ‘ 로 감싸줌 ‘ ‘는 대소문자를 구분한다
SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date >= '07/01/01';

-- 이름이 Lex인 직원의 연봉을 출력하세요
SELECT
    salary
FROM
    employees
WHERE
    first_name >= 'Lex';
-- >> 조건이 2개이상 일때 한꺼번에 조회하기
-- and 사용 / OR / 
-- 예제 : 연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
SELECT
    first_name,
    salary
FROM
    employees
WHERE
        salary >= 14000
    AND salary <= 17000;
-- 예제2 :  연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary <= 1400
    OR salary >= 1700;
    
-- 예제3 : 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '04/01/01'
    AND hire_date <= '05/12/31';
-- >> BETWEEN 연산자로 특정구간 값 출력하기
-- 작은 값을 앞에, 큰 값을 뒤에 작성 (경계 값을 포함하지 않는 경우 사용하면 안됨)
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary BETWEEN 1400 AND 17000;

-- >> IN 연산자로 여러 조건을 검사하기
SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    first_name IN ( 'Neena', 'Lex', 'John' );
-- 위에 식을 and, or도 똑같이 결과값 출력해보기
SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    first_name = 'Neena'
    OR first_name = 'Lex'
    OR first_name = 'John';

-- 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary IN ( 2100, 3100, 4100, 5100 );
-- or 표현
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary = 2100
    OR salary = 3100
    OR salary = 4100
    OR salary = 5100;
    

-- >> Like 연산자로 비슷한것들 모두 찾기
SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    first_name LIKE 'L%'; -- 'L'뒤에 어떤 글자가 오든 L로 시작하는 이름 불러줘 
    --first_name like 'L___'; -- '_'은 한글자 길이 뜻함 : 'L' 로 시작하는 4글자 이름 찾아줘
    
-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '%am%';
    
-- 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '_a%';

-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '___a%';
    
-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '__a_%';

-- NULL : 아무런 값도 정해지지 않았음을 의미 (0이 아님)
SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct
FROM
    employees
WHERE
    salary BETWEEN 13000 AND 15000;
-- null인 값만 불러줘 할때 =을 사용하지 않고 is null 사용!!!
SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct
FROM
    employees
WHERE
    commission_pct IS NULL;
    -- null 이 아닌 사람만 불르고 싶을 떄 ↓
    --commission_pct is not null;
    
-- 예제 문제
-- 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
SELECT
    first_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NOT NULL;
    
-- 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
SELECT
    first_name
FROM
    employees
WHERE
    commission_pct IS NOT NULL
    AND manager_id IS NOT NULL;
    
-- >> order by 절을 사용해 보기 좋게 정렬하기
SELECT
    first_name,
    salary
FROM
    employees
ORDER BY
    salary DESC;
    -- 내림차순 (큰 것 부터)
    
-- 오름차순 ( 작은 숫자부터 ) : asc
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 9000
ORDER BY
    salary ASC;

-- [예제]
-- 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
SELECT
    department_id,
    salary,
    first_name
FROM
    employees
ORDER BY
    department_id ASC;

-- 급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 10000
ORDER BY
    salary DESC;
    
-- 부서번호를 오름차순으로 정렬하고 (ORDER BY) 부서번호가 같으면 급여가 높은 사람부터
-- 부서번호 급여 이름을 출력하세요
SELECT
    department_id,
    salary,
    first_name
FROM
    employees
ORDER BY
    department_id ASC, salary DESC, first_name DESC;
    
-- >> 단일행 함수 : 각각의 데이터를 한건씩 처리
-- 문자 함수 : INITCAP(컬럼명)
-- 부서번호 100인 직원의 이메일 주소화 부서번호를 출력하세요
SELECT
    email,
    INITCAP(email) "첫글자만 대문자 출력",
    department_id
FROM
    employees
WHERE
    department_id = 100;

-- >> 문자 함수 : LOWER(컬럼명) / UPPER(컬럼명)
SELECT
    first_name,
    upper(first_name) "대문자",
    lower(first_name) "소문자"
FROM
    employees
WHERE
    department_id = 100;

-- >> 문자함수 – SUBSTR(컬럼명, 시작위치, 글자수)
-- 주어진 문자열에서 특정길이의 문자열을 구하는 함수
SELECT
    first_name,
    substr(first_name, 1, 3) "첫번째부터세번째까지",
    substr(first_name, - 3, 2) "- 는 뒤에서부터"
FROM
    employees
WHERE
    department_id = 100;
    
-- >> 문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) / RPAD(컬럼명, 자리수, ‘채울문자’)
-- LPAD() :왼쪽 공백에 특별한 문자로 채우기
-- RPAD() :오른쪽 공백에 특별한 문자로 채우기
SELECT
    first_name,
    lpad(first_name, 10, '*'),
    rpad(first_name, 10, '*')
FROM
    employees;

-- >> 문자함수 – REPLACE (컬럼명, 문자1, 문자2)
-- 컬럼명에서 문자1을 문자2로 바꾸는 함수
SELECT
    first_name,
    replace(first_name, 'a', '*'),
    substr(first_name, 2, 3),
    replace(first_name, substr(first_name, 2, 3), '***')
FROM
    employees
WHERE
    department_id = 100;
    
-- 테이블이 없을 때 문자함수 테스트 해보고 싶을 때 : FROM dual; 사용 
SELECT
    replace('abcdefg', 'bc', '******')
FROM
    dual;
--
SELECT
    substr('900214-1234234', 8, 1)
FROM
    dual;

-- >> 숫자함수 : ROUND(숫자, 출력을 원하는 자리수)
-- : 주어진 숫자의 반올림을 하는 함수
SELECT
    round(123.346, 2) "r2",
    round(123.556, 0) "r0",
    round(123.456, -1) "r -1"
FROM
    dual;

-- 숫자함수 – TRUNC(숫자, 출력을 원하는 자리수)
-- : 주어진 숫자의 버림을 하는 함수
SELECT
    TRUNC(123.346, 2) "r2",
    TRUNC(123.556, 0) "r0",
    TRUNC(123.456, -1) "r -1"
FROM
    dual;

-- 날짜함수의 종류 : SYSDATE()
-- 현재날짜와 시간을 출력해주는 함수
SELECT
    sysdate
FROM
    dual;
-- 단일함수>날짜함수 – MONTH_BETWEEN(d1, d2)
-- d1날짜와 d2날짜의 개월수를 출력하는 함수
-- 가상 테이블 dual 사용
SELECT
    months_between('22/05/12', '22/04/12')
FROM
    dual;
-- 
SELECT
    months_between(sysdate, hire_date)
FROM
    employees
WHERE
    department_id = 110;
-- >> 단일행 함수 : TO_CHAR(숫자, ‘출력모양’) 숫자형문자형으로 변환하기
SELECT
    first_name,
    to_char(salary*12, '$099999')
FROM
    employees
WHERE
    department_id = 110;
-- TO_CHAR(숫자, ‘출력모양’) 숫자형문자형으로 변환하기 / dual 테이블 사용
SELECT
    to_char(9876, '99999'),
    to_char(9876, '099999'),
    to_char(9876, '$99999'),
    to_char(9876, '9999.99'),
    to_char(987654321, '999,999,999'),
    to_char(987654321, '999,999,999,999')
FROM
    dual;

-- 단일함수>변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하기
SELECT
    sysdate,
    to_char(sysdate, 'YYYY-MM-DD'),
    to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS'),
    to_char(sysdate, 'YYYY"년"MM"월"DD"일" HH24:MI:SS'),
    to_char(sysdate, 'YYYY'),
    to_char(sysdate, 'YY'),
    to_char(sysdate, 'MM'),
    to_char(sysdate, 'MONTH'),
    to_char(sysdate, 'DD'),
    to_char(sysdate, 'DAY'),
    to_char(sysdate, 'HH24'),
    to_char(sysdate, 'MI'),
    to_char(sysdate, 'SS')
FROM
    dual;