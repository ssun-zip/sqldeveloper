SELECT * FROM DUAL;
--dual 테이블은 사용자가 함수계산을 실행할때 임시로 사용하는데 적합하다. 
-- dummy 

SELECT 24 * 60 FROM DUAL;
-- 함수계산 24 * 64 = 1440

SELECT * FROM TAB;
--작성된 테이블 목록 확인 

DESC emp;
-- 테이블의 구조를 살펴보기 

SELECT * FROM emp;
--사원 테이블 조회하기

SELECT * FROM dept;
-- 부서명테이블 조회하기 

SELECT empno, ename FROM emp;
-- 사원번호 and 사원이름 조회하기

SELECT ename, sal, sal*12 FROM emp;
-- 전 사원의 이름, 월급, 연봉 조회하기  

select ename, sal, job, sal*12, sal*12*comm, comm, deptno
from emp;
-- 테이블에서 이름, 월급, 직급, 연봉, 
select ename, comm, sal*12*comm, nvl(comm, 0), sal*12+nvl(comm,0)
from emp;

select ename, sal*12+nvl(comm, 0)
from emp;

-- null처리를 위한 nvl함수
-- nvl은 nullㅎ값을 다른 값으로 대처하기 위한 함수
-- syntax : nvl (expr1, expr2)
-- expr1 이 null이면 expr2를 리턴한다
-- expr 1 이 !null이면 express1을 리턴한다
-- express n1 과 express2 는 여러 데이터 타입을 가질수 있는데
-- 서로 데이터 타입이 다르면 express1데이터 타입을 리턴

select ename, sal*12+nvl(comm, 0) as Annsal
from emp;

select ename, sal*12*nvl(comm, 0) Annsal
from emp;

select ename, sal*12*nvl(comm, 0) "Annsal"
from emp;

select ename 사원명, sal*12*nvl(comm, 0) 연봉
from emp;

select ename, sal*12*nvl(comm, 0) "A n n s a l"
from emp;

select ename || '의 직급은 ' || job || '입니다.' as 직급
from emp;
-- java || 는 + 의 의미를 가지고 있다. 
-- 오라클에서는 여러개의 칼럼을 연결할 때 사용하기 위해서 concatenation
-- 연산자를 제공해줍니다. 영문장처럼 보이도록 하기 위해서 || 를 컬럼과
-- 문자열 사이에 기술하여 하나로 연결하여 출력하면 됩니다. 

select deptno from emp;

select distinct deptno from emp;

desc dual;
select * from dual;

select * 
from emp
where sal >= 500;

select *
from emp
where sal ^= 500; -- <> !=

select *
from emp
where not deptno = 10;
--MYSQL 에서는 안먹힐수도 있음 but oracle works

select *
from emp
where ename = '이문세';
-- 이름에 '' 표시를 안해줘서 인식할수없음. 
-- identifier 은 표식을 해주어야한다. 
-- 오라클에서는 "" 사용할수없음. 

select *
from emp
where hiredate < to_date('2005/03/20', 'YYYY/MM/DD');
--입사일자가 주어진 날짜보다 전이여야한다. 

select *
from emp
where hiredate > to_date('2005/03/20', 'YYYY/MM/DD');
--입사일자가 주어진 날짜 이후에 들어오신 분들 조회  

-----------------------------------------------------------------------------------------------
-- 문제: emp 테이블로부터 조건절에서 부서번호가 10인 부서만 조회하세요

select *
from emp
where deptno = 10;

-- 문제2: emp 테이블로부터 이름이 이문세만 조회하세요
select *
from emp
where ename = '이문세';

--입사일이 2005년 3월 20일 전에 입사한 사람을 조회하세요 
select *
from emp
where hiredate < to_date('2005/03/20' , 'YYYY/MM/DD');

-- 논리연산자를 사용하여 10번 부서이고 직급이 과장인 사람을 조회해 보세요.
select *
from emp
where deptno = 10 and job = '과장';

-- 논리연산자를 사용하여 10번 부서가 아닌 테이블을 조회하세요
select *
from emp
where not deptno = 10; -- <> 
-------------------------------------------------------------------------
-- between and 연산자
-- 특정 범위 내에 속하는 데이터인지를 알아보기 위해서
--비교연산자와 논리 연산자를 결합하여 표현할수 있습니다ㅑ.
-- column_name between a and b;
-- 문제: 급여가 400에서 500사이인 사원 출력하기
select *
from emp
where sal between 400 and 500;
--sal >= 400 and sal <= 500

--in 연산자
--특정 필드의 값이 a이거나 b이거나 c중에 어느 하나만 만족하더라도
--출력하도록 하는 표현을 in연산자를 통하여 할수 있습니다
-- column_name in (a, b, c);
--문제: in연산자 사용하여 커미션이 80이거나 100 200인 사원 조회하가ㅣ
select * from emp where comm in (80,100,200);

-- hiredate와 between을 사용하여 2003년 입사한 직원을 출력하세요
-- hiredate출력형식이 yyyy/mm/dd 로 해주세요
select * from emp where hiredate between '2003/01/01' and '2003/12/31';
select * from emp where hiredate
between to_date('2003/01/01', 'YYYY/MM/DD') and to_date('2003/12/31', 'YYYY/MM/DD');

--위에서 결과와 같이 in연산자를 사용하여 출력해보세요
select * from emp where comm != 80 and comm <> 100 and comm <> 200;
select * from emp where comm not in (80, 100, 200);

-- Like 연산자와 와일드 카드
-- column_name like pattern
--like 다음에는 pattern을 기술해야 하는데 pattern에
-- 다음과 같이 두가지 와일드 카드가 사용됩니다
-- %: 문자가 없거나, 하나 이상의 문자가 어떤 값이 와도 상관 없다
-- _: 하나의 문자가 어떤 값이 와도 상관 없다
-- 문제: 이씨성을 like를 이용하여 이름을 출력해보세요
select * from emp where ename like '이%';
    -- start with
    
-- 성이 아무데나 들어가기만 해도 되는 이름을 조회해보세요
select * from emp where ename like '%성%';
    --any position 
    
--성이 뒤에만 들어가는 이름을 출력해보세요
select * from emp where ename like '%성';
    --last position
    
-- 성이 가운데만 들어가는 이름을 출력해보세요
select * from emp where ename like '_성%';

-- 성이 안들어가는 이름을 출력해보세요
select * from emp where ename not like '%성%';
    -- 성이 아무데나 들어가는 것인데 아닌것을 찾으면됨 

select ename, deptno, comm from emp;


-----------------------------------------------------------
-- null값을 찾기 위한 is null
-- 대상 컬럼 is(연산자) null (비교값);
-- 문제: 보너스가 null인 사람을 조회해 보세요
select * from emp where comm is null;

-- 문제: 커미샨이 널이 아닌 사람을 조회해보세요. 
select * from emp where comm is not null;

-- 정렬을 위한 order by절 형식
-- select * [column1, column2, ... column]
-- from table_name
-- order by column_name sorting;
--ORDER BY 절 다음에는 어떤 칼럼을 기준으로 정렬할 것인지를
-- 결정해야 하기에 컬럼 이름을 기술해야 합니다. 그다음에는 
-- 오름 차순으로 정렬 (ASC) 할지 내림차순을 정률 (DESC)할지
-- 정렬 방식을 기술해야합니다

-- ASC오름차순                            DESC 내림차순 > 역순으로
-- 숫자 > 작은값 부터 정렬
-- 문자 > 사전 순서로 정렬
-- 날짜 > 빠른 날짜 순서로 정렬
-- null > 가장 마지막으로 나온다

-- 문제: 급여를 많이 받는순으로 출력 급여가 같으면 이름순으로 출력 emp테이블 금여가 많다 -> desc
select * from emp order by sal desc, ename asc;

--급여를 많이 받는 사람부터 적게 받는 사람 순으로 순차적으로
--출력하는 결과 화면을 살펴보면 동일환 급여 받는 사람이 존재합니다.
--급여가 같은 사람이 존재할 경우 이름의 절차가 빠른 사람부터
-- 출력되도록 하려면 정렬 방식을 여러가지로 지정해야 합니다.

-- 문제: 입사날짜가 최근순으로 하고 날짜가 같을시에 이름순으로 출력:
-- 입사날짜가 최근순이라는 것은 크다 많다가 아니라서 desc로 풀어야만한다.
select * from emp order by hiredate desc, ename asc;

-- 집합연산자
--UNION(합집합) difference(차집합), intersect(교짐합)dptjsms
--입력 테이블과 결과 테이블에서 중복된 레코드가 배제됩니다.
-- union all(합집합) , difference all(차집합), intersect all(교짐합)
-- 에서는 입력 테이블과 테이블에 중복된 레코드가 허용됩니다.
-- 형식: <쿼리1> 집합연삱자1 <쿼리2> 집합연산자2 <쿼리n>

--중복된 레코드가 배제됨
--문제: 그룹활동과 싱글활동을 하는 가수 이름 출력하기
select * from GROUP_STAR
union 
select * from SINGLE_STAR;

--union all 연산자는 union고 같지만 중복된 데이터가 제거되지않습니다.
-- 그룹활동과 싱글활동을 하는 가수이름을 중복하여 출력하기
select * from GROUP_STAR
union all
select * from SINGLE_STAR;

--intersect 연산자는 수학의 집합 연산에서 교집합을 의미합니다. 
-- 즉, 두개의 테이블에 모두 속하는 행 집합을 결과 집합으로 반환합니다.
select * from GROUP_STAR
intersect
select * from SINGLE_STAR;

-- 이해를 돕기 위해서
--group star
--태연 유리 윤아 효연 티파니 제시카 주영 써니 서현 탑 지디
-- 대성 승리 태양
--single star
-- 태연 지디 대성 태양 아이유 백짖영 윤종신

-- 싱글스타 테이블에서 그룹스타 테이블을 minus연산하면
-- 싱글스타 테이블에 속하지만
-- 그룹스타 테이블에는 속하지않는 행 집합을 결과 집합으로 반환합니다
-- 문제: minus 를 사용하여 백지영, 아이유, 윤종신이 나오세 출력하세요
select * from SINGLE_STAR
minus
select * from GROUP_STAR;

-- dual 테이블이란?
-- dual 테이블이란 바로 산술 연산의 결과를 한줄로 얻기 위해서 오라클에서 제공하는 테이블
-- 문제: 칼럼이름에 별칭 지정해서 출력하기 from dept
-- 부서번호 부서명
-- 10 경리부
-- 20 인사부
-- 30 영업부
-- 40 전산부

select deptno 부서번호, dname as 부서명 from dept;
--중요!!!

-- 이름이 "오지호"인 사원의 사원번호, 사원명, 급여를 출력하기 from emp
select empno 사원번호 , ename 사원명 ,sal as 급여 from emp where ename = '오지호';

--급여가 250이거나 300이거나 500인 사원들의 사원번호와 사원명과 급여를 겁색하기 (in 사용)
select empno, ename, sal from emp where sal in (250, 300, 500);

--급여가 250이거나 300이거나 500도 아닌 사원들을 검식하기 (식을 비교연산자를 사용해서 출력)
select empno, ename, sal from emp where sal <> 250 and sal != 300 and sal ^= 500;

-- 급여가 250이거나 300이거나 500도 아닌 에서 이거나 하면 언뜻보면
-- OR조건이 생각나지만 250 300 500 조건이 아닌 것을 찾아야 하기 땜시
-- and 조건이 성립된다. 즉 문장에 현혹되면 안된다 '-거나' 가 속임수를 의미
-- 전체적인 맥락을 이해햏야만 한다
select empno, ename, sal from emp where sal not in (250, 300, 500);

-- 문제: like 연산자와 와일드 카드를 사용하여 사원들 중에서
-- 이름이 "김" 으로 시작하는 사람괴
-- 이름중에 "기"를 포함하는 사원의 사원번호와 사원이름을 출력하기
select ename, empno from emp where ename like '김%' 
union all
select ename, empno from emp where ename like '%기%';

-- 문제: 상관이 없는 사원을 검색하기 (즉 사장이 되겠지요)
select ename, job from emp where job = '사장';

--문제: 사원 테이블에서 최근 입사한 직원순으로 사원번호, 사원명, 직급, 입사일 컬럼만 출력하기
--     형식 YYY/MM/DD
select empno, ename, job, hiredate from emp order by hiredate asc;
--문제: 부서번호가 빠른 사원부터 출력하되 같은 부서내의 사원을 출력할 경우 입사한지
--가장 오래된 사원부터 출력하기 
-- 힌트 >> to_char() 사용하세요
select empno, ename, job, to_char(hiredate, 'YYYY/MM/DD')
from emp order by deptno asc, hiredate asc;

-- 숫자 함수
-- 숫자 데이터를 처리하기 위한 함수
select -10, abs(-10) from dual;
--절대값을 구하기

--소수점 아래를 버리는 floor 함수
select 34.5656565, FLOOR(34.5678) from dual;

--나머지를 구하는 mod함수
select mod(27,2), mod(27,5), mod(27,7) from dual;

--특정 자리수에서 반올림하는 round 함수
select 34.567788, round(34.56789) from dual;

/*sysdate() */
select sysdate from dual;
--더미테이블 현재 날짜

/* add_months() */ --개월수 더하기
select add_months(sysdate, 7) from dual;
--현재 4월 + 7
-- dho 21/05/23이 나오는가
-- 현재 sys date 가 2020/10/23 -> +7 월 -> 21/05/23일

/*next_day()*/
select next_day(sysdate, '일요일') from dual;
--현재 날짜에서 다음 일요일이 나온다.
-- 왜 10월 25일 인가?
-- 현재 날짜에서의 다음 일요일은 이틀뒤인 25일이다. 오늘이 금요일이기 때문이다

/*last_day()*/
select last_day(sysdate) from dual;
--행당월의 마지막 날짜가 나온다
-- 20/10/31

/*to_char()*/
select to_char(sysdate, 'yyyy/mm/dd') from dual;
--현재 날짜가 형식대로 나오기

/*to_date()*/
select to_date('2015/03/04','yyyy/mm/dd') from dual;
-- 15/03/04

--특정 자리수에서 잘라내는 TRUNC함수에 대하여 적으세요
-- 원래값 : 34.5678
-- 문제:  출력 결과 화면이 34.56  |   30     |   34 
select trunc(34.5678, 2), trunc(34.5678, -1), trunc(34.5678,0) from dual; 
-- 일의 자리 숫자는 마이너스 표시로 하고
-- 소수점이 있는 부분에서는 정수로 표시 






