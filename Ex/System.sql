/*
>> 계정관리
관리자 계정으로 접속: sqlplus system/manager
*/

-- 계정 생성
create user webdb identified by 1234;

-- 접속권한 부여
grant resource, connect to webdb;

-- 계정 비밀번호 변경 : 비밀번호가 1234에서 webdb로 바뀜
alter user webdb identified by webdb;

-- 계정 삭제 : webdb 계정 삭제하기
DROP USER webdb CASCADE;
/*계정 삭제시, ORA-01940: cannot drop a user that is currently connected
이 오류가 자주 나타는데, 연결된 계정을 종류해야 실행이 가능함
: 오른쪽 접속 탭에서 webdb 오른쪽 마우스 > 접속 해제 누른 후, 계정 삭제 진행*/

-- 계정 생성
create user webdb identified by webdb;

-- 접속권한 부여
grant resource, connect to webdb;