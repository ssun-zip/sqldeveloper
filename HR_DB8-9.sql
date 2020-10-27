/*DDL(Data Definintion Language) : Create문, Drop문, Alter문
Truncate문*/

desc employees;
desc member;
desc employees2;
create table employees2(
     employee_id  number(10),
     name varchar2(20),     --맞춤사이즈로 가변형
     salary number(7,2) --7자리 안에5자리는양수자리 두자리는 소수점자리
     );
 --밑에 테이블하고 동일하게 만들려면
 -- 똑같은 테이블이 만들어진다
 -- "table or view does not exist""table or view does not exist"
create table employees3
as
select * from employees2;  
desc employees3;

alter table employees2 add (
    manager_id varchar2(10) --매니저 아이디를 추가한다
    );
desc employees2;
    
alter table employees2 modify ( 
--테이블구조를 매니저아이디필드항목을 수정
    manager_id varchar2(20)
    );
desc employees2;

/* 컬럼을 삭제 */
alter table employees2 drop column manager_id;
desc employees2;

/* 문자형 데이터 
char, varchar, nchar유니코드고정길이문자형데이터, 
nvarchar유니코드가변길이문자형데이터, long(2GB)가변길이
*/

drop table employees2; /* 테이블의 구조를 삭제 */
desc employees2;

rename employees3 to employees4; -- employees4로 변경한다

truncate table employees4;
-- 데이터만 잘라버린다
-- employees3에 데이터를 넣고 잘라보자
-- 행삽입 +기호 선택 <f11>커밋해주면 입력된다
select * from employees4;

truncate table employees3;
desc employees3;
 --hrdb _09
     /* DML(Dat Manipulation Language) : 데이타 조작어
select문, delete문, insert문, update문
--형식--
SELECT 컬럼, 컬럼2, ...
FROM 테이블1, 테이블2...
WHERE 조건들;

INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3,....)
VALUES (값1, 값2, 값3,...); //테이블의 레코드/로우 를 입력

UPDATE 테이블명
   SET 컬럼1 = 값,
       컬럼2 = 값,...
WHERE 조건..;       

DELETE (From)테이블명
WHERE 조건; //테이블의 레코드/로우를 삭제
*/

create table sample (
    deptNo number(20),
    deptName varchar2(15),
    deploc varchar2(15),
    depManager varchar2(10)
);



insert into sample(deptNo, deptName, deploc, depManager)
values(10, '기획실', '서울', '홍길동');

insert into sample
values(20, '전산실', '부산', '김말똥');

select * from sample;

delete from sample where deptno=20;
select * from sample;

insert into sample
values(30, '영업부', '광주', null);
select * from sample;
commit;



update sample set deptNo = 50
where deptNo = 30;
select * from sample;

update sample set DEPLOC = '인천'
where deptName = '영업부';
select * from sample;


delete sample
where DEPTNAME = '영업부';
select * from sample;

delete from sample;
select * from sample;


--위에 단축키 아이콘 참조
select * from sample;

Rollback; 
-- commit한시점으로 돌아가서 복구된다
select * from sample;