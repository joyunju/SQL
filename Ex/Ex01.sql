--일반 행 주석 : ctrl + /
/*범위 주석 : alt + shift + c*/
-- 자동 정렬 : ctrl + f7
-- 현재 쿼리 실행 : ctrl + enter / f9

-- >> SELECT문 기본 

SELECT
    *
FROM
    employees;

SELECT
    *
FROM
    departments;
--범위만 선택해서 쿼리 실행 가능! / 원하는 범위 커서 두고 ctrl + enter 가능 

-- *대신 보고 싶은 열명 작성  
SELECT
    employee_id, first_name, phone_number
FROM
    employees;