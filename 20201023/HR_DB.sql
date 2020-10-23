show user;
desc employees;
--테이블에 어떤 필드들이 정의되어 있는 지 확인 

select * from tab;
--테이블 조회
select * from employees;
--직원 테이블의 모든 것을 조회

select employee_id,last_name
from employees
where last_name ='ostin';
--직원테이블에서 오스틴이라는 lastname을 가진 사람의 id와 last name을 조회한다

select employee_id,last_name
from EMPLOYEES
where LAST_NAME = 'Smith';
--직원테이블에서 lastname이 smith인 사람의 id, last name을 조회한다

desc employees;
--직원테이블의 구조

select * from EMPLOYEES;
--지원 테이블 조회

select emplyee_id, salary from employees
where last_name = 'Smith';
--lastname 안에는 대소문자 구별

select emplyee_id, FIRST_NAME, salary from employees
where last_name = 'smith';
--lastname 안에는 대소문자 구별

select employee_id as "준이", salary as "샐러리"
from employees;
select employee_id "준이", salary "샐러리" from employees;
select employee_id as "준이" from employees
where last_name = 'Smith';
-- as id 는 한글로 사용가능
select distinct job_id from Employees;
--중복제거
