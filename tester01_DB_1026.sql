-- 부서번호와 salary를 3번째 숫자까지 round
-- Rounds(x, d) the argument X to D decimal places
select deptno, round(sal, 3) from emp;

-- 나머지를 구하는 mod함수
-- result: 1, 2,6
select mod (27,2) , mod(27,5), mod(27,7) from dual;

--특정 자리수에서 반올림하는 round 함수
-- 소수점이하 반올림하
-- result: 35
select 34.5678, round (34.5678) from dual;

--대소문자 변환함수
-- upper 대문자 변환
-- lower 소문자 변환
-- initcap 첫글자만 대문자로, 나머지는 소문자로 변환
-- result: Welcome To Oracle
select 'welcome to Oracle', initcap('WELCOME TO ORACLE') from dual;
--result: welcome to oracle
select 'welcome to Oracle', lower('WELCOME TO ORACLE') from dual;
-- result: WELCOME TO ORACLE
select 'welcome to Oracle', upper('WELCOME TO ORACLE') from dual;

--칼럼에 저장된 데이터 값이 몇개의 문자로 구성되어있는지를 알려주는 함수
-- length     문자의 길이를 반환한다 1바이트 
-- lengthb   문자의 길이를 반환한다 2바이트 
-- 영문자와 한글의 길이를 구해보자문
-- result: oracle -> 6, 오라클 -> 3
select length('Oracle'), length('오라클') from dual;

--영문자와 한글의 바이트수 구하기 
-- result : oracle -> 6, 오라클 -> 9
select lengthb('Oracle'), lengthb('오라클') from dual;

-- 문자 길이를 구하는 함수
--length 문자열의 길이를 반환한다. 공백포함 (1바이트씩)
--lengthb 문자열의 바이트를 반화한다
-- 영문(1바이트), 공백 (1바이트), 한글(3 바이트)
-- length 함수는 컬럼에 저장된 데이터 값이 몇개의 문자로
-- 구성되어있는지 길이를 알려주는 함수입니다. \

select 
    length ('180712 테스트') as length1,
    lengthb('180712 테스트') as lengthb1
from dual;

--result: length1: 10 && lengthb1 = 16 

-- concat 문자의 값을 연결한다
-- substr 문자를 잘라 추출한다(한글 1바이트)
-- substrb 문자를 잘라 추출한다(한글 3 바이트)
-- instr 특정 문자의 위치값을 반환한다 (한글 1바이트)
-- instrb 특정 문자의 위치값을 반환한다( 한글 3바이트)
-- lpad, rpad
-- 입력받은 문자열과 기호를 정렬하여 특정 길이의 문자열로 반환한다. 

--형식
--substr(대상, 시작위치, 추출할 개수)
select substr('Welcome to Oralce', 4,3) from dual;
--result: com 
select substr('Welcome to Oralce', 4,3),  substrb('Welcome to Oralce', 4,3)from dual;
-- 영문 추출은 동일 result: com, com

--한글 1자는 3바이트를 차지하기 때문에 substr함수와 
--substrb 함수의 결과가 달라집니다.
select substr ('웰컴투 오라클', 4, 3), substrb ('웰컴투 오라클', 4, 3) from dual;
-- result :오라,  컴 

select instr('welcome to oracle', 'o') from dual;
-- result : 5 -> 5번째 위치에 첫  o 가 존재한다 

select instr('데이터베이스', '이', 4, 1), instrb('데이터베이스', '이', 4, 1) from dual;
-- result : 5, 4
-- INSTR('문자열', '찾고싶은 문자열', 시작위치, 발견 인덱스)
-- 4번째 부터 시작하는 문장을 추출하여 이의 위치를 
-- 찾는다 그리고 이후 발견되는 첫번쨰 D의 값을 반환한다 

-- instr: 시작 위치 4이니까 몇번째 발견이 1이므로 결과위치는 이가 5이다.
-- instrb: 시작위치 4이니까 몇번째 발견이 1이므로 결과 위치는 이가 4이다
--             못찾으면 0이 나오게된다. 몇번째 발견을 2로 바뀌어서 해보면 조금 더 이해가 갈수있다.

select instr('데이터베이스', '이', 4, 2), instrb('데이터베이스', '이', 4, 2) from dual;
-- result : 0, 13
-- instr에서 4번째 부터 시작하는 문장을 추출하여 두번째로 발견되는
-- '이'를 찾는다. 하지만 존재하지않기에 0을 추출한다.
-- instrb경우 4번째부터 byte 즉 두번째 이부터
-- 시작하는 문장을 추출하여 두번쨰로 발견되는
-- '이'를 찾아 그의 byte로 반환한다. 
-- 데       이        터        베           이        스
-- 1-3   4-6  7- 9   10- 12   13-15  18

-- c:\DB백업폴더 만들어주기 줄바꿈하지마세요
-- cmd 
-- exp userid-tester1/1234@xe owner-tester 1 file=c:\DB백업\tester1_bak.dmp
-- 백업된폴더로 가서 확인해 보고
-- 혹 안될시에는 userid를 system로 해봅니다
-- 대소문자 구분안함
-- 오너는 해당스키마 (=사용자) , 백업 파일은 임의의 이름을 주면됩니다.
--select * from single_star;
-- drop table single_star;
--테이블 삭제 합니다

-- 해당 테이블만 복원해보기 줄바꿈하지말기
-- imp userid=tester1/1234@xe fromuser=tester1 touser=tester1 file=\DB백업\tester1_bak.dmp tables = (single_star)
---------------------------------------------------------------------------------
--특정기호로 채우는 lpad/rpad
-- lpad(left padding): 함수는 컬럼이나 대상문자열을 명시된 자릿수에서
-- 오른쪽에 나타내고 남은 왼쪽 자리를 특정기호로 채웁니다.
select lpad('Oracle', 20, '#') from Dual;
-- result: ###########Oracle

--현재 날짜를 형변환 형식으로 출력하기
select SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') from dual;
--result: 20/10/26    && 2020-10-26

--  number   <---> character  <---->   date

--현재 날짜와 시간을 출력해보기
select to_char(sysdate, 'YYYY/MM/DD, AM HH:MI:SS') from dual;
--result: 2020/10/26, AM 02:32:50

select to_char(12300000), to_char(12300000, 'L999,999,999') from dual;
-- result: 12300000    &&   W12,300,000

--형변환 함수
--변환함수는 자료형을 변환시키고자 할때 사용하는 형변환 함수로는
--to_number , to_char, to_date가 있습니다.
--to_number: 문자형을 숫자형으로 변환한다. 
-- to_char: 날짜형 혹은 숫자형을 문자형으로 변환한다.
-- to_date: 문자형을 날짜형으로 변환한다.


-- 문자형으로 변환하는 to_char 함수 
-- 형식: to_char(날짜데이터, '출력형식')
-- 출력형식 종류:
--YYYY, YY
-- MM, MON
-- DAY, DY

--시간출력 형식
--AM , PM
-- HH, HH12,  HH24
-- MI (분), SS (초)


--숫자형을 문자형으로 변환하기
-- 0 : 자리수, 자리수가 맞지않을경우 0으로 채운다
-- 9 : 자리수, 자리수가 맞지 않아도 챙지않는다.
-- L  :각지역별 통화기호를 앞에 표시한다
-- .   :소수점
-- ,   :천자리구별 

--날짜형으로 변환하는 to_date 함수
-- 형식: to_date('문자', 'format');
-- 문제 > emp테이블럽 부 터 2007년애 4월 2일에 입사한 사원을 검색하세요
--              to_date() 사용합니다.
select * from emp where hiredate = to_date('2007/04/02', 'YYYY/MM/DD');
----------------------------------------------------------------
--숫자형으로 변환하는 to_number 함수
select to_number('20,000', '99,999') - to_number('10,000', '99,999') from dual;
-- result: 10000

--날짜 함수는 date(날짜)형에 사용하는 함수이며 결과 값으로
-- 날짜또는 기간을 얻습니다. 기간은 주로 일 단위로 계산되지만,
-- 월 단위로 계산되는 경우도 있습니다.

-- sysdate: 시스템에 저장된 현재 날짜를 반환한다
-- months_between 두 날짜 사이가 몇개월인지 반환한다
-- add_months 특정날짜에 개월수를 더한다
--next_day: 특정날짜 에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환한다
--last_day: 해당날짜의 마지막 날짜를 반환한다

--특정기준으로 반올림하는 round 함수
--round함수는 숫자를 반올림하는 함수로 학습하였습니다. 하지만, 이함수에 포맷 모델을 지정하면 숫자 이외에 날짜에
-- 대해서도 반올림을 할수있습니다.
-- 형식:round(date, format);
-- CC, SSS : 4자리 연도의 끝 두자리를 기준으로 반올림한다
--SYYY, YYYY, YEAR, SYEAR, YYY, YY, Y 년 (7월 1일부터 반올림)
-- DDD, D, J 일을 기준
-- HH, HH12, HH24 시를기준
-- Q 한분기의 두번쨰 달의 16일을 기준으로 반올림
--MONTH, MON, MM,RM ,월(16일을 기준으로 반올림)
-- DAY, DY, D 한로주가 시작되는 날짜
--MI분을 기준으

-- 특정기준으로 버리는 trunc함수
-- trunc함수 역시 숫자를 잘라내는 것뿐만 아니라 날짜를 잘라낼수있습니다.
--round 함수와 마찬가지로 포맷형식을 주어서 다양한 기준으로 날짜를 잘라낼수있습니다.
--형식: trunc(date, format)
--문제: 입사일 기준으로 달을 기준으로 잘라내기 to_char()사용합니다.
SELECT to_char(hiredate, 'YYYY/MM/DD') 입사일,
to_char(TRUNC(hiredate, 'MONTH'), 'YYYY/MM/DD') 입사일
from emp;

--두 날짜 사이 간격을 months_between  함수: 날짜와 날짜사이의 개월수를 구하는 함수이다
-- 형식: months_between(date1, date2)

--문제> 날짜의 개월수를 구해보자 오늘로부터 입사일 사이의 개월수를 구하면된다
-- 출력형식 ename 오늘 입사일 근무달수 
select ename, sysdate 오늘, to_char(hiredate, 'YYYY/MM/DD') 입사일,
trunc (months_between(sysdate, hiredate)) 근무달수
from emp;

--개월수를 더하는 add_months함수
-- add_months함수는 특정 개월수를 더한 날짜를 구하는 함수이다
-- 형식: add_months(datem number);
-- 문제: 입사날짜에 6개월을 추가해보자 
select ename,  to_char(hiredate, 'YYYY/MM/DD') 입사일, 
            to_char(add_months(hiredate, 6), 'YYYY/MM/DD') 입사6개월후
from emp;
 
 --해당 요일의 가장 가까운 날짜를 반환하는 next_day함수
 -- 해당 날짜를 기준으로 최초로 도래하는 요일에 해당하는 날짜를 반환하는 함수이다
 -- 형식 : next_day(date, 요일)
 -- 0 -> 일요일 1-> 월요일 2 -> 화요일 ... 6 -> 토요일
 -- 문제: 오늘을 기준으로 최초로 도래하는 수요일은 언제인지 알아보자, 출력 오늘, 수요일
select to_char(sysdate, 'YYYY/MM/DD') 오늘, 
            to_char(next_day(sysdate, 'wed'), 'YYYY/MM/DD') 수요일
from dual;
 
 --해당 달의 마지막 날짜를 반환하는 last day 함수
 --해당 날짜가 속한 달의 마지막 날짜를 반환하는 함수이다.
 -- 마지막달이 정해져있지않은 달 2월의 경우가 해당된다.
 -- 문제: 입사한 달의 마지막 날짜를 구하기
 -- 출력: 입사일 마지막 날
 select ename, to_char(hiredate, 'YYYY/MM/DD') 입사일,
            to_char(last_day(hiredate),'YYYY/MM/DD') "마지막 날짜"
            from emp;
 
 -- null을 다른 값으로 변환하는 함수
 -- 형식: nvl(expr1, expr2) : null값을 실제 값으로 변환하기 위해서 사용하며 데이터의 유형은 숫자
 -- 문자, 날짜 입니다.
 -- exp1에는 null을 포함하는 컬럼 또는 표현식을 expr2에는 
 -- null을 대처하는 값을 기술해야 하며, expre1과 expres2 는 반드시 데이터 타입이 일치해야함
 
 -- 구치 데이터를 사용하는 nvl 함수
 -- nvl(comm, 0 ); comm 컬럼에 null이 저장되어있으면, 이 값을 0으로 변환한다.
 
 -- 날짜 데이터를 사용한 nvl 함수
 -- nvl(hiredate, to_date('2019/04/23', 'yyyy/mm/dd')
 -- hiredate 칼럽에 null이 저장되어 있다면, 이 컬럼값을 2019년 4월 23일로 변환한다.
 -- 문자데이터를 사용한 nvl 함수: nvl (job, '매니저')
 --nvl2함수 : express1을 검사하여 그 결과가 null이 아니면
 -- express2를 반환하고 null이면 express3를 반환합니다. 
 --형식: nvl2(expr1, expr2, expr3)
 --                     검사              널
 select ename, sal, comm, nvl2(comm, sal*12+comm, sal*12)
 from emp
 order by deptno;
 -- 조회한 데이터들을 목적에 맞게 특정 칼럼을 기준으로 '정렬'하는데 사용
-- 정렬순서대로 출력  

--nulllif 함수는 두 표현식을 비교하여 동일한 경우에는 null을 반환하고
-- 동일하지않으면 첫번째 표현식을 반환한다.
-- nullif(exp1, exp2)
--                  = null
--                  != expr1
-- nullif로  null값 처리하기
select nullif('A', 'A'), nullif('A', 'B') from dual;
-- result : (null)                  A
--NULLIF('A','A')는 두 표현값이 동일하기에 NULL을 반환하고 NULLIF('A','B')는 동일하지 않으므로
--'A'를 반환합니다


--coalesce 함수는 인수중에서 null이 아닌 첫번째 인수를 반환하는 함수이다.
-- 형식: coalesce(exp1, exp2, ... expm)

--substr(대상, 시작위치, 추출할 개수)
-- 문제 : 첫번쨰 미션 해결하기
-- 하나. substr함수를 사용하여 9월에 입사한 사월을 출력하기 emp 테이블에서
select * from emp where substr(hiredate, 4,2)  = '09';

-- 둘: subst함수를 이용하여 2003년도에 입사한 사원을 겁색하기 
select * from emp where substr(hiredate, 1, 2) = '03';

--셋:subst함수를 이용하여 '기' 로 끝나는 사원을 겁색하기
select * from emp where substr(ename, -1, 1) = '기';
--<힌트> 시작 위치를 -1로 주고 추출할 문자의 개수를 1로 주면 됩니다.
-- select * from emp where ename like '%기';

--넷: 입사일자 년도(두자리), 월(두잘) 일(두자리)를 추출하여 조회하세요
select hiredate, to_char(hiredate, 'YY/MM/DD') from emp;


-- 다섯: 이름의 두번째 글자가 "동" 이 있는 사원을 검색하기 
 select * from emp where substr(ename ,-2,1) = '동';
 select * from emp where instr(ename, '동', 2, 1 ) = 2;
 -- select * from emp where ename like '%동_';
 
 
 --선택을 위한 decode함수
 -- decode 함수는 프로그램 언어에서 가장 많이 사용되는 switch case 문과 같은 기능을 갖습니다.
 -- 즉, 여러 가지 경우에 대해서 선택할수있도록 합니다.
 -- 기본 형식
 --decode(표현식, 조건1, 결과1
 --                       조건2,    결과 2
--                        조건3,    결과 3
--                          기본결과 n     )

select ename, deptno, 
decode(deptno, 10, '경리부',
            20, '인사과' ,  30, '영업부',   40, '전산부') as dname
            from emp;
-- 디코드 부분이 전부 as 인 dname 으로 바뀌게된다. 



--조건에 따라 서로 다른 처리가 가능한 case
-- case 함수는 다양한 비교 연산자를 이용하여 조건을 제시할수있으므로 범위 지정을
-- 할수있습니다. case함수는 프로그램 언어의 if else와 유사한 구조를 갖습니다.
select ename, deptno,
case when deptno = 10 then '경리부'
         when deptno = 20 then '인사과'
         when deptno = 30 then '영업부'
         when deptno = 40 then '전산부'
 end as dname
 from emp;
                                        
                    
 --두번째 미션문제
 --하나. 직급에 따라 직급이 '부장ㅇ'인 사원은 5% 과장인 사람은 10%
 --' 대리'인 사원은 15% '사원'인 사람은 20% 금여를 인상해주기.
 select ename, job, sal,
 case 
        when job = '부장' then sal *1.05
        when job = '과장' then sal *1.10
        when job = '대리' then sal *1.15
        when job = '사원' then sal *1.20
end as Upsal
    from emp;
 
 --세번째 미션문제
 --하나. 입사일을 연도는 2자리(YY), 월은 숫자 (MON)으로 표시하고 
 -- 요일은 약어(DY) 로 지정하여 출력하기
 select hiredate,
            to_char(hiredate, 'yy/mon/dd dy') from emp;
--MON숫자 함수
-- 입력 받은 수를 나눈 나머지 값을 반환한다. 


-- 문제> emp테이블로 부터 홀수부서의 입사날짜를 조회해보세요 -> empno
select * from emp where mod(empno, 2) = 1 ;

-- as 근무일수 구하기
select round(sysdate-hiredate) 근무일수 from emp;

select hiredate, round(hiredate, 'MONTH') from emp; 

select empno, ename, nvl(to_char(mgr, '9999'), 'C E O') as "직속 상관"
from emp where mgr is null;


-- 날짜 형 데이터에 숫자를 더하면  (날짜 + 숫자)
-- 그 날짜로부터 그 기간만큼 지난 날짜를 계산합니다.
-- 날짜 형 데이터에 숫자를 빼면 (날짜 - 숫자)
-- 그 날짜로부터 그 기간만큼 이전 날짜를 구합니다.

select sysdate -1 어제 , sysdate 오늘, sysdate +1 내일
from dual;
 
 --그룹함수
 --테이블의 전체 데이터에서 통계적인 결과를 구하기 위해서 행 집합에 적용하여 하나의 결과를 생산
 --하나이상의 행을 묶어 그룹으로 만들어 연산하여 결과를 나타내는 함수
 --sum : 그룹의 누적합계 반환
 --avg: 그훕의 평균 반환
 --count: 그룹의 총 개수 반환
-- max/ min:최대, 최소 값 반환
 --stddex: 표준편차 반환
 --variacne :분산을 반환
 select count(*) as "전체 사원의 수" ,
 count (comm) as "커미션 받는 사원의 수" 
 from emp;
 
 --count(*)테이블의 전체 로우(행) 개수를 구합니다
 -- count(comm)은 comm컬럼에서 null이 아닌 로우 개수를 구합니다
 
 
 --특정 칼럼을 기준으로 그룹함수를 사용할 경우 어떤 컬럼값을 기준으로 그룹함수를 줄지를 결정할때
 -- 사용합니다. Group by절이라고합니다. 데이터 그룹 group by절
 -- 형식: 
 --select 컬럼명, 그룹함수
 -- from 테이블명
 -- where 조건(연산자)
 --group by 컬럼명 
 
 --사원테이블을 부서 번호로 그룹만들기
 select deptno from emp
 group by deptno;
 
 --문제: 소속부서별 최대급여와 최소급여구하기
 select deptno, max(sal) 최대급여, min(sal) 최소급여
 from emp group by deptno;
 
 select deptno, sal
 from emp
 order by deptno, sal desc;
 
 select deptno,MAX(sal) 최대급여, min(sal) 최소급여
 from emp
 group by deptno
 order by deptno;
 --위에 두개를 합친 그룹과 정렬입니다.
 
 --최고급여 출력하기
 select max(avg(sal))from emp group by deptno;
 
 -- select절에 조건을 사용하여 결과를 제한할 땐 where절을 사용하지만
 -- 그룹의 결과를 제한할때는 having 절을 사용합니다.
 --문제: 부서별 급여 평균이 500 이상인 부서의 번호와 급여평균 구하기
 select deptno, avg(sal) from emp group by deptno having avg(sal) >= 500;
 --에러 이유를 적고 올바르게 구해보기. 
 select deptno, avg(sal), ename
 from emp
 group by deptno, ename;
 -- not a group by expression 
 --목록이 groupby 목록과 일치하지않아 에러발생 
 
 
