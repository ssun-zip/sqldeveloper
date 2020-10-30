-- 2020/10/30
/*서브쿼리 */
select round (avg(salary)) from employees;

select employee_id , first_name, last_name
from employees where salary < 6463; 
--위에서 구한 평균급여보다 작은 

select employee_id, first_name, last_name from employees
where salary < round(avg(salary));
--where절에서 집계함수 사용불가 ; group function is not allowed here

--서브쿼리문을 사용하여 고쳐보기
select employee_id, first_name, last_name  --메인쿼리 
from employees
where salary < (select round(avg(salary))from employees);
--쿼리안에 select를 이용하여 서브쿼리문을 사용함. 

select location_id from locations 
where state_province is null;

select * from departments;

/*
1. 서브쿼리는 괄홀로 묶여서 기술해야한다.
2. 서브쿼리는 비교 연산자의 우측에 위치해야한다.
3. 단일 행 서브쿼리에는 단일 행 비교 연산자 ( > = >= < <= <>)만 사용 가능
4. 서브쿼리에 order by절을 포함할수있다.
5. select문의 from절, where절, having절에서만 사용할수있다.
6. 다중행 서브쿼리에는 다중행 비교 연산자 (in, any, all)만 사용가능하다.
7. 다중열서브쿼리에는 서브쿼리가 반환한 두개이상의 열을
한꺼번에 비교하기 위해서, in연산자를 사용해야한다. (권장한다) =도 사용가능
*/

select * from departments where location_id 
in (select location_id from locations where country_id = 'US');
--in연산자 사용하여 다중값 출력 

--문제:in연산자를 사용해서 로케이션아이디가 1400, 1500, 1700인걸 출력해보기
select * from departments where location_id in (1400, 1500, 1700);

-------------------------------------------------------
--월급이 가장 적은 사원
--별칭을 이용해서 구해보기
select emp.first_name, emp.last_name, job.JOB_TITLE
from employees emp, jobs job --별칭이용
where emp.salary = (select min(salary) from employees)
and emp.job_id = job.job_id; --월급이 가장 적은 사원

--월급이 가장 많은 사원 구해보기
select emp.first_name, emp.last_name, job.JOB_TITLE
from employees emp, jobs job --별칭이용
where emp.salary = (select max(salary) from employees)
and emp.job_id = job.job_id;

--any 아무나, all
select salary from employees where department_id = 20;
--두명이나온다 

select employee_id, department_id, salary from employees
where salary > any (select salary 
--6000 13000위에 두명 6000이상나오게 된다. 
from employees where department_id = 20);
-- 20부서의 사람급여인 두명인데, 여기서 최소가 6000이다.
--이 사람보다 많이 받는것을 조회하는 겁니다. 


select employee_id, department_id, salary from employees 
where salary > all(select salary 
--6000 13000이중에 모든것보다 커야한다. 그래서 13000명 이상 나와야한다. 
from employees where department_id = 20);

select employee_id, department_id, salary from employees 
where salary > (select max(salary )
from employees where department_id = 20);


select employee_id, department_id, salary from employees --다중값 in이용 
where salary in (select salary 
from employees where department_id = 20);

-- 다음문제는 서브커리중 어떤 형태인지 구체적으로 명칭을 적으세요
select employee_id, department_id, salary from employees
where (manager_id, job_id) in ( select manager_id, job_id 
                from employees where first_name = 'Bruce')
                and first_name <> 'Bruce';

-- 셀렉트문에 여러개의 컬럼을 검색한다. 반드시 비교대상 컬럼과 1:1 대응되야한다.
-- 브루스와 동일한 상사이면서 같은 직업인 사원을겁색한 것이다.
-- >> 다중 열 서브 쿼리 

select manager_id, job_id from employees where first_name = 'Bruce';
--서브쿼리만 보면 검색조건에 기술하는 컬럼들이 1:1 대응하여 모두 같아야 검색된다.
--검색조건이 동시에 검색된 두개의 컬럼과 비교될때 다중열 서브쿼리를 이용한다.


select employee_id, first_name, job_id, salary
from employees where manager_id in 
        (select manager_id from employees where first_name = 'Bruce')
        and job_id in 
        (select job_id from employees where first_name = 'Bruce')
    and first_name <> 'bruce';
    
--그룹 함수를 이용하여 각 부서별로 최소급여를 받는 사원의 정보를 구하라
--조건은 각 부서의 번호와 최소급여가 둘 다 일치하는 사원을 찾는 문제이다.
select department_id, employee_id, first_name, job_id, salary
from employees
where (department_id, salary) in
(select department_id, min(salary) from employees
group by department_id) order by department_id;
/*
10	    200	    Jennifer	    AD_ASST	4400
20	    202	    Pat	        MK_REP	    6000
... 
12개의 행이 나오게 된다. 
*/

------------------------- HRDB_11 ----------------------
/*view*/-- 가상의 논리적공간을 만드는
drop view v_emp;
create view v_emp(emp_id, first_name, job_id, hiredate, dept_id) as
select employee_id, first_name, job_id, hire_date, department_id
from employees
where job_id = 'ST_CLERK';

-- 대문자주의 id// as 이하절에서 논리적인 집합안에서 가져올수잇다
select * from v_emp;
create view v_emp1(emp_id, first_name, job_id, hiredate, dept_id) as
select employee_id, first_name, job_id, hire_date, department_id
from employees
where job_id = 'SH_CLERK';-- 대문자로 id

--수정할때 하는뷰명령어
create or replace view v_emp(emp_id, first_name, job_id, hiredate, dept_id) as
select employee_id, first_name, job_id, hire_date, department_id
from employees
where job_id = 'ST_CLERK';
select * from v_emp;


--입사일을 기준으로 오름차순 정렬한후 rownum컬럼 출력하기
select ROWNUM,emp_id, first_name, job_id, hiredate, dept_id
from v_emp
order by hiredate;


--입사일이 빠른 9명만을 얻어오기 rownum where조건을 주어서해보기
--emp_id, first_name, job_id, hiredate, dept_id
select ROWNUM,emp_id, first_name, job_id, hiredate, dept_id
from v_emp
where rownum<=9;

--v_emp3뷰만들기 아이디와 퍼스트네임이 널이면 널처리해주기
--emp_id, first_name, job_id, hiredate, dept_id
--job_id = 'SH_CLERK'
--nvl함수를이용하면 null이면 수정할수없도록 함수를 이용하는것이다--정보보안
create or replace view v_emp3(emp_id,first_name,job_id,hiredate,dept_id) as
select nvl(employee_id, null), nvl(first_name,null), 
           job_id, hire_date, department_id
from employees --nvl함수는 employee_id가 null이면 널로처리하겟다
where job_id = 'SH_CLERK';
desc v_emp3;
select * from v_emp3;


--수정하려고하지만 <함수를이용해서 가상열>은 허용수정이안된다
update v_emp3 set first_name = 'kim'
where first_name = 'Julia';

--<함수를사용안하면> 수정이 된다
update v_emp set first_name = 'kim'
where first_name = 'Julia';
select * from v_emp;

--(salary + nvl(commission_pct,0))*12 연봉구하기연산식
--v_emp_salary(emp_id, last_name, annual_sal)
--emplyees테이블로부터 구하기
create view v_emp_salary(emp_id, last_name, annual_sal) as
select employee_id, last_name, (salary+nvl(commission_pct, 0))*12
--commision_pct 항목이 0이면 널로 처리하겟다<연봉연산구하기>
from employees;

--nvl함수는 commission_pct가 0이면 널로처리하겟다
select * from v_emp_salary;


--WITH READ ONLY 옵션은 뷰를 통해서는 기본 테이블의 어떤 컬럼에 대해서도 내용을
--절대 변경할 수 없도록 하는 것
create view v_emp_readonly(emp_id, last_name, annual_sal) as
select employee_id, last_name, (salary+nvl(commission_pct, 0))*12 
from employees
with read only;-- 데이터를 수정할수없도록하는 또하나의 방법
desc v_emp_readonly;


select * from v_emp_readonly;
update v_emp_readonly set last_name = 'kim'
where last_name = 'Grant';--수정할수없다 



--컴퓨터에서 인식하는 날짜중 첫번째 날짜는 1900년 1월 1일입니다.
--이걸 숫자로 변환하면 0이되구요.그래서 날짜를 숫자처럼 사용
--또한 오늘날짜에서 3일전 날짜를 구하고자 한다면 SYSDATE - 3 사용가능
--수정하는view테이블명령어 create or replace view를 사용한다
--년봉4만이넘고,부서는50,잡아이디는ST_CLERK 이고 5년이상근무해야한다
--employees 테이블로부터employee_id, last_name, department_id,
--hire_date,job_id를 구해보기 v_samp1로 만드세요
create or REPLACE view v_samp1 as
select employee_id, last_name, department_id, hire_date,job_id
from employees
where (salary + nvl(commission_pct,0))*12 > 40000
and department_id = 50
and job_id ='ST_CLERK'
and sysdate - 365 * 5> hire_date;
select * from v_samp1;

--------------------------------------------------------------0502
--view 사원 (사번, 이름, 부서번호, 입사일)구하고,부서번호는 50
--퍼스트네임과 라스트네임사이를 띄어주세요<문자열결합>
create view 사원 (사번, 이름, 부서번호, 입사일) as
select employee_id, first_name||' '||last_name, department_id, hire_date
from employees
where department_id = 50;
select * from 사원;
drop view v_join;
create view v_join(사번, 이름, 부서번호, 부서명, 입사일) as
select emp.employee_id, emp.first_name||' '||emp.last_name, 
       emp.department_id, --부서번호
--||'띄어쓰기 '||문자열결합
dept.department_name, emp.hire_date
from employees emp, departments dept
where emp.department_id = dept.department_id;
--조인조건 부서번호가 같은경우
select * from v_join;

--------------------------- HR_DB-12----------------------------
/*시퀀스(sequence): 연속적인 번호를 만들어주는 기능 
 구문형식 
create sequence 시퀀스 이름
   increment by n <- n: 증가값을 설정 2: 2씩 증가 / 기본값: 1 설정   
   start with n <- 시작값 설정 / 기본값은 1
   maxvalue n | nomaxvalue <- 시퀀스 최대값을 설정
   minvalue n | nominvalue <- 시퀀스 최소값을 설정 : 
                              cycle 옵션일경우 시작값
   cycle | nocycle <-시퀀스를 순환 사용할지를 설정
   cache n | nocache <- 시퀀스의 속도를 개선하기위해 캐싱여부 지정
   데이터 접근을 빠르게 할 수 있도록 미래의 요청에 대비해 데이터를 
             저장해 두는 임시 장소를 말한다
*/

/* 시퀀스 생성 : 제품번호 생성하는 시퀀스 만들기*/
create sequence seq_serial_no  --이 이름으로 값을 넣게된다
increment by 1  --1씩증가
start with 100  --100으로시작
maxvalue 110   --최대값까지가면
minvalue 99    --다시 최소값으로 
cycle         --순환
cache 2;      

create table good(
  good_no number(3),
  good_name varchar2(10)
);

drop table good; --삭제하고 다시해도 seq 번호가 증가한다

insert into good 
values(seq_serial_no.nextval, '제품1'); /*nextval: 다음값*/
select sequence_name, min_value, max_value,
         increment_by, cycle_flag
from user_sequences;

select * from good;

insert into good 
values(seq_serial_no.currval, '제품2'); /*currval:현재값*/
select seq_serial_no.currval from dual; -- 현재값을 확인하는
--13개의 nextval게속 데이터를 넣어보고,12번째 110이넘어가면
--다시 99번째로 순환한다 그담 100 101..

-----------------------------------------------------5교시
create table good2(
  good_no number(3),
  good_name varchar2(10)
);
create sequence seq_serial_no2 --시퀀스를 다시 생성
increment by 1
start with 100
maxvalue 105     --minvalue를 생략
cache 2;
insert into good2
values(seq_serial_no2.nextval,'제품1');
select seq_serial_no2.currval from dual;
commit;

select * from good2;
drop sequence seq_serial_no2;

/* 시퀀스 삭제 
drop sequence seq_serial_no2;   =>시퀀스명
*/
--sqlplus에서 데이터베이스 시작하는명령어 startup; 
--강제종료 shutdown abort;
--shutdown abort강제종료가 발생하더라도 다시접속해서
--seq증가하면서 다음value로 잡힌다 cache에 대한설명하려고
