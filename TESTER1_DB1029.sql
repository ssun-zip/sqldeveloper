/*
    non-equi join :
    조인 조건에 특정 범위 내에 있는지를 조사하기 위해서 where절에
    조인 조건을 = 연산자 이외의 비교 연산자를 사용합니다
    
    self-join:
    자기자신과 조인을 맺는것을 의미합니다.
    
    ansi join:
    sql server뿐만아니라 현재 대부분의 상용 데이터베이스 시스템에서 표준 언어로 ansi (미국 표준연구소)
    sql에서 제시한 표준 기능을 대부분 준수하고 있습니다.
    ansi 표준 sql조인 구문은 몇가지 새로운 키워드와 절을 제공하며
    select문의 from절에서 조인을 완벽하게 지정할수 있습닏다
    inner join, outer join
    inner join형식:
    select * from table1 inner join table2
    on table1.column1 = table2.column2

*/

select ename, dname
from emp, dept
where emp.deptno = dept.deptno;

--문제: inner join 으로 위에껄 바꾸어서 해보기
select ename, dname from emp inner join dept
on emp.deptno = dept.deptno;

-- 문제: 이문세 경리부 10도 내부조인형식으로 해보자
select ename, dname, dept.deptno
from emp inner join dept
on emp.deptno = dept.deptno
where ename ='이문세';

/*
        ansi outer join
        어ㅣ부조인에서는 full까지 지원하여 left, right, full 3가지를 지원하고 있다.
        외부 조인 (outer join)의 정의와 형식
        1) 외부 조인의 정의
        : 조인할 한쪽 테이블에 조인 조건을 만족하는 행이 없어도
        그 테이블에 "널" 행을 추가해서 결과 테이블에 포함시키는 연산이다.
        (2) 외부 조인이 필요한 테이블 예
        : 다음 두 테이블을 대응하는 정보가 부족하므로 원하는 결과에 따라서 외부 조인이 필요하다
        (3) 외부 조인 연산자: + 외부조인 연사자인 '+' 는 정보가 부족한 테이블에 널행을 추가 시키기 위한
        연산자이다.
        (4) 외부 조인 형식: select문의where절에 조인 조건을 기술할때 어느 한쪽 열 이름에 
        외부 조인 연산자를 명시한다.
        (5) 유의사항: 반드시 조인할 한쪽 테이블에만 외부 조인 연산자를 지정해야한다.
        (6) 외부 조인의 예1: emp테이블에 널 행을 추가한 외부 조인 모든 사원의 이름과
        부서번호, 부서이름을 부서번호의 오름차순으로 출력하되, 아직 아무도 근무하지않는
        신설 부서의 부서번호와 부서이름도 출력한다.
        (7) 외부 조인의 예2: dept테이블에 널 행을 ㅊ가한 외부 조인 모든 사원의 이름과 부서번호,
        부서이름을 부서번호의 오름차순으로 출력하되, 아직 부서가 정해지지않은 신입 사원의 이름도 출력한다.
        형식: select from table1[ left| full | right | outerjoin] table2;
*/
select member.ename as "사원이름" , manager.ename as "직속상관이름"
from emp member left outer join emp manager
on member.mgr = manager.empno;


drop table dept01;
--제거가 안되는 이유를 적고 해결방안
--before performing the above operation the table drop the foreign key constraint in the other table. 
-- can see what table is referencing a table by issuing the following 

select constraint_name, constraint_type, r_constraint_name, table_name
from user_constraints
where table_name in('EMP03');

alter table dept01
disable constraint dept01_deptno_pk;

drop table dept01 cascade constraints;
-- 종속된 계약조건을 삭제합니다. 

create table dept01 (
        deptno number(2),
        dname varchar2(14),
        loc varchar2(13)
);

create table dept02 (
        deptno number(2),
        dname varchar2(14),
        loc varchar2(13)
);

--사원 테이블에 샘플 추가하기
insert into dept01 values (10, '경리부', '서울');
insert into dept01 values (20, '인사부', '인천');

insert into dept02 values (10, '경리부', '서울');
insert into dept02 values (20, '영업부', '용인');

/*
    조인: 일반적으로 내부조인 방식을 의미 -- 교집합이라고 보면 됩니다. 
*/

select e.ename, d.deptno, d.dname
from emp e inner join dept d
on e.deptno = d.deptno
order by d.deptno;

select * from dept01 left outer join dept02
on dept01.deptno = dept02.deptno;

--문제 :left outer join 에 대한 결과와 대한이유를 적어주세요 
-- 합집합 
--왼쪽 테이블을 기준으로 오픈쪽의 데이터를 붙여서 볼때 사용합니다. 그래서 8에 데이터가 없는것에 대해서도 결과가보입니다.

select * from dept01 right outer join dept02
on dept01.deptno = dept02.deptno;
-- 오른쪽테이블을 기준으로 왼쪽의 데이터를 붙여서 볼때 사용
-- 그래서 A에 데이터가 없는것에 대해서도 결과가 보입니다.

select * from dept01 full outer join dept02
on dept01.deptno = dept02.deptno;


select e.ename, e.hiredate
from emp e, dept d
where e.deptno = d.deptno and d.dname = '경리부';

select e.ename, d.dname from emp e, dept d
where e.deptno = d.deptno and e.job = '과장';

/*
    join은 두개 이상의 테이블들을 조합한 결과입니다.
    inner join: 은 테이블의 관계가 일치하는 경우의 결과이고 left join은 left outer join이라고 하는데
    right outer join도 있어요.
    outer join: 테이블의 관계가 일치하는 것과 일치하지않는것 중 한쪽의 테이블을 결과로 가집니다. 
    left inner join 은 왼쪽 테이블을 기준으로 right outer join은 오른쪽 테이블을 기준임
    기준 테이블의 전체가 나오는 것이져
    inner join은 교집합!
    outer join은 겨집합 + 한 쪽의 차집합 혹은 하나의 테이블 전체 + 교집합 임. 
*/

--1. 현재 오라클 포트번호 확인
select dbms_xdb.gethttpport() from dual;

--2.  포트번호 변경 (8080 -> 9090)
exec dbms_xdb.sethttpport(9090);
--안되는 이유?system 가서 변경해주어야함. 
-- 변경 권한을 주어야함. 
--User must be granted privileges prior to resource access

select avg(sal) from emp;
--sal을 salary로 수정해주어야함 

select dname from dept
where deptno = (select deptno from emp where ename = '이문세');
--이문세 부서번호 알아내기

select deptno from emp where ename = '이문세';
-- result deptno: 10
--서브 쿼리의 결과는 메인쿼리에 보내게 되는데 메인 쿼리의 where절에서
-- 는 단일행비교연산자를 사용해야함 = > < <= >= <>

/*
-- 다중행 서브쿼리의 특징:
내부 질의에서 하나이상의 행을 반환한다.
다중 행서브쿼리를 포함하는 질의문에서는 다중해행 비교연산자만 사용 가능하다.
서브쿼리의 select절에서 그룹 함수를 사용할수있다.
다중행 서브쿼리는 서브 쿼리에서 반환되는 결과가 하나 이상의 행일때 사용하는 서브 쿼리입니다.
다중행 서브 쿼리는 반드시 다중행 연산자 (multiple row operator)와 함계 사용해야합니다.


-- 다중행 비교 연산자 
in: 메인쿼리 비교조건이 서브퀄가 반환한 목록의 어떤값고 같은지 비교한다.
    결과중 하나라도 일치하면 참
any, some : 메인쿼리비교조건이 서브쿼리가 반환한 목록의 각각의 값고 비교한다.
                결과와 하나 이상이 일치하면 참 값
all:  메인쿼리 비교조건이 서브퀄가 반환한 목록의 모든 값고 비교한다.
    결과와 모든 값이 이리하면 참 값
exists: 메인쿼리 비교조건이 서브쿼리가 반환한 목록의 어떤 값과 같은지를 비교한다.
        결과중 값이 하나라도 존재하면 참 값. 
        
in연산자는 메인 쿼리의 비교 조건에서 서브 쿼리의 출력결과와 하나라도
일치하면 메인쿼리의 were절의 참이 되도록 하는 연산자입니다. 

*/
select round(avg(sal)) "평균 급여" from emp;

--평균 금여보다 많은 급여를 받는 사람 출력하기 
select ename, sal 
from emp
where sal > (select avg(sal) from emp);

select ename

-- 급여가 500을 초과하는 사원의 소속된 부서의 부서번호 출력
select distinct deptno from emp where sal > 500;

/*
1. 다중 열 서브쿼리
(1) 다중열 서브쿼리의 특징
내부질의에서 하나 이성의 열을 반환한다.
두개 이상의 열을 비교하기 위해서 where절에 논리 연산자로 연결된 하나 이상의 조건을 기술하는 대신
in연산자만 사용하면 두개 이상의 열을 한까반에 비교할수있게 한다.

(2) 다중 열 서브 쿼리의 형식 
select 선택 리스트
from 테이블이름 where (열이름1, 열이름2) in (select (열이름1, 얄이름2)
                        from 테이블이름2
                        where 조건);
*/
select ename, sal, deptno
from emp 
where deptno in (select distinct deptno from emp where sal > 500);
-- error: single-row subquery returns more than one row
-- in으로 변경 

/*
--(1) 다중 열 비교 방식
--? 다중 열을 비교하는 방식은Pairwise와 Non-Pairwise 방식으로 구분할 수 있다.

-- Pairwise비교 :
-- 두개 이상의 열이 쌍(Pair)을 이루어 비교되는 것을 의미한다.;
-- 하나의 WHERE절을 사용할 떄 이런 비교 결과를 얻을 수 있다.

--Non-pairwise 비교:
--각각의 열이 별개로 비교되는 것을 의미한다.
--여러 개의 WHERE 절을 사용할 때 이런 비교 결과를 얻을 수 있다.

--Non-Pairwise비교의 예
--급여는 30번 부서의 어떤 사원과 같고, 업무는 20번부서의 어떤 사원과 같은
--모든사원을 검색한다. 
*/

SELECT ename, deptno, sal,job
from emp
where sal in(select sal
        from emp
        where deptno =30)        
and
    job in (select job
        from emp
        where deptno = 20);

--30번부서 모든 급여리스트
--250(한예슬-대리) 500(오지호-과장) 350(신동엽-과장)
--480(장동건-부장) 500(김우성-차장) 280(조향기-사원)
--20번 부서 모든 업무리스트
--사원(김사랑) 부장(이병헌) null사원(강혜정) 부장(박중훈)--30번부서 모든 급여리스트
--250(한예슬-대리) 500(오지호-과장) 350(신동엽-과장)
--480(장동건-부장) 500(김우성-차장) 280(조향기-사원)
--20번 부서 모든 업무리스트
--사원(김사랑) 부장(이병헌) null사원(강혜정) 부장(박중훈)


