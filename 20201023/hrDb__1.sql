select * from employees;

select sum(salary) from employees; 
-- ���� ���̺�κ��� �޿��� ���� ��ȸ

select count(*) from employees; 
-- ���� ���̺� ����� ���� ����
select count(all Employee_id) from employees; 
-- ���� ���̺� ����� �������̵��� ����
select count(all Employee_id), count(distinct Employee_id) 
from employees;
-- distinct�� ����Ͽ� ���� ���̺� ����� �������̵� �ߺ������ϰ� �� ������ ��ȸ 
select count(all First_name) from employees;
select count(all First_name), count(Distinct first_name) 
from employees;

select avg(salary) from Employees; 
-- ���� ���̺�κ��� �޿��� ����� ��ȸ
select avg(salary) from Employees where department_id = 80; 
-- ���� ���̺�κ��� �μ� ��ȣ�� 80�� ������ �޿� ����� ��ȸ
select avg(salary) from Employees where department_id = 50;

select max(salary) from Employees;
-- ���� ���̺�κ��� �޿��� �ִ밪�� ��ȸ
select max(hire_date) from Employees;
-- ���� ���̺�κ��� �Ի� ��¥�� ���� �ֱ��� ������ ��ȸ

select min(salary) from Employees;
select min(hire_date) from Employees;

select abs(-23) from dual; 
-- ���� �Լ� 23�� ����Ͽ� dual ���̺��� ���� ��ȸ
select abs(23) from dual;

-- sign(x): x���� 0���� ������ -1, 0�̸� 0, 0���� ũ�� 1�� ��ȯ�ϴ� �Լ�
select sign(23) from dual;
-- 23�� 0���� ũ�Ƿ� 1�� dual ���̺��� ��ȸ
select sign(23), sign(-23), sign(0) from dual; -- 1, -1, 0�� ��ȸ

-- round("��", "�ڸ���"): ���� ������ �ڸ������� �ݿø��ϰ� �������� ������ �Լ�
select round(0.123), round(0.543) from dual; -- �������� ������� �Ҽ��� ù°�ڸ����� �ݿø�
select round(0.123), round(2.543) from dual;
select round(0.12345678, 6), round(2.3423455, 4) from dual;

-- trunc("��", "�ɼ�"): �Ҽ����̳� ��¥ ������ �ڸ��µ� ���Ǵ� �Լ�
select trunc(1234.1234567) zero from dual; -- zero �տ� as�� �����Ǿ� ����
select trunc(1234.1234567,0) zero from dual;
select trunc(1234.1234567,2)  from dual;
select trunc(1234.1234, -1) from dual; -- �����ڸ������ʹ� -�� ǥ��, �ڸ����� 0���� ǥ����

-- ceil: �ø� �Լ�
select ceil(32.8) ceil from dual;
select ceil(32.3) ceil from dual;

-- floor: ���� �Լ�
select floor(32.8) floor from dual;
select floor(32.3) floor from dual;

-- power(��, ��������): ���� �Լ�
select power(4,2) power1 from dual;

-- mod: ������ �Լ�, �ڹٿ��� %�� ���� ����
select mod(7, 4) mod1 from dual;

-- sqrt: ������ �Լ�, ���� �����δ� �����ڸ� ������ �Ǽ��� �� �� ����
select sqrt(2), sqrt(3) from dual;