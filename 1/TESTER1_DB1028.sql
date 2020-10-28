--10/28/2020
/*
        데이터 무결성 제약조건 (data integrity constraint rule)이란 테이블에
        부적절한 자료가 입력되는 것을 방지하기 위해서 테이블을 생성할때
        각 컬럼에 대해서 정의하는 여러 가지 규칙을 말합니다
        무결성 제약조건의 종류
        not null: null을 허용하지않는다
        unique : 중복된 값을 허용하지 않는다. 항상 유일한 값을 갖도록 한다.
        primary key: null을 허용하지 않고 중복된 값을 허용하지않는다
                                not null조건과 unique조건을 결함한 형태이다
        foreign key: 참조되는 테이블의 컬럼의 값이 존재하면 허용한다
        check:저장 가능한 테이더 값의 범위나 조건을 지정하여 실행한 값만 허용한다
        
        제약조건 확인하기: 오라클은 user_constraints 데이터 딕셔너리로
        제약조건에 관한 정보를 알려 줍니다.
        user_constraints 데이터 딕셔너리를 조회하면 
        내가 만든 user 제약조건 의 정보를 조회할수있습니다. 
       
*/
desc user_constraints;

select * from dept;
insert into dept values(null, 'test', 'test');
desc user_constraints;

--제약조건 살펴보기 
select constraint_name, constraint_type, table_name
from user_constraints;

purge recyclebin;
--입력하면 쓰레기 테이블을 삭제 정확하게는 휴지통을 비워줍니다.
-- 남은 명령어 테이블에 대한 정보를 지웁니다.

/*
        무결성 제약의 예 >>>
        학생은 하나의 학과에 소속된다.
        하나의 강좌는 한명의 담당교수가 배정된다.
        하나의 교과목은 가가 학기마다 두강좌 이하만 개설할수있다.
        학생은 한 학기에 20학점 이상 수강할수없다.
        기본적 무결성 제약
        의미: 관계형 데이터 모델에서 정의한 무결성 제약
        기본키 무결성 제약을 참조 무결성 제약
        테이블의 무결성 제약
        의미: 테이블을 정의하거나 변경 과정에서 설정 가능한 무결성 제약
        not null, unique,check, default
        
        기타 무결성 제약
        위에 해당안되는 제약들 -- 주장, 트리거 등... 
        
        기본키 무결성 제약 (유일 + not null)
        primary key integrity constraint 
        테이블에서 레코드들이 반드시 유일하게 식별될수있어야한다는 조건
        정의: 기본키 무결성 제약
        기본키는 널값을 가질수 없으며 기본키의 값이 동일한 레코드가
        하나의 테이블에 동시에 두개 이상 존재할수없다. 
        
        형식
        constraint <제약식명> primary key (<필드리스트>)
        <제약식명>: 기본키를 정의하는 제약식에 주어진 이름이고
        <필드리스트> : 기본키를 정의할 필드들의 리스트 
        
        USER_CONSTRAINTS 데이터 딕셔너리의 자주 사용되는 칼럼
        OWNER  : 제약조건을 소유한 사용자
        CONSTRAINT_NAME : 제약조건 명 
        CONSTRAINT_TYPE  : 제약조건 유형 
        TABLE_NAME   :  제약조건이 속한 테이블명 
        SEARCH_CONDITION  : check 조건일 경우에는 어떤 내용이 조건으로 사용되었는지 설명 
        R_CONSTRAINT_TYPE: foreign key일 경우 어떤 기본키를 참조하였는지에 대한 정보를 가짐 
        
        CONSTRAINT_TYPE은 제약조건 유형을 저장하는 칼럼입니다.
        종류로는 P (primary) , R (foreign key) , U (unique) , C ( check, not null)  4가지 중에 하나를 갖습니다
        
        tester1 계정으로 접속해 있는 상태에서
        tester1 소유의 테이블에 지정된 제약조건을 살펴보도록합니다         
*/

-- 제약조건에서 지정된 칼럼 살펴보기 --> user_cons_colums
select constraint_name, table_name, column_name
from user_cons_columns;

/*
        not null :
        특정 필드에 대해서 널 값의 입력을 허용하지 않아야 되는 경우
        기본키로 정의된 필드에 대해서는 명시적으로 not null조건을 설정하지 않아도 됨.
        형식: column_name data_type constraint_type
        컬럼레벨로만 정의할수 있습니다.
*/

create table emp01 (
        empno number(4),
        ename varchar2(10),
        job varchar2(9),
        deptno number(2)
);

desc emp01;
select * from emp01;

insert into emp01 values(null, null, '사원', 30);
select * from emp01;

--문제: emp01테이블에 대한 제약조건을 살펴보다
select constraint_name, constraint_type, table_name
from user_constraints
where table_name = 'emp01';
--아무것도 안나오는 이유: 설정된 조건이 없어서.

drop table emp02;

create table emp02(
        empno number(4) not null,
        ename varchar2(10) not null,
        job varchar2(9),
        deptno number(2)
);

insert into emp02 values(null, null, '사원', 30);
-- ORA-01400: cannot insert NULL into ("TESTER1"."EMP02"."EMPNO")
-- a null value can appear in columns of any datatype as long as it is not set to the
-- value “not null” or is restricted by primary key integrity constraints.a null value can appear 
-- in columns of any datatype as long as it is not set to the value “not null” or is restricted 
-- by primary key integrity constraints.

-- 기본키에 의해 제약됨. not null이 두개인데 null로 넣었기 때문에 입력되지않음. 

desc emp02;
select * from emp02;

insert into emp02 values (1000, '허준', '사원' , 30);
commit;

insert into emp02 values(1000, '홍길동', '과장', 20);
select * from emp02;

/*
        유일한 값만 허용하는 unique 제약조건
        unique 제약조건이란 특정 칼럼에 대해 자료가 중복되지않게 하는 것입니다.
        즉, 지정된 칼럼에는 유일한 값이 수록되게 하는 것입니다.
        unique 는 null값을 예외로 간주한다고 했습니다.
        만약 null값마저도 입력되지않게 제한을 하려면
        테이블 생성시 empno number(4) unique not null처럼
        두가지 제약조건을 기술해야합니다.
        형식:
        constraint<제약식명> unique (<필드리스트>)
        <제약식명> : 제약식의 이름
        <필드리스트>: unique를 설정할 필드들의 리스트
*/

create table emp03 (
        empno number(4) unique,
        ename varchar2(10) not null,
        job varchar2(9),
        deptno number(2)
);

desc emp03;

insert into emp03 values (1000, '허준', '사원' , 30);
select * from emp03;

insert into emp03 values (1000, '홍길동', '과장', 20);
-- ORA-00001:unique constraint (TESTER1.SYS_C007120) 
-- empno 을 unique로 설정하였으므로 반복이 있으면 안되는데 허준과 홍길동이
-- 같은 empno을 가지고 있다. 

insert into emp03 values (null, '안중근', '과장', 20);
--unique 는 null 일수있음

insert into emp03 values (null, '이순신', '부장', 10);
select * from emp03;

/*
        컬럼 레벌 제약조건 설정하기
        형식: 
        column_name data_type constraint constraint_name constraint_type
        제약조건명은 명명규칙을 준수해야한다
        형식: [테이블명]_ [칼럼명]_[제약조건유형]
        emp04_empno_uk
*/

-- 컬럼 레벨로 제약조건 이름을 명시해서 제약조건 설정하
create table emp04 (
        empno number(4) constraint emp04_empno_uk unique ,
        ename varchar2(10) constraint emp04_empname_nn not null,
        job varchar2(9),
        deptno number(2)
);
desc emp04;

-- 문제: 테이블의 제약조건을 살펴보자
select table_name, constraint_name, constraint_type
from user_constraints
where table_name in upper('emp04');
--왜 아무것도 나오지않는가?
-- oracle은 테이블이름을 대문자로 저장하기 때문에 

insert into emp04 values (1000, '허준', '사원', 30);
insert into emp04 values (1000, '홍길동', '과장', 20);
--unique constraint 

/*
        데이터 구분을 위한 primary key 제약조건
        unique 제약조건과 not null제약조건을 모두 갖고 있는
        이러한 두가지 제약조건을 모두 갖는 것이 기본키 입니다. 
*/

create table emp05 (
        empno number(4) constraint emp05_empno_pk primary key ,
        ename varchar2(10) constraint emp05_empname_nn not null,
        job varchar2(9),
        deptno number(2)
);

select constraint_name, constraint_type, table_name
from user_constraints
where table_name in upper('emp05');

insert into emp05 values (1000, '허준', '사원', 30);
insert into emp05 values (1000, '홍길동', '과장', 20);
-- unique constraint 허준이 기본키를 1000을 이미가지고 있기때문에
-- 홍길동이 그pk는 (unique + not null)이기때문에 그 유일한키를 또 가질수없다.

insert into emp05 values (null, '이순신', '부장', 10);
-- ORA-01400: cannot insert NULL into ("TESTER1"."EMP05"."EMPNO")
-- 기본키는 not null을 조건으로 하기때문에 null값을 받아드릴 수 없다.

select * from emp05;
--그러므로 허준의 데이터만 들어가고 나머지 정보들은 조회할수없다. 
-----------------------------------------------

/*
        참조 무결성을 위한 foreign key제약조건
        외래키 (foreign key) 제약조건은 자식 테이블인
        사원 테이블의 부서번호 칼럼에 부모 테이블인
        부서 테이블의 부서번호를 부모키로 설정하는 것입니다.
        
        한 테이블의 레코드가 다른 테이블을 참조
        참조되고 있는 테이블에 해당 레코드가 반드시 존재하거나 널값을 가짐
        이 조건이 지켜지지않는다면 참조하는 레코드는 실제로 존재하지 않는 레코드를 
        참조하게 되는 오류가 발생. 외래키의 조건과 일치
        실제 존재하지않는 잘목된 값이 저장되지않도록 보장하는 수단 
        
        형식:
        constraint <제약식명> foriegn key (<필드리스트1>)
        references <테이블 이름> (<필드리스트2>)
        <제약식명> : 외래키를 정의하는 제약식에 주어진 이름
        <필드리스트1>: 외래키로 정의하는 칠드들의 리스트 
        <테이블 이름> : 참조 대상인 테이블의 이름
        <필드리스트2>: 테이블이름의 기본키
        ex. constraint fk_dept foreign key (dept_id)
              references department(dept_id)
        
        참조 무결성 제약은 외래키 정의에 의해 DBMS 에서 자동적으로 검증
        DBMS는 이 조건을 위배하게 되는 연산의 실행을 거부 
        
        alter table 문을 이용하여 외래키를 별도로 설정
        ex. alter able student add constraint fk_dept foreign key (dept_id)
              references department(dept_id)
              
        외래키 삭제\
        ex. alter table student drop constraint fk_dept 
*/

-- 제약조건 살펴보기
select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('DEPT');

insert into emp (empno, ename, job, deptno)
values (1010, '홍길동', '사원', 50);
-- ORA-00001: unique constraint (TESTER1.PK_EMP) violated

insert into dept (deptno, dname, loc) values (50, '기획부', 'LA');

select * from dept;

--이번에는 in을 사용하여 두개의 테이블에 대한 현재 사용자의 제약조건을 알아보기
-- inserted
select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('DEPT', 'EMP');

select * from emp05;
delete emp05 where empno=1010;

insert into emp05
values(1010, '홍길동', '사원', 50);

select * from emp05;
--홍길동이 1010으로 변경되었다 
commit;

--참조 무결성을 위한 foreign key 제약조건
create table emp06 (
        empno number(4) constraint emp06_empno_pk primary key ,
        ename varchar2(10) constraint emp06_ename_nn not null,
        job varchar2(9),
        deptno number(2) constraint emp06_deptno_fk references dept(deptno)
);
--여기서 알수있는 제약조건명은 명명규칙입니다.
--dept(deptno) 50번 부서 기획부가 참조제약조건이 걸린겁니다. 
--emp06테이블에서 1010 홍길동 사원 50(부서테이블) <--deptno
-- references dept(deptno) dept테이블에서 50번째 부서 기획부 la

/*
        column_name data_type constraint constraint_name constraint_type
        제약조건명은 명명규칙을 준수해야한다.
        형식: [테이블명]_[컬럼명]_[제약조건유형]
*/

insert into emp06 values(1010, '홍길동', '사원', 50);
select * from dept;
select * from emp06;

insert into emp06 values(1010, '홍길동', '사원', 30);
--ORA-00001: unique constraint (TESTER1.EMP06_EMPNO_PK) violated
--1010번은 기본키라 중복이 있을수없다. 
-- 홍길동은 50 -> 부서 기획부로 지정되어있기떄문에 다른 부서에 넣을수없다. 


select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('EMP06');
--pk_dept는 dept테이블의 primary key제약조건을 의미한다. 

/*
        check제약조건
        check제약조건은 입력되는 값을 체크하여 설정된 값 이외의 값이
        들어오면 오류 메세지와 함꼐 명령이 수행되지 못하게 하는 것입니다.
        족너으로 데이터의 값의 범위나 특정 패턴의 숫자나 문자 값을 설정할수있다.
        
        도메인 제약
        각필드의 값은 정의된 도메인 속한 값만 허용하는 성질
        check 필드를 정의할때 주어진 데이터 타입 이외에도 좀 더 세부적으로
        허용할수있는 값의 범위를 지정
        형식
        constraint <제약식명> chekc (<조건식>)
        <조건식> --> 만족해야할 칠드들의 조간
        ex. cosnstraint chk_yer check( year >= 1 and year <= 4)


create table emp07 (
        empno number(4) constraint emp07_empno_pk primary key ,
        ename varchar2(10) constraint emp07_ename_nn not null,
        sal number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
        gender varchar2(1) constraint emp07_sal_ck check(gender in ('M', 'F'))
);

--Error report -
--ORA-02264: name already used by an existing constraint
--02264. 00000 -  "name already used by an existing constraint"
--*Cause:    The specified constraint name has to be unique.
--*Action:   Specify a unique constraint name for the constraint.

insert into emp07 values (1000, '허준', 500, 'M');
insert into emp07 values (1000, '허준', 200, 'A');
--A라는건 gender 설정중없기떄문에 입력이 불가능하다. 

desc emp07;
delete emp07 where empno = 1000;


        default 제약조건:
        디폴트는 아무런 값을 입력하지않을때 디폴트 값이 입력이 되도록 하고 싶을때 사용합니다.
        예를 들어 지역명이라는 컬럼에 아무런 값이 없도록 하고싶을 경우 디폴트 제약조건을 지정합니다.
        
        레코드를 삽입할때, 필드에 대한 값이 정해지지않았을경우
        사전에 정해놓은 값으로 입력하도록 지정, 널값 대신에 지정된 값이 자동적으로 입력
*/

drop table dept01;

create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13) default '서울'
);

select * from dept01;
/*
        디폴트를 별도로 설정할수있다 
        ex. alter table student alter column year set defult
        디폴트를 해제할수도 있다.
        ex. alter table student alter column year drop defualt
        
        오라클은 default에 대한 별도의 설정  해제에 SQL을 표준을 따르지않음
        alter table student modify(year int default 1)
        alter table student modify ( year int default null)
*/

insert into dept01(deptno, dname) values (10, '경리부');
select * from emp01;
drop table emp01;

create table emp01 (
        empno number(4)  primary key ,
        ename varchar2(10)  not null,
        job varchar2(9) unique,
        deptno number(2) references dept(deptno)
);
-- empno -> 4개의 숫자로 구성된 기본키 (유일성  + not null)
-- ename -> not null인 10자리까지까지 받을수있는 글자
-- job -> 유일성이 보장되있는 1가지의 직업만 가진 글자
-- deptno -> deptatment table이 부모키를 가져 참조된 2자리 숫자의 부서번호 
/*
    deptno number(2) reference dept(deptno)가 의미하는것은
    emp01테이블에 deptno를 dept테이블에 deptp컬럼을 참조하는
    emp01테이블에 deptno  number(2) 가 fk가됩니다
    dept테이블에 dept(detpno)는 pk가 됩니다,
*/

select constraint_name, constraint_type, r_constraint_name, table_name
from user_constraints
where table_name in('EMP01');

select constraint_name, table_name, column_name
from user_cons_columns
where table_name in('EMP01');

/*
        drop table 테이블명 [cascade constraints];
        종속된 제약조건이 삭제된다
        alter table '테이블명' drop constraint '제약조건명'
        테이블의 pk 제약조건 삭제
        alter table '테이블명' drop primary key
*/
--제약조건 조회
select * from all_constraints where table_name = 'emp01';

--------------------------------------HR_DB10주석 달아보세요.
/*컬럼속성(무결성 제약조건)
not null : 널값이 입력되지 못하게하는 조건
unique : 중복된 값이 입력되지 못하게 하는 조건 <null값허용함>
primary key : not unll + unique의 의미
--허용하지안는다<null + 중복>
foreign key(외래키) : 참조되는 테이블의 컬럼의값이 존재하면 허용한다
다른 테이블의 필드(컬럼)를 참조해서 무결성을 검사하는 조건
자식테이블이 부모테이블을 참조하는키
check : <주어진값만 허용하는 조건>
남 여 둘중하나만 들어오게만 하는조건
*/
/* not null*/
create table null_test(
  col1 varchar2(20) not null,
  col2 varchar2(20) null,
  col3 varchar2(20)
);

select * from null_test;
desc null_test;
insert into null_test(col1, col2)
values ('aa', 'bb');
select * from null_test;
-- aa, bb, null로 조
insert into null_test(col2, col3)
values ('cc', 'dd');
--ORA-01400: cannot insert NULL into ("TESTER1"."NULL_TEST"."COL1")
-- col1은 null 이 되면 안되기 때문에 오류 회

select * from null_test;
select * from null_test;


/*unique*/
create table unique_test(
  col1 varchar2(20) unique not null,
  col2 varchar2(20) unique,
  col3 varchar2(20) not null,--유니크아님
  col4 varchar2(20) not null,--유니크아님
  constraints temp_unique unique(col3, col4)
  --제약조건을준다 유니크이름temp_unique을준다
);--컬럼3과 4를 주엇을때 유니크여야만한다 
--예>지역번호와 전화번호가 합쳣을때는 그값은 유니크로 바뀐다는소리
select * from unique_test;
desc unique_test;
insert into unique_test(col1, col2, col3, col4)
values ('aa', 'bb', 'cc', 'dd');
select * from unique_test;
insert into unique_test(col1, col2, col3, col4)
values ('a2', 'b2', 'c2', 'd2');
select * from unique_test;
update unique_test 
set col1 = 'aa'
--무결성위반 중복되니 col2은유니크unique, col1은not null
where col2 = 'b2';
---------------------------------------------------->>>
desc user_constraints;
insert into unique_test (col1, col2, col3, col4)
values('a3', '','c3', 'd3');
--unique인데 null값허용이라서 들어감// '' ==> 공백아님
insert into unique_test (col1, col2, col3, col4)
values('a4', '','c4', 'd4');--null이 두개라도 들어간다
select * from unique_test;
/*기본키(primary key) 테이블 생성시 기본키 생성*/
create table primary_test(
    student_id number(10) primary key, /*인라인 방식*/
    name varchar2(20)    
);
create table primary_test(
    student_id number(10),
    name varchar2(20),    
    constraints student_pk primary key(student_id) /*아웃라인 방식*/
);--제약사항을 주면 이름을부여한다 프라이머리키student_pk 이름을 만들어주고,
  --항목student_id을 만들어준다
drop table primary_test;
DESC PRIMARY_TEST;
create table primary_test(
    student_id number(10),
    name varchar2(20),        
);
/* 테이블을 생성하고 나서 이후에 기본키를 생성하는 방법 */
alter table primary_test
add constraints "기본키 이름" primary key (필드명) ;
alter table primary_test
drop primary key;
select constraint_name, constraint_type, r_constraint_name, table_name 
from user_constraints
where table_name in('primary_test');
select constraint_name, table_name, column_name 
from user_cons_columns
where table_name in('primary_test');
/* 외래키 */
create table foreign_key(
  department_id constraints dept_fk
  references departments (department_id) /*인라인*/
);--references departments부모키 테이블에 아이디department_id를 사용하겟다
DROP TABLE foreign_key;
create table foreign_key(
  department_id,
  constraints dept_fk
  foreign key (department_id)
  references departments (department_id)/*아웃라인*/
);
/*테이블을 생성하고 나서 외래키를 지정하는 방법 */
alter table foreign_key
add constraints dept_fk foreign key (department_id)
references departments (department_id);
/*check*/
drop table check_Test;
create table check_test(
  gender varchar2(10) not null -- 젠더 필드
      constraints check_sex check (gender in('M','F'))
);--체크조건이름check_sex check
create table check_test(
  gender varchar2(10) not null
      constraints check_sex check (gender in('남성','여성'))
);
insert into check_test values('남성');
insert into check_test values('M');
-- 제약조건 삭제
-- ALTER TABLE '테이블명' DROP CONSTRAINT '제약조건명'
-- 테이블의 PK 제약조건 삭제
-- ALTER TABLE '테이블명' DROP PRIMARY KEY:
-- 제약조건 조회
--SELECT * FROM    ALL_CONSTRAINTS
--WHERE    TABLE_NAME = '테이블명';/*컬럼속성(무결성 제약조건)
not null : 널값이 입력되지 못하게하는 조건
unique : 중복된 값이 입력되지 못하게 하는 조건 <null값허용함>
primary key : not unll + unique의 의미
--허용하지안는다<null + 중복>
foreign key(외래키) : 참조되는 테이블의 컬럼의값이 존재하면 허용한다
다른 테이블의 필드(컬럼)를 참조해서 무결성을 검사하는 조건
자식테이블이 부모테이블을 참조하는키
check : <주어진값만 허용하는 조건>
남 여 둘중하나만 들어오게만 하는조건
*/
/* not null*/
create table null_test(
  col1 varchar2(20) not null,
  col2 varchar2(20) null,
  col3 varchar2(20)
);
select * from null_test;
desc null_test;
insert into null_test(col1, col2)
values ('aa', 'bb');
select * from null_test;
insert into null_test(col2, col3)
values ('cc', 'dd');

/*unique*/
create table unique_test(
  col1 varchar2(20) unique not null,
  col2 varchar2(20) unique,
  col3 varchar2(20) not null,--유니크아님
  col4 varchar2(20) not null,--유니크아님
  constraints temp_unique unique(col3, col4)
  --제약조건을준다 유니크이름temp_unique을준다
);--컬럼3과 4를 주엇을때 유니크여야만한다 
--예>지역번호와 전화번호가 합쳣을때는 그값은 유니크로 바뀐다는소리
select * from unique_test;
desc unique_test;
insert into unique_test(col1, col2, col3, col4)
values ('aa', 'bb', 'cc', 'dd');
select * from unique_test;
insert into unique_test(col1, col2, col3, col4)
values ('a2', 'b2', 'c2', 'd2');
select * from unique_test;
update unique_test 
set col1 = 'aa'
--무결성위반 중복되니 col2은유니크unique, col1은not null
where col2 = 'b2';
---------------------------------------------------->>>
desc user_constraints;
insert into unique_test (col1, col2, col3, col4)
values('a3', '','c3', 'd3');
--unique인데 null값허용이라서 들어감// '' ==> 공백아님
insert into unique_test (col1, col2, col3, col4)
values('a4', '','c4', 'd4');--null이 두개라도 들어간다
select * from unique_test;
/*기본키(primary key) 테이블 생성시 기본키 생성*/
create table primary_test(
    student_id number(10) primary key, /*인라인 방식*/
    name varchar2(20)    
);
create table primary_test(
    student_id number(10),
    name varchar2(20),    
    constraints student_pk primary key(student_id) /*아웃라인 방식*/
);--제약사항을 주면 이름을부여한다 프라이머리키student_pk 이름을 만들어주고,
  --항목student_id을 만들어준다
drop table primary_test;
DESC PRIMARY_TEST;
create table primary_test(
    student_id number(10),
    name varchar2(20),        
);
/* 테이블을 생성하고 나서 이후에 기본키를 생성하는 방법 */
alter table primary_test
add constraints "기본키 이름" primary key (필드명) ;
alter table primary_test
drop primary key;
select constraint_name, constraint_type, r_constraint_name, table_name 
from user_constraints
where table_name in('primary_test');
select constraint_name, table_name, column_name 
from user_cons_columns
where table_name in('primary_test');
/* 외래키 */
create table foreign_key(
  department_id constraints dept_fk
  references departments (department_id) /*인라인*/
);--references departments부모키 테이블에 아이디department_id를 사용하겟다
DROP TABLE foreign_key;
create table foreign_key(
  department_id,
  constraints dept_fk
  foreign key (department_id)
  references departments (department_id)/*아웃라인*/
);
/*테이블을 생성하고 나서 외래키를 지정하는 방법 */
alter table foreign_key
add constraints dept_fk foreign key (department_id)
references departments (department_id);
/*check*/
drop table check_Test;
create table check_test(
  gender varchar2(10) not null -- 젠더 필드
      constraints check_sex check (gender in('M','F'))
);--체크조건이름check_sex check
create table check_test(
  gender varchar2(10) not null
      constraints check_sex check (gender in('남성','여성'))
);
insert into check_test values('남성');
insert into check_test values('M');
-- 제약조건 삭제
-- ALTER TABLE '테이블명' DROP CONSTRAINT '제약조건명'
-- 테이블의 PK 제약조건 삭제
-- ALTER TABLE '테이블명' DROP PRIMARY KEY:
-- 제약조건 조회
--SELECT * FROM    ALL_CONSTRAINTS
--WHERE    TABLE_NAME = '테이블명';







