/*sysdate()*/
select sysdate from dual;--더미테이블 현재날짜
--result : 20/10/26
-- 시스템에 저장된 오늘의 날짜를 출력

/*months_between()*/
select * from EMPLOYEES;
-- 직원정보를 출력하기 

select first_name, last_name, months_between(sysdate, hire_date)
--현재날짜에서 이전날짜 근무개월수
FROM EMPLOYEES
where department_id = 50;
--현재 날짜에서 이전날짜  근무 개월

/*add_months()*/--개월수 더하기
select add_months(sysdate, 7) from dual;--현재4월+7
/*next_day()*/
select next_day(sysdate, '일요일') from dual;
--현재 날짜에서 다음 일요일이 나온다
/*last day()*/
select last_day(sysdate) from dual;
--해당월의 마지막 날짜가 나온다
/*to_char()*/
select to_char(sysdate, 'yyyy/mm/dd') from dual;
--현재날자까 형식대로나오기
/*to_date()*/
select to_date('2015/03/04','yyyy/mm/dd') from dual;

-----------------------------------------------------------
/*nvl(): 널값을 다른 데이터로 변경하는 함수*/ 
select * from EMPLOYEES;
select first_name, last_name, nvl(commission_pct, 0) commission 
       from EMPLOYEES;
--널값을 0으로표기하고 commission바꾸기


/*decode(): switch문의 역할을 하는 함수*/
select * from DEPARTMENTS;
select department_id, 
decode(department_id, 20, '마케팅부', 60, '전산', 90,'경영부', '부서')
from EMPLOYEES;--20이면 마케팅부 60이면 전산 나머지면 부서로 출력
/*case() : elseif문과 같은 역할 함수*/
select first_name, department_id, 
  case when department_id = 20 then '마케팅부'
       when department_id = 60 then '전산실'
       when department_id = 90 then '경영부'
       else '' 
       end "부서명"
from EMPLOYEES;
---------------------------------------------------------------
/* group by 절 중복제거후 아이디구하기*/
select distinct department_id from EMPLOYEES;

/* ORA-00937: 단일 그룹의 그룹 함수가 아닙니다*/
select distinct department_id, sum(salary)
from employees;

/* 부서별 급여 합계 */
select department_id, sum(salary) 
from EMPLOYEES
group by department_id;

/* 부서별 사원수와 평균 급여를 구해보자 */
select department_id, sum(salary), count(salary), avg(salary)
from employees;
/* 부서별 직급별 사원수와 평균 급여를 구하는 예*/
--select에서 department_id, job_id는 group by에서 둘다 나와야한다
select department_id, job_id, sum(salary), count(salary), avg(salary)
from employees
group by department_id, job_id;

--위와 같이 사원수와 평균 급여를  구하는예
-- 정렬순서가 정해져있음. 
select department_id, job_id, sum(salary), count(salary), avg(salary)
from employees
group by department_id, job_id
order by department_id, job_id;

--총급여와 평균 금여를 99,999,999  format으로 출력 
select department_id, job_id,
to_char(sum(salary),'999,999') 총급여,
to_char(avg(salary),'999,999') 평균급여
from EMPLOYEES
GROUP by department_id, job_id
order by department_id, job_id;
-- 부서번호와 직급 순서로 나열하여 조

select department_id, job_id,
to_char(sum(salary),'999,999') 총급여,
to_char(avg(salary),'999,999') 평균급여
from EMPLOYEES
where department_id = 80
GROUP by department_id, job_id
order by department_id, job_id;
--부서번호가 80인경우 

/* having 절 : 현재 부서별 사원수*/
select department_id, count(*)
from EMPLOYEES
where department_id is not null
/*and count(*) >= 10 where절에서 사용할 수 없다.*/
group by department_id
having count(*) >= 10;
--사원수가 10명이 넘는 부서를 구하여라 

----------------------------------------------------------------------

/* group by 절 */
select distinct department_id from EMPLOYEES;
select department_id from EMPLOYEES group by department_id;
/* 부서별 급여 합계 */
select department_id, sum(salary) 
from EMPLOYEES
group by department_id;

/* ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"*/
--그룹이 여러개이다.
select distinct department_id, sum(salary)
from employees;
----------------------------------------------->
/* 부서별 사원수와 평균 급여를 구해보자 */
select department_id, sum(salary), count(salary), avg(salary)
from employees
group by department_id;

/* 부서별 직급별 사원수와 평균 급여를 구하는 예*/
select department_id, job_id, sum(salary), count(salary), avg(salary)
from employees
group by department_id, job_id;

--select에서 department_id, job_id는 group by에서 둘다 나와야한다
select department_id, job_id, sum(salary), count(salary), avg(salary)
from employees
group by department_id, job_id
order by department_id, job_id;

select department_id, job_id,
to_char(sum(salary),'999,999') 총급여,
to_char(avg(salary),'999,999') 평균급여
from EMPLOYEES
GROUP by department_id, job_id
order by department_id, job_id;


select department_id, job_id,
to_char(sum(salary),'999,999') 총급여,
to_char(avg(salary),'999,999') 평균급여
from EMPLOYEES
where department_id = 80
GROUP by department_id, job_id
order by department_id, job_id;


/* having 절 : 현재 부서별 사원수*/
select department_id, count(*)
from EMPLOYEES
where department_id is not null
/*and count(*) >= 10 where절에서 사용할 수 없다.*/
group by department_id
having count(*) >= 10;
---------------------------------------------------------->>
select * from locations;

/*rollup : 그룹별 합계 정보를 추가해서 보여주는 함수*/
select l.CITY, d.DEPARTMENT_NAME, e.JOB_ID,
count(*) 사원수, sum(e.salary) 총급여  
from EMPLOYEES e, DEPARTMENTS d,LOCATIONS l
where e.department_id = d.department_id
and d.LOCATION_ID = l.LOCATION_ID
group by rollup(l.city, d.department_name, e.job_id)
--rollup울 이용하면 부서별로 각각의합계 전체합계가 나온다
order by l.city, d.department_name, e.job_id;

-- EMPLOYEES e(가명)LOCATIONS l(가명)
--직업은 null일 수있음. 
