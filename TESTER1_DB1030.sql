--2020/10/30
/*
ALL 연산자
: 조건은 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와
모든값이 일치하면 참입니다. 찾아진 값에 대해서 and 연산을 해서
모두 참이면 참이 되는 셈이 됩니다. >all은 모든 비교값보다 크냐고 묻는 것으므로
최대값보다 더 크면 참이 됩니다.
*/

-- 30번 부서의 최대급여 구하기
 select max(sal) "최대급여" from emp where deptno = 30;
 
 --문제: 서브 쿼리연산자를 이용한 30번째 부서의 최대급여보다 많은 급여 사원구하기 
 select ename, sal from emp 
 where sal > all (select max(sal) from emp where deptno = 30);
 

 create table emp08 as select * from emp where 1 = 0;
 
-- where 1 = 0 조건은 항상 거짖입니다. 이를 이용하면 테이블의
-- 데이터는 가져오지 않고 구조만 가져올 수가 있다.

select round(avg(sal)) "평균급여" from emp;
 --문제: 서브 쿼리를 이용한 30번째 부서의 평균보다 많인 급여사원구하기
select ename, sal from emp where sal > (select avg(sal) from emp);
--30번쨰 부서의 최대굽여 구하기
select max(sal) "최대급여" from emp where deptno = 30;

/*
any연산자
: 조건은 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상만 일치하면 참입니다.
any는 찾아진 값에 대해서 하나라도 크면 참이 되는 셈 입니다.
그러므로 찾아진 값 중에서 가장 작은 값 즉, 최소값 보다 크면 참입니다.
*/

-- 문제: 30번 부서의 최소 급여보다 많은 급여를 받는 사원 구하기
 select ename, sal from emp 
 where sal > any (select min(sal) from emp where deptno = 30);
 
 select min(sal) from emp where deptno = 30; 
 -- min(sal) 250
 
 -- 문제: 다중행 비교방식으로 30번 부서의 최소급여보다 큰 급여를 ename, sal을 조회하세요 
 select ename, sal from emp where sal > (select min(sal) from emp where deptno = 30);
 
 /*
 Exists 연산자:
 서브 쿼리문에서 주로 사용하며 서브쿼리의 결과 값이 나오기만 하면 바로 메인 쿼리의 결과 값을 리턴.
 서브 쿼리의 결과 값이 존재하지않는다면 메인 쿼리의 어떤 값도 리턴되지않는 문장입니다.
 쿼리 속도 면에서 서브리 사용시 in보다는 exists가 훨씬 빠릅니다. 
 exists의 반대말로는 no exists도 가능합니다.
 */
 select * from dept where exists (select * from emp where deptno = 10);
 
 select * from dept where exists (select * from emp where emp.deptno = dept.deptno);
 
 ---------------------------------------------------------------
 --직급이 과장인 사원이 속한 부서의 부서번호와 부서명과 지역을 출력하는 sql문 완성
 select * from dept where deptno in (select deptno from emp where job = '과장');
 
 -- 과장보다 급여를 많이 받는 사원들의 이름과 급여와 직급을 출력하되 과장은 생략하고 작성하세요  all 사용 
 select ename, sal, job from emp 
 where sal > all (select sal from emp where job ='과장'); 
 
 /*
 뷰의 개념
 : 뷰는 한마디로 물질적인 테이블을 근거한 논리적인 가상 테이블이라고 정의할수있습니다.
 뷰는 기본 테이블에서 파생된 객체로서 기본 테이블에 대한 하나의 쿼리문입니다.
 뷰는 '보다' 라는 의미를 갖고 있는 점을 감안해 보면 알수있듯이
 실제 테이블에 저장된 데이터를 뷰를 통해서 볼수 있도록 합니다.
 사용자에게 주어진 뷰를 통해서 기본 테이블을 제한적으로 사용하게 됩니다. 
 
 뷰(view)의 정의와 특징
 1) 뷰의 정의: 하나 이상의 테이블의 데이터의 부분집합으로 구성되는 논리적인 테이블
 2) 뷰 의 특징:
 - 테이블 뿐맘ㄴ 아니라 다른 뷰를 기초로 생성가능
 -뷰 자체는 테이블을 직접 포함하지 않지만, 창문 역할을 하는 뷰를 통하여 데이터의 검색 및 수정이 가능
 - 열 별칭을 사용해서 생성된 뷰에 대해서는 열 별칭을 사용한 조작만 가능 
 
 1. 뷰 사용의 장점:
 테이블을 직접 사용하지않고 뷰를 사용하면 다음과 같은 장점을 얻을수있다.
 (1) 보안을 위해서 DB에 댜한 접근을 제한할수있음
 -> 사용자는 특정 테이블의 데이터 가운데 뷰로 정의된 특정 부분만을 보게 됨
 (2) 복잡한 질의를 단순한 질의로 변환할수있음
 -> 다중 테이블에서 뷰를 생성하면 테이블 조인이 불필요하게됨. 즉, 주로 사용하는
 정보만을 대상으로 데이터 조작을 수행할수있음.
 (3) 데이터 독립성을 허용
 -> 테이블이 변경되어도 뷰는 그대로 유지할수있으므로, 임시 사용자와
 응용 사용자 프로그램에 대한 데이터 독립성을 제공할수있음
 (4) 동일한 데이터에 대해서 다른 뷰를 생성할수 있음.
 -> 조건에 따라 데이터에 접근하는 사용자 급룹 분류해서, 각각 동일한 테이블의 다른 뷰를 
 기초로 데이터 조작을 할수 있게함. 
 
 2. 뷰의 종류: 뷰는 크게 단순 뷰와 복합뷰로 구분할수있다.
-- 단순뷰 (single view): 오직 하나의 테이블만 기초로 생성된 뷰, 표현식 등에 의해 데이터가 
 조작된 경우를 제외하면, 뷰를 통한 모든 DML연산의 수행이 가능
 --복잡 뷰 (complex or join view) : 다중 테이블을 기초로 생성된 뷰, 데이터 그룹핑 또는 
 그룹 함수를 사용해서 뷰 생성 가능. 뷰를 통한 모든 DML이 항상 가능한 것은 아님.
 
 3. view 생성
 create view명령문에 서브쿼리를 이용해서 생성하고
 뷰가 생성된 다음 뷰 이름과 뷰 정의는 데이터 사전의 user_views테이블에 저장된다.
 (1) create view명령의 형식 서브쿼리를 수행해서 가져온 열들만으로 뷰를 생성
 <형식>
 create [force| no force] view 뷰이름 [(열별칭1)] as 서브쿼리 
        [with check option [constraint 제약이름]]
        [with read only];

-열별칭: 서브쿼리에 의해 선택된 열이나 표현식에 때한 별칭을 지정
-force : 기본 테이블의 존재 여부와 무관하게 뷰를 생성
- no force:  기본 테이블의 존재 할때만 뷰를 생성 
-with check option: 뷰에 의해 접근 가능한 행만 삽입 또는 수정될수있음을 명시
- with read only:뷰에 대해서  select만 가능하고, 다른 dml연산은 불가능함을 명시 
 */
 
 create table emp_copy as select * from emp;
 select * from emp_copy;
 
 select empno, ename, deptno from emp_copy where deptno = 30;
 
 desc user_views;
 -- 뷰의 내부구조와 users-views 데이터 딕셔너리 
 
 --grant create view to tester1;
 create view emp_view30 as select empno, ename, deptno
 from emp_copy where deptno = 30;
 -- 권한이 부여되지않음. system에가서 권한을 부여해주어야한다.
 --Ask your database administrator or designated security
-- administrator to grant you the necessary privileges

select view_name, text from user_views;
--결과
--   VIEW_NAME                          TEXT
--  EMP_VIEW30	    "select empno, ename, deptno from emp_copy where deptno = 30"

/*
뷰의 동작원리
1. 사용자가 뷰에 대해서 질의를 하면 user-views에서 뷰에 대한 정의를 조회
2. 기본테이블에 대한 뷰의 접근 권한을 살핌
3. 뷰에 대한 질의를 기본테이블에 대한 질의로 변환
4. 기본 테이블에 대한 질의 통해 데이터를 검색함
5. 검색된 결과를 출력함. 

뷰를 사용하는 이유
1. 복잡하고 긴 쿼리문을 뷰로 정의하면 접근을 단순화 시킨다.
2. 보안에 유리하다 

뷰의 수정 및 삭제와 복합 뷰 생성
1. 뷰의 수정
2. 뷰의 삭제
3. 복합 뷰 생

--뷰의 수정 
 뷰 수정 뷰를 생성할 때 사용한 명령인 CREATE OR REPLACE VIEW
명령을 사용해서, 이미 존재하는 뷰를 대체함으로써 뷰를 수정하게 된다.
(1)CREATE OR REPLACE VIEW명령의 형식 이미 존재하는 뷰를 없애고
같은 이름의 뷰를 새로 생성한다.
단, 기존 뷰가 없는 경우에도 새로운 뷰를 생성.

뷰 수정의 특징
1)이미 생성된 뷰를 그대로 두고 수정하는 것이 아니라,
이미 생성된 뷰를 제거하고 새로운 뷰를 생성해서 대체함으로써
수정하는 효과를 얻게 되는것
2)뷰가 존재하지 않는 경우에도 유류가 발생하지 않고 뷰를 새로 생성하게됨 .

--뷰 삭제
뷰 삭제 DROP VIEW명령으로 뷰를 삭제할 수 있다.
1) DROP VIEW명령의 형식 삭제할 뷰의 이름을 명시한다.
-- DROP VIEW view_name;
2) 뷰 삭제의 특징
뷰가 기초하는 기본 테이블에는 영향을 주지 않고 뷰만 삭제함
즉, 데이터에 전혀 손실을 주지 않고, 논리적인 테이블인 뷰를 삭제함
삭제된 뷰를 기반으로 생성된 뷰나 어플리케이션은 무효화됨
뷰의 생성자 또는 DROP ANY VIEW 권한을 가진 사용자만 삭제 가능

--복합 뷰 생성
CREATE VIEW 명령을 사용해서 다중 테이블로부터 복합 뷰를 생성할 수 있다.
1)CREATE VIEW 명령의 형식 서브쿼리를 수행해서 가져온 열들만으로 뷰를 생성ㅇ한다.
-- 서브쿼리는 두개 이상의 다중 테이블을 검색한다.
-- CREATE[OR REPLACE]] [FORCE | NOFORCE]
--            VIEW 뷰이름 [(열별칭1[,열별칭2....])]
--AS 서브쿼리
--[WITH CHECK OPTION [ CONSTRAINT 제약이름]]
--[WITH READ ONLY];

뷰의 활용
 1. 뷰의 확인
 2. 뷰를 통한 데이터 검색
 3. 뷰 질의의 수행 과정
 4. 뷰에서의 DML연산 수행 규칙
 5. WITH CHECK OPTION옵션
 6. WITH READ ONLY옵션

 뷰 수정하기 위한OR REPLACE옵션
*/
 select* from emp_view30; 
 insert into emp_view30 values(1111,'aaaa',30);
 
 select e.ename, e.empno, sal, e.deptno, d.dname, d.loc
 from emp_copy e , dept d where e.deptno = d.deptno;
 
 create view emp_view_dept as 
 select e.ename, e.empno, sal, e.deptno, d.dname, d.loc
 from emp_copy e, dept d where e.deptno = d.deptno;
 
 select * from emp_view_dept;
 
 create view emp_view as select 
 empno, ename, job, mgr, hiredate, deptno from emp;
 
 select * from emp_view;
 
 --view 수정하기 위한 or replace 옵션
 create or replace view emp_view30 as 
 select empno,ename, sal, comm, deptno
 from emp_copy where deptno = 30;
 
 select * from emp_view30;
 
 /*
 기본 테이블 없이 뷰를 생성하기 위한 force옵션
 뷰를 생성하는 경우에 일반적으로 기본 테이블이 존재한다는
 가정하에서 쿼리문을 작성합니다. 극치 드물기는 하지만, 기본 테이블이 존재하지
 않는 경우에도 뷰를 생성해야할 경우가 있습니다.
 이럴 ㄱㅇ우에 사용하는 것이 force옵션입니다.
 
 경고와 함꼐 뷰를 실행해 보는 겁니다. 
 */
 create or replace force view employees_view
 as select empno, ename, deptno from employees
 where deptno = 30;
 select * from employees_view;
 -- Warning: View created with compilation errors.
 
 select view_name, text from user_views;
 --  view_name                                      text
 --EMPLOYEES_VIEW	"select empno, ename, deptno from employees where deptno = 30"
--EMP_VIEW	            select empno, ename, job, mgr, hiredate, deptno from emp

create or replace force view emp_view30
 as select empno, ename, deptno, sal, comm from emp_copy
 where deptno = 30;
 select * from emp_view30;
 
 --문제: emp_view 뷰에 급여가 500 이상인 사원을 20번 부서로 변경해보기
 update emp_view30 set deptno = 20 where sal >= 500;
 --문제: 변경된 사원들이 있는 20번 부서를 조회해보세요. 
 select * from emp_view30;
 select ename, deptno from emp_copy where deptno = 20;

 
 -- 7명 김사랑 오지호 이변헌 감수성 안성기 강혜정 박중훈
 select ename, deptno from emp where deptno = 20;
 
 -- 5명 그대로이다. 김사랑, 이병헌 안성기 강혜정 박중훈
 drop view employees_view;
 
 
 ------------------------------------------------
 /*
 조건 칼럼 값 변경 못하게 하는 with check option
 뷰를 정의하는 서브 쿼리문에 where절을 추가하여
 기본 테이블 중 특정 조건에 만족하는 로우 (행)만으로 구성된 뷰를 생성.
 뷰를 생성할때 where절을 추가하여 가본 테이블에서 정보가 추출되는 
 조건을 제시하게 되는데 여기에 연속적으로 with check option을 기술
 하여 조건제시를 위해 사용한 칼럼의 값이 뷰를 통해서 변경되지 못하도록 할수있습니다. 
 */
 
 create or replace view emp_view30
 as select empno, ename, sal, comm, deptno
 from emp_copy where deptno = 30 with check option;
 
 create table emp_copy2 as select * from emp;
 
 create or replace view view_chk30 as select
 empno, ename, sal, comm, deptno from emp_copy2
 where deptno = 30 with check option;
 
 update view_chk30 set comm = 1000;
 
 select * from view_chk30;
 
 create or replace view view_read30 as select
 empno, ename, sal, comm, deptno from emp_copy2
 where deptno = 30 with read only;
 
 select * from view_read30;
 update view_read30 set comm =2000;
 -- cannot perform dml operation(SELECT, INSERT, UPDATE, DELETE ) on read only view 
 
 create or replace view view_hire as select empno, ename, hiredate
 from emp order by hiredate;
 
 select * from view_hire;
 
 /*
 rownum 컬럼 성격 파악하기
 : 오라클의 내부적을 부여되는데 inset문을 이용하여 입력하면
 입력한 순서에 따라 1씩 증가되면서 값이 지정됩니다.
 데이터가 입력된 시점에서 결정되는 rownum칼럼 값은 바뀌지않습니다.
 */
 --입사일을 기준으로 오름차순 정렬한 후 rownum컬럼 출력하기
 
select rownum, empno, ename, hiredate
from view_hire where rownum <= 5;

/*
뷰와 rownum칼럼으로 ton-n구하기:
입사일이 빠른 사람 5명만을 얻어오기 위해서 입사일 순으로 뷰를 생성하고
이를 다시 상위 5개만 얻어오기 위해서 뷰를 select문으로 조회하면서
뷰를 rownum칼럼을 where절의 조건으로 제시하였습니다. 

인라인 뷰로 top-n구하기
인라인 뷰는 sql문장에서 사용하는 서브쿼리의 일종이다.
보통 from절에 위치해서 테이블처럼 사용한다.
>> 형식:
select... from ... (select ... ) alias  ...; <-서브쿼리 
main query (바깥쪽 쿼리문) sub query (안쪽 쿼리문) --> 인라인문
*/
-- 문제: 인라인 뷰로 입사일이 빠른 사람 5명만 출력해보기
SELECT ROWNUM, EMPNO, ENAME, HIREDATE FROM
(SELECT * FROM EMP ORDER BY HIREDATE DESC) alias
WHERE ROWNUM <= 5; 
 -- 부서별 최대급여와 최소급여를 출력하는 sal_view를 구해보기
 create view sal_view as select d.dname , max(e.sal) as 
 max_sal, min(e.sal) as min_sal from emp_copy e, dept d
 where e.deptno = d.deptno group by d.dname;
 
 -- rownum을 이용해서 조회해보기
 select rownum, dname, max_sal, min_sal from sal_view;
 
 --급여를 많이 받는 순서대로 3명만 출력하는 인라인뷰 정의하기

 select rownum as raking, empno, ename, sal
 from (
        select empno, ename, sal
        from emp_copy where sal is not null
        order by sal desc
 )
 where rownum <= 3;
 
 
 /*
 시퀀스 개념 이해와 시퀀스 생성
 : 테이블 내의 유일한 숫자를 자동으로 생성하는 자동 번호 발생기 이므로 시퀀스를
 기본키로 사용하게되면 사용자의 부담을 줄일수있게 된다.
 >> 형식:
 create sequence sequence_name
                start with n
                incremeny by n
                maxvalue n | nomaxvalue
                minvalue n | nominvalue
                cycle | noncycle
                cache n |nocache

시퀀스를 생성의 시작은 create sequence로 시작합니다. 

(1) 시퀀스의 정의
: 자동으로 테이블의 행에 대한 유일한 (unique) 번호를 생성하는 DB객체이다

(2) 시퀀스의 특성
: 여러 사용자가 공유 가능한 객체, 시퀀스 값을 액세스하는 효율성을 향상하기 위해서,
시퀀스 값을 미리 생성해서 메모리에 저장해 두고 사용할수있음.
주로 기본 키 값을 생성하는데 사용됨.
테이블과 독립적으로 존재. 동일한 시퀀스가 여러 테이블에 대해 사용될수있음.

(3) 시퀀스 정의방법 
: create sequence 명령을 사용해서 시퀀스를 정의한다. 
--1. 형식: 시퀀스를 정의하면 시퀀스의 초기값등 여러가지 옵션을 지정할수 있으며,
    밑줄 표시한 것이 디폴트로 설정된 옵션
    >> 형식:
    create sequence 시퀀스_이름
            start with n
                incremeny by n
                maxvalue n | nomaxvalue
                minvalue n | nominvalue
                cycle | noncycle
                cache n |nocache);
    
    형식중 'nomaxvalue, nominvalue'에서 'no'는 없다는 의미가 아니라
    너무 크거나 작아서 최대/최소값 지정을 생략한다는 의미.

create sequence 명령의 옵션들
< 옵션 설명>
*increment by n : 시퀀스 번호의 간격을 n으로 설정 (생략시 '1'씩 등가)
*start with n :생성할 첫번째 시퀀스 번호를 n으로 지정 
*max value :n 생성할 시퀀스의 최대값을 n으로 설정
*no max value: 오름차순용으로 10^27, 내림차순용으로 -1을 지정 (최대값의 한계를 정하지않겠다는 의미로 사용)
*min value: n생성할 시퀀스의 최소값을 n으로 설정
*no min value: 오름차순용으로 1, 내림차순용으로 1(10^26)을 지정 (최소값의한계 지정하지 않겠다는 의미)
*cycle/ no cycle :최대값 또는 최소값에 도달한 후, 값을 계속 생성할지 여부를 지정 (디폴트 설정 은 no cycle)
    cycle로 지정한 후, 최대값 또는 최소값에 도달한 후 첫번째 시퀀스 번호부터 다시 생성. 단, 기본키에 대해서 cycle옵션 지정 불가능
*cache/ no cache : 얼마나 많은 시퀀스 값을 미리 생성해서 메몰에 저장하고 있을지를 지정
    (디폴트 n 값은 20. 즉, 20개의 시퀀스를 미리 생성해서 메모리에 저장해둠으로써 시퀀스를 액세스하는 효율성을 향상시킴)
    

의사열, nextval과 currval
의사열(pseudo column)이란?
: 시퀀스에 의해서 자동으로 생성되는 가상의 열을 의미한다. 
>>nextval
:다음에 사용 가능한 시퀀스 값을 생성. nextval에 의해서 새 시퀀스 값이 생성된 다음, 
그 값이 currval에 저장됨 
>> currval
:가장 최근에 생성된ㄴ 형재의 시퀀스 값을 반한함

의사열 사용 형식
: 시퀀스 이름뒤에 점을 찍은 다음 nextval 이나 currval을 기술한다.
시퀀스_이름.nextval 또는 시퀀스_이름.currval

!!주의사항!!
currval이 참조되기 전에 반드시 nextval이 생성되어야함
의사열의 값을 확인할때는 더미 테이블인 dual을 이용함. 
 */
 
drop sequence dept_deptno_seq;
 
 create sequence dept_deptno_seq increment by 10 start with 10;
 
 /*
 start with : 시퀀스번호의 시작값을 지정할때 사용하고 start with 1이라고 기술합니다.
 increment by: 연속적인 시퀀스 번호의 증가치를 지저할때 사용 1씩 증가하면 incremeny by 1
 cycle | no cycle:최대값까지 증가하고 나면 완료하고 다시 start with option을 지정한 시작값에서 다시 시작한다.
            no vyvle은 증가가 완료되면 레러를 유발시킨다.
cache : 메모상의 시퀀스관리값을 관리 기본값은 20 
no cache: 메몰상에서 시퀀스를 관리하지않습니다. 
 */
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.currval from dual;
/*
curval - nextval 활용법
시퀀스의 현재 값을 알아내기 위해서 currval사용하고 다음 값 을 알아내기 위해서는 nextval사용
currval = current value 현재 값을 반환한다.
next val = next value 다읍값을 의미한다.
현재 시퀀스값의 다음 값을 반환한다. 

>>nextval, currval사용할수 있는 경우:
-서브쿼리가 아닌 select문 
-insert문의 select절
-update문의 set 절 

>>nextval, currval사용할수 없는 경우:
- view의 select절
- distinct 키워드가 있는 select문
- group by, having, order by 절이 있는 select문
- select, delete, update,의 서브쿼리
-create table , alter table명령의 default값
-시퀀스 객체 생성하기 sample_seq
*/
create sequence sample_seq;
--시퀀스 객체로 부터 현재 값 알아내기

select sample_seq.nextval from dual;
select sample_seq.currval from dual;
-- not yet defined in this session
-- select NEXTVAL from the sequence before selecting CURRVAL
-- currval 생성 전에 nextval을 미리 설정후에 currval을 생성해주어야한다.

/*
시퀀스 오륲
: 다음과 같은 이유 때문에 시퀀스 값에서 불규칙한 간격이 생기는 오류가 발생
(1) 시퀀스 오류의 원인
> rollback이 발생한 경우
: 시퀀스를 포함한 문장을 롤백하면, 커밋 이후 롤백. 이전에 생성된 시퀀스 번호를 모두 잃게
되므로 이후 시퀀스에 간격이 생김

> 시스템이 손상된 경우
: cache옵션을 설정해서 미리 시퀀스를 생성해서 메모리에 저장해둔 후, 시스템의 손상으로 비정상적으러
종료하게 되면 미리 생성한 시퀀스값을 모두 잃어버리게 되므로, 이후 시퀀스에 간경이 생김

> 동일한 시퀀스가 다중 테이블에서 사용한 경우 
: 시퀀스값이 불규칙적으로 변할수 있음. 
*/

drop sequence sample_seq;
--시작값이 1이고 1씩 증가하고 최대값이 100000이 되는 emp_seq 생성
create sequence emp_seq
                start with 1
                increment by 1
                maxvalue 100000;

drop table emp01;

create table emp01 (
        empno number(4) primary key,
        ename varchar(10),
        hiredate date
);

--제약조건 확인하기
select constraint_name, constraint_type, r_constraint_name, table_name
from user_constraints
where table_name in('EMP01');

select constraint_name, table_name, column_name
from user_cons_columns
where table_name in('EMP01');

insert into emp01 values (emp_seq.nextval, '홍길동', sysdate);
insert into emp01 values (emp_seq.nextval, '강감찬', sysdate);
insert into emp01 values (emp_seq.nextval, 'JULIA', sysdate);
select * from emp01;

select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;
-- 시퀀스 조회하기 

drop sequence dept_deptno_seq;

select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;


create sequence dept_detpno_seq
    start with 10
    increment by 10
    maxvalue 30;
    
select dept_detpno_seq.nextval from dual;

select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

/*
시퀀스 수정 
alter sequence명령으로 시퀀스의 증가치, 최대값, 최소값 사이클 및 캐쉬 옵션을 변경할수있다.

alter sequence명령의 형식
start with 옵션을 제외하고, 시퀀스를 새어성할때 지정한 여러 옵션의 값을 변경할수있다.
alter sequence sequence_name
        increment by n
        maxvalue n |  nomaxvalue
        minvalue n | nominvalue
        cycle | nocycle
        cache | nocache
        
시퀀스 수정 지침
: 생성자나 alter권한을 가진 사용자만 수정할수있다.
시퀀스 수정하면, 수정이후 생성되는 시퀀스 번호에만 영향을 미침.
시퀀스를 생성할때 다른 시작 번호부터 다시 생성하려면 기준 시퀀스를 삭제하고 다시 생성해야함
유효성 검사를 자동으로 수행함.
ex. 수정된 maxvalue가 현재 시퀀스보다 작은 경우, 수정이 허용되지않는다.
*/
create sequence dept_deptno_seq
        start with 10
        increment by 10
        maxvalue 30;

select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

select dept_deptno_seq.nextval from dual;

alter sequence dept_deptno_seq 
                        maxvalue 100 
                        cycle 
                        cache 2;

--cache | no cache: 
-- cache: 메모리상의 시퀀스 관리값을 관리 기본값은 20
-- no cache:메모리상의 시퀀스를 관리하지않습니다.

select dept_deptno_seq.nextval from dual;

select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

drop sequence dept_deptno_seq;

create table dept_example (
    deptno number(4) primary key,
    dname varchar(15),
    loc varchar(15)
);

select constraint_name, constraint_type, r_constraint_name, table_name
from user_constraints
where table_name in('DEPT_EXAMPLE');


--복합키인지 아닌지 살펴보기위해 쩨약조건이 지정된 칼럼 살펴보기
select constraint_name, table_name, column_name
from user_cons_columns
where table_name in ('DEPT_EXAMPLE');

create sequence dept_example_seq
increment by 10
start with 10
nocycle;

select sequence_name, min_value, max_value, increment_by, cycle_flag
from user_sequences;

insert into dept_example values(dept_example_seq.nextval, '인사과', '서울');
insert into dept_example values(dept_example_seq.nextval, '경리과', '서울');
insert into dept_example values(dept_example_seq.nextval, '총무과', '대전');
insert into dept_example values(dept_example_seq.nextval, '기술팀', '인천');

select index_name, table_name, column_name from user_ind_columns
where table_name in ('EMP', 'DEPT');

----------------------- HR_12 정리 -----------------------------------


