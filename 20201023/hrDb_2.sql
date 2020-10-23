/*Concat(char1, char2)*/
select concat('Hello','bye'), concat('좋은아침','bad') from dual;
-- dual 더미테이블, concat은 문자열을 합치는기능 

-- concat은 문자열을 합치기 때문에 goodbad으로 나타남
select concat('good','bad') 좋은아침, 'good' || 'bad' operators
from dual;

/*initcap(char)*/
select initcap('good morning') from dual;
-- 첫문자가 대문자로
select initcap('good/bad morining') from dual;
--/구분자라서 뒤에b 가 B 대문자로바뀌면서 따로본다

/*lower(char)소문자, upper(char)대문자*/
select lower('GOOD'), upper('good') from dual;
--lower은 소문자로 만들고 upper은 대문자로 만든다 

/*LPAD(), RPAD()*/
select lpad('good', 6) "LPAD1", --6자리로늘림  _ _g00d
lpad('good', 7, '#') "LPAD2", --7자리인데 ###good
lpad('good', 8, 'L') "LPAD3" --8자리인데 L로 왼쪽부터첫글자부터 채우기 LLLLgood
from dual;

select rpad('good', 6) "RPAD1",--오른쪽부터채우기  "good"
rpad('good', 7, '#') "RPAD2", -- "good###"
rpad('좋은아', 8, 'L') "RPAD3" --한글은 2바이트차지함   "좋은아LL"
from dual;

/* LTRIM(), RTRIM()*/
select ltrim('goodbye','g'), --oodbye
ltrim('goodbye','o') ,       -- goodbye
ltrim('goodbye','go') from dual;    --dbye
--왼쪽부터 지우기 o는 지울수없다 중간에 잇기때문에 
--마직막은 go로시작하지만 o도 같이 지웟다
-----------------------------------------
select rtrim('goodbye','e') from dual;--오른쪽에서 지우기  "goodby"

/*substr(), substrb()*/
select substr('good morning john', 8, 4) from dual; --rnin
select substr('good morning john', 8) from dual;  --rning john
--r부터 나머지를 출력한다

select substr('good morining john', -4) from dual;   --john
--오늘쪽부터 4글자
select substr('good morining john', -4, 0) from dual;    --null
--0인경우는 null

select substrb('good morning john', 8, 4) from dual;     -- rnin
--b 가 byte의미 4바이트 한글은 두글자

/*replace()*/
select replace('good morning tom', 'morning', 'evenning') from dual;
-- good evenning tom

/*translate()*/
select replace('You are not alone', 'You', 'We'),--You가 we로 바꿈
Translate('You are not alone', 'You', 'We')
-- You 중 Y가 W로 o가 e로 바뀌고 u는 없어짐 1:1대응
from dual;

--replace : we are not alone
--translate : we are net alene

/*trim()*/--length 문자열길이값구하기
select length(trim( leading from ' good ')) ,
--leading from 앞에왼쪽공백제거   5
length(trim(trailing from ' good ')),
--trailing from 뒤에오른쪽공백제거후 길이    5
length(trim(both from ' good ')),--양쪽다 공백제거     4
trim(both from '  good   ')     --good
from dual;

/*ascii()*/
select ascii('A') from dual;
-- = 65

/*instr()*/--문자열의 위치를 찾기위한함수이다
select instr('good morning john', 'or',1) from dual;
--or위치가 7부터나온다 
select instr('good morning john', 'n',1,2) from dual;
--1번째위치부터 2번째 n의 위치를 찾는다 11
select instr('good morning john', 'n',1,3) from dual;
--1번째위치부터 3번째위치 n을 찾는다 17



