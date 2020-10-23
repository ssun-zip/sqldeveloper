select * from employees;

select sum(salary) from employees; 
-- 직원 테이블로부터 급여의 합을 조회

select count(*) from employees; 
-- 직원 테이블에 저장된 행의 갯수
select count(all Employee_id) from employees; 
-- 직원 테이블에 저장된 직원아이디의 갯수
select count(all Employee_id), count(distinct Employee_id) 
from employees;
-- distinct를 사용하여 직원 테이블에 저장된 직원아이디를 중복제거하고 그 갯수를 조회 
select count(all First_name) from employees;
select count(all First_name), count(Distinct first_name) 
from employees;

select avg(salary) from Employees; 
-- 직원 테이블로부터 급여의 평균을 조회
select avg(salary) from Employees where department_id = 80; 
-- 직원 테이블로부터 부서 번호가 80인 직원의 급여 평균을 조회
select avg(salary) from Employees where department_id = 50;

select max(salary) from Employees;
-- 직원 테이블로부터 급여의 최대값을 조회
select max(hire_date) from Employees;
-- 직원 테이블로부터 입사 날짜가 가장 최근인 직원을 조회

select min(salary) from Employees;
select min(hire_date) from Employees;

select abs(-23) from dual; 
-- 절댓값 함수 23을 사용하여 dual 테이블에서 값을 조회
select abs(23) from dual;

-- sign(x): x값이 0보다 작으면 -1, 0이면 0, 0보다 크면 1을 반환하는 함수
select sign(23) from dual;
-- 23이 0보다 크므로 1이 dual 테이블에서 조회
select sign(23), sign(-23), sign(0) from dual; -- 1, -1, 0이 조회

-- round("값", "자리수"): 값을 지정한 자리수에서 반올림하고 나머지를 버리는 함수
select round(0.123), round(0.543) from dual; -- 지정하지 않은경우 소수점 첫째자리에서 반올림
select round(0.123), round(2.543) from dual;
select round(0.12345678, 6), round(2.3423455, 4) from dual;

-- trunc("값", "옵션"): 소수점이나 날짜 형식을 자르는데 사용되는 함수
select trunc(1234.1234567) zero from dual; -- zero 앞에 as가 생략되어 있음
select trunc(1234.1234567,0) zero from dual;
select trunc(1234.1234567,2)  from dual;
select trunc(1234.1234, -1) from dual; -- 일의자리수부터는 -로 표시, 자른수는 0으로 표기함

-- ceil: 올림 함수
select ceil(32.8) ceil from dual;
select ceil(32.3) ceil from dual;

-- floor: 내림 함수
select floor(32.8) floor from dual;
select floor(32.3) floor from dual;

-- power(값, 제곱숫자): 제곱 함수
select power(4,2) power1 from dual;

-- mod: 나머지 함수, 자바에서 %와 같은 역할
select mod(7, 4) mod1 from dual;

-- sqrt: 제곱근 함수, 인자 값으로는 양의자리 정수와 실수만 올 수 있음
select sqrt(2), sqrt(3) from dual;