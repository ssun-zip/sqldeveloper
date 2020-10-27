--having절을 사용하여 사원을 제외하고 금여총액이 1000이상인 직급급요 총액 구하기

select job, count(*), sum(sal)
from emp
where job not like '%사원%'
-- %는 0개 이상의 문자로 길이와 상관없이 조건어 지정한다
group by job
having sum(sal) >= 1000
order by sum(sal);

select max (avg(sal)) from emp group by deptno;
-- result : max(avg(sal)) : 552

--급여최고액, 최저액, 총액 및 평균 출력하기
select max(sal) as "maximum",
            min(sal) as "minimum",
            sum(sal) as "sum",
            round(avg(sal)) as "Average"
            from emp
            group by deptno;

--담당 업무 유형별로 급여최고액, 총액 및 평균급여 출력기
select job as "JOB",
            max(sal) as "maximum",
            min(sal) as "minimum",
            sum(sal) as "sum",
            round(avg(sal)) as "Average"
            from emp group by job;
            
--담당 업무별 사원수를 출력하기
select job, count(*) from emp group by job;

-- 문제: 과장의 수를 조회해보기기
select job , count(*) from emp where job = '과장' group by job;
-- select count(*) from emp where job = '과장'; 

-- 문제 : 급여 최고 금액, 최저 금액의 차액 출력하기
select max(sal) - min(sal) as  "차액"
from emp group by job;

--직급별 사원의 최저 금여 출력하기 단 최저 급여가 200 이상이여야함. 내리차순 까지
select job, min(sal) from emp
group by job
having not min(sal) < 200
order by min(sal) desc;

--부서별 사원수 평균 급여 출력하기
select deptno, count(*) as "Number of People",
        round(avg(sal),2) as "Sal"
        from emp group by deptno
        order by deptno asc;
        

--부서별로 이름 지역명 사원수 부서내의 모든 사원의 평균급여 출력
select decode (deptno, 10, '경리부',
                        20, '인사부',
                        30, '영업부',
                        40, '전산부') as "dname",
      decode (deptno, 10, '서울',
                        20, '인천',
                        30, '용인',
                        40, '수원') as "Location" ,
                        count(*) as "Number of People",
                        round(avg(sal)) as "sal"
                        from emp group by deptno;

/**role(역할): 권한을 효과적으로 관리하기 위해서 관련된 권한을 모아놓은 것
        특징: 시스템 권한 이나 오브젝트 권한을 포함 할수있다.     
        사용자에게 부여되고, 다른 룰에게도 부여할수있더.
        
        롤은 활성화/비활성화 통해서 일시적으로 권한 부여와 철회가 가능하다
        롤에 암호를 부여해서 룰의 사용을 제한할수있다.
        롤을 수정하게 되면 룰을 부여받은 사용자도 자동적으로 수정된 권한을 사용할수있다.
        
        - 롤을 부여하는 방법:
        롤을 생성 -> 롤에 대한 권한 부여 -> 사용자에 롤을 부여
        롤을 생성하기 위해서는 create role권한이 있어야한다.
        
        - 롤 생성 형식
        create role 롤이름 identified by | not identified
        
        - dba_roles 딕서녀리를 이용하면 롤에 대한 정보를 확인 
 **/
 
/**
            데이터 딕셔너리
            데이터 딕셔너리는 사용자가 테이블을 생성하거나 사용자를 변경하는등의 작업을
            할때 데이터베이스 서버에 의해 자동적으로 갱신되는 테이블로,
            사용자는 데이터 딕셔너리의 내용을 직접 수정하거나 삭제할 수없고
            사용자가 이해할수있는 데이터를 산출해 줄 수 았도록 하기 위해서
            읽기전용 뷰형대로 정보를 제공합니다
            USER_ 자신의 계정이 소유한 객체 등에 관한 정보 조회
            ALL_ 자신계정 소유또는 권한을 부여받은 객체 등에 관한 정보조회
            DBA_ DB 관리자만 접근가능한 객체 등의 정보조
**/

select owner , table_name from all_tables;
--all 자신계정 소유 또는 권한 부여받은 객체 권한 정보조회

select owner, table_name from dba_tables;
--dba나 시스템 권한을 가진 사용만 접근할수 있어요.
--dba권한이 없으면 오류가 발생한다

/*
    System에서 다른 사용자가 교육용 hr 사용자 스키마 하나 살릴꼐요
    hr 비번 hr
    hr로 접속하세요
    
    hr에서 시스템권한 sql로 저장합니다. 
    
    시스템 권한 system privilege
    dbms권한 관리 기능 정보의 중요성에 따라 그 정보에 접근할수있는 사용자와
    접근 할수 없는 사용자를 구분하기 위해 권한을 지정할수있다.
    
    DBA권한을 갖는 사용자가 시스템권한을 부여할수 있다.
    
    <대표적인 시스템 권한>
    - create session:DB에 접속할수있는 권한
    -create table:테이블 생성 권한
     - create any table:  다른 user의 이름으로 테이블을 생성할수있는 권한
     - create tablespace:테이블 스페이스를 만들수있ㄴ느 권한
     - unlimited tablespace:사용용량을 무제한으로 허용하는 권한
     - select any table:어느 테이블, 뷰라도 검색을 할수있는 권한
     위 외에도 상당히 많은 시스템 권한들이 있다.
     -> 권한 부여 명령:grant
     -> 권한 회수 명령: revoke
     
     with admin option: system이 부여한 권한을 a_user가 
     다른사람에게 다시 동등하게 권한을 v줄수있는 옵션
     권한에 대한 정보를 갖는 딕셔너ㄹ;:dba_sys_privs
     
     system으로 이동합니다.
     create user a_user identified by 1234;
     
     --a_user로 이동합니다. 
*/
------------------------------------------------------------
--데이터 구조를 만드는 create table문

create table emp01(
        eno number(4),
        ename  varchar2(14),
        sal number(7,3)
);

desc emp01;
s
--create table 테이블 이름(열 이름 데이터형 [default 표현식]
--                                        [열이름 데이터형 ...]);

--사원테이블에 날짜 타입을 가지는 birth 컬럼 추가하기
alter table emp01 add(birth date);
desc em01;
select * from emp01;

--사원이름 컬럼크기 변경하기
alter table emp01 modify ename varchar2(30) ;
 desc emp01;

--사원테이블에서 이름 컬럼을 제거해보자
--drop table ename;
alter table emp01 drop column ename;
desc emp01;

alter table emp01 set unused (eno);
-- set unused는 시스템의 요구가 적을때 컬럼을 제거할수있도록 하나 이상의
desc emp01;
-- 컬럼을 unused 로 표시 실제로는 테이블에서 해당 컬럼이 제거되지는 않아요. 
-- drop unused cilumns는 테이블에서 현재 unused로 표시된 모든 컬럼을 제거합니다.
alter table emp01 drop unused columns;
desc emp01;

-- 테이블 명을 변경하는 rename 문
-- rename old_name TO new_name;
rename emp01 to emp02;
desc emp02;

/*
        테이블 구조를 제거하는 drop talbe문
        drop table문을 사용하여 기존의 테이블과 데이터를 모두 제거가능
        삭제할 테이블의 기본 키나 고유키를 다른 테이블에서 참조하고 있는 경우
        삭제가 불가능하기 때문에 그럴 경우 참조 증인 자식 테이블을 먼저 제거. 
*/

drop table emp02;
desc emp02;
--  ORA-04043: object emp02 does not exist

/*
    rownum:
    내장 함수는 아니지만 자주 사용되는 문법임.
    오라클에서 내부적으로 생성되는 가상 컬럼으로
    SQL조회결과의 순번을 나타냄
    자료를 일부분만 확인하여 처리할때 유리
*/
select rownum "순번", empno, ename, sal
from emp where rownum <= 2;
-- 순번이 2보다 작은 숫자를 가진 employee를 조회하여라

create table emp02
as select * from emp;
desc emp02;
-- emp와똑같이 만들어지는 차트

select* from emp02;
--emp와 똑같이 출력. 

truncate table emp02;
select * from emp02;
-- emp02에 있던 자료들이 모두 사라짐 

select * from tab; --데이터 구조를 보기 위해 하는 명령어 

create table dept_mission (
            dno number(2),
            dname varchar2(14),
            loc varchar2(13)

);

select * from dept_mission;
-- 아무것도 없는 빈 차트 조회 
desc dept_mission;
-- 타입 출력 

--문제: 테이블변경하기 ename 을 varchar2(25)로변경 
alter table dept_mission modify dname varchar2(25);
desc dept_mission;

--테이블 제거하기
drop table dept_mission;


--컬럼제거하기
alter table dept_mission
drop column dname;
desc dept_mission;

alter table dept_mission
set unused(loc);
desc dept_mission;

alter table dept_mission
drop unused columns desc dept_mission;

rename  dept_mission to department;
desc department;

drop table dept01;

create table dept01(
    deptno number(2),
    dname varchar2(14),
    loc varchar2(13)
);
desc dept01;

/*
        데이터 삽입 : insert문
        insert into 테이블이름[(속성리스트)]
        values (속성값_리스트);
        into키워드와 함께 튜플을 삽입할 테이블의 이름과 속성의 이름을 나열
        속성 리스트를 생략하면 테이블을 정의할때 지정한 속성의 순서대로 값이 삽입됨
        values키워드와 함께 삽입할 속성값들을 나열
        into 절의 속성 이름과value절의 속성 값은 순서대로 일대일 대응되어야함 
*/

insert into dept01 
values (10, '경리부' , '서울' );

select * from dept01;
/*
        테이블에 내용을 수정하는 update문
        update 테이블이름
        set 속성_이름1 = 값1, 속성_이름2 = 값2, 속성_이름3 = 값3,,,,,
        where <검색 조건>;
*/

insert into dept01 (DEPTNO, loc, dname)
values (20, '인천', '인사부');

insert into dept01 (DEPTNO, dname)
values (30, '영업부');

insert into dept01 values (40, '전산부 ', null);
insert into dept01 values (50, '기획부','');

select * from dept01;

/*
        delete문
        테이블에 있는 기존 튜플을 삭제하는 명령
        delete
        from 테이블이름
        where 검색조건;
        where절을 생략하면 테이블에 있는 모든 행이 삭제됩니다.
        10번 부서의 특정로우만 삭제하기
*/

delete dept01 where deptno = 10;

select * from dept01;
commit;

delete dept01;
select* from dept01;
rollback;
--다시 작업을 되돌려 놓음. 
select * from dept01;









