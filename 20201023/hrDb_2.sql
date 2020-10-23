/*Concat(char1, char2)*/
select concat('Hello','bye'), concat('������ħ','bad') from dual;
-- dual �������̺�, concat�� ���ڿ��� ��ġ�±�� 

-- concat�� ���ڿ��� ��ġ�� ������ goodbad���� ��Ÿ��
select concat('good','bad') ������ħ, 'good' || 'bad' operators
from dual;

/*initcap(char)*/
select initcap('good morning') from dual;
-- ù���ڰ� �빮�ڷ�
select initcap('good/bad morining') from dual;
--/�����ڶ� �ڿ�b �� B �빮�ڷιٲ�鼭 ���κ���

/*lower(char)�ҹ���, upper(char)�빮��*/
select lower('GOOD'), upper('good') from dual;
--lower�� �ҹ��ڷ� ����� upper�� �빮�ڷ� ����� 

/*LPAD(), RPAD()*/
select lpad('good', 6) "LPAD1", --6�ڸ��δø�  _ _g00d
lpad('good', 7, '#') "LPAD2", --7�ڸ��ε� ###good
lpad('good', 8, 'L') "LPAD3" --8�ڸ��ε� L�� ���ʺ���ù���ں��� ä��� LLLLgood
from dual;

select rpad('good', 6) "RPAD1",--�����ʺ���ä���  "good"
rpad('good', 7, '#') "RPAD2", -- "good###"
rpad('������', 8, 'L') "RPAD3" --�ѱ��� 2����Ʈ������   "������LL"
from dual;

/* LTRIM(), RTRIM()*/
select ltrim('goodbye','g'), --oodbye
ltrim('goodbye','o') ,       -- goodbye
ltrim('goodbye','go') from dual;    --dbye
--���ʺ��� ����� o�� ��������� �߰��� �ձ⶧���� 
--�������� go�ν��������� o�� ���� ���m��
-----------------------------------------
select rtrim('goodbye','e') from dual;--�����ʿ��� �����  "goodby"

/*substr(), substrb()*/
select substr('good morning john', 8, 4) from dual; --rnin
select substr('good morning john', 8) from dual;  --rning john
--r���� �������� ����Ѵ�

select substr('good morining john', -4) from dual;   --john
--�����ʺ��� 4����
select substr('good morining john', -4, 0) from dual;    --null
--0�ΰ��� null

select substrb('good morning john', 8, 4) from dual;     -- rnin
--b �� byte�ǹ� 4����Ʈ �ѱ��� �α���

/*replace()*/
select replace('good morning tom', 'morning', 'evenning') from dual;
-- good evenning tom

/*translate()*/
select replace('You are not alone', 'You', 'We'),--You�� we�� �ٲ�
Translate('You are not alone', 'You', 'We')
-- You �� Y�� W�� o�� e�� �ٲ�� u�� ������ 1:1����
from dual;

--replace : we are not alone
--translate : we are net alene

/*trim()*/--length ���ڿ����̰����ϱ�
select length(trim( leading from ' good ')) ,
--leading from �տ����ʰ�������   5
length(trim(trailing from ' good ')),
--trailing from �ڿ������ʰ��������� ����    5
length(trim(both from ' good ')),--���ʴ� ��������     4
trim(both from '  good   ')     --good
from dual;

/*ascii()*/
select ascii('A') from dual;
-- = 65

/*instr()*/--���ڿ��� ��ġ�� ã�������Լ��̴�
select instr('good morning john', 'or',1) from dual;
--or��ġ�� 7���ͳ��´� 
select instr('good morning john', 'n',1,2) from dual;
--1��°��ġ���� 2��° n�� ��ġ�� ã�´� 11
select instr('good morning john', 'n',1,3) from dual;
--1��°��ġ���� 3��°��ġ n�� ã�´� 17



