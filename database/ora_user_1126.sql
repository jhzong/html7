select * from employees;

--select,update,insert,delete
select * from student3;

insert into student3 (sno,name,kor,eng,math,sdate,total,avg) values(
5,'강감찬',75,70,79,sysdate,(75+70+79),(75+70+79)/3
);

commit;
--invisible/visible
--col순서 변경
alter table student3 modify sdate invisible;--숨김처리
alter table student3 modify sdate visible;--숨김>공개후 col의 맨뒤로 이동

--예제)sdate를 name 뒤로
alter table student3 modify kor invisible;
alter table student3 modify eng invisible;
alter table student3 modify math invisible;
alter table student3 modify total invisible;
alter table student3 modify avg invisible;

alter table student3 modify kor visible;
alter table student3 modify eng visible;
alter table student3 modify math visible;
alter table student3 modify total visible;
alter table student3 modify avg visible;

drop table student3;

-------------- 범위검색 ------------------------------------
--예제)6000이상~7000이하 사원
desc employees;
--비교연산(<,>,<=,>=)
select EMPLOYEE_ID,EMP_NAME,SALARY from employees
where salary>=6000 and salary<=7000;
--between A and B
select EMPLOYEE_ID,EMP_NAME,SALARY from employees
where salary between 6000 and 7000;
--in 6000 7000 8000
select EMPLOYEE_ID,EMP_NAME,SALARY from employees
where salary in (6000,7000,8000);-->>where salary=6000 or salary=7000 or salary=8000
-------------- //범위검색 ------------------------------------

-------------- like ------------------------------------------
--%,_
--%:순서와 상관없이 어떤 문자가 들어와도 검색
--_1개의 문자순서
--like '%a%':위치무관, 'a%':맨앞, '%a':맨뒤, '_a%':2째
select emp_name from employees
where emp_name='Donald OConnell';

select salary from employees
where salary=6000;

--like를 이용한 검색(대소문자 구분함)
select emp_name from employees
where emp_name like 'D%';--D로 시작하는 직원이름

select emp_name from employees
where emp_name like '%d%';--d가 들어가는 직원이름

select emp_name from employees
where emp_name like '%d';--d로 끝나는 직원이름

select * from customers;
--cust_city 중 ge가 들어가는 도시 찾기
select cust_city from customers
where cust_city like '%ge%';

--대소문자 구분없이 검색(upper, lower)
select upper(cust_city) from customers;

select cust_city from customers
where lower(cust_city) like '%ge%';--cust_city를 소문자로 바꿔서 ge검색



select * from member;
--예제)홍이 들어가는 사람 찾기
select name from member
where name like '%홍%';
--예제)이메일에 man이 들어가는 사람 찾기
select name,email from member
where email like '%man%';

select name,email from member
where email like '_n%';--2째 자리에 n이 드러감
select name,email from member
where email like '__n%';--3째 자리에 n이 드러감


select job_id from employees;

select job_id from employees
where job_id='SH_CLERK';--출력때는 '_'가 안보임

--특수문자 '_'를 검색
select job_id from employees
where job_id like '%#_M%' escape '#';

-------------------------------------------------------------------
----------- null -----------------------------
select * from employees;

select manager_id from employees;

--null검색:is null, is not null
select manager_id from employees
where manager_id is null;

--예제)
--null을 대체 nvl(A,0)
--salary + (salary*commission_pct):실수령
--1474:원화
select salary, salary+(salary*nvl(commission_pct,0)) real_salary,
(salary+(salary*nvl(commission_pct,0)))*1473 k_real_salary from employees;

--예제)null을 ceo로 대체
--to_char:number타입을 varchar2타입으로 변경
select manager_id,nvl(manager_id,0),
nvl(to_char(manager_id),'ceo') from employees;

--nvl(a,#): a의 값중 null이 있으면 null을 #로 대체
--nvl:null value

----------- //null -----------------------------
-------------- 정렬 ------------------------------------
--order by A asc:순차 /desc:역순
--오름차순
select emp_name from employees
order by emp_name asc;--asc(디폴트 생략가능)
--내림차순
select emp_name from employees
order by emp_name desc;

--예제) a가 들어있는 사원을 역순으로
select emp_name from employees
where emp_name like '%a%'
order by emp_name desc;--order by는 마지막에 위치

--예제)
select emp_name, hire_date from employees
order by hire_date asc;

--예제)
select * from member
order by name;
select * from member
order by name desc;

--예제)사원 월급 역순정렬, manager_id가 null이면 ceo로 대체
-- 월급이 8000이상에 이름에 'p'가 들어가는 사람
select emp_name, nvl(to_char(manager_id),'ceo'), salary from employees
where salary>=8000 and lower(emp_name) like '%p%'
order by salary desc;

--예제)**2중 정렬
select * from employees;
--department_id로 순차정렬, salary로 역순정렬
select department_id,salary from employees
order by department_id asc, salary desc;
--1순위 실행 정렬>> 동일 항목에서 2순위 정렬
------------ //정렬 ------------------------------------

--예제)검색 >> 게시판(제목+글쓴이)
select * from employees;
--이름에 z email에 z
select emp_name,email from employees
where lower(emp_name) like '%z%' or lower(email) like '%z%';
--like '%z%' 

--예제)같은 부서내에서 입사일이 빠른 사원
select emp_name,department_id,hire_date from employees
order by department_id asc, hire_date asc;

--한글 alias(별칭)은 ""안에 표시
select salary "월급" from employees;
------------------------------------------------

----------------- 숫자 함수 -----------------------------

select 10 from dual;--가상테이블(dual)
--abs:절대값
select 10,abs(-10) from dual;
--floor:소수점 아래 버림,
select floor(10.598) from dual;
--round:반올림
--round(a,#):a를 소수#째 자리에서 반올림
select round(10.598) from dual;
--ceil:소수점 아래 모조건 올림
select ceil(10.2) from dual;
--trunc:버림
--trunc(a,#):a의 소수#째 자리 아래로 버림
select trunc(34.5678,2) from dual;
--mod:나머지
select mod(27,2), mod(27,5) from dual;

--예제)사원번호 홀수
select employee_id from employees
where mod(employee_id,2)!=0;
----------------- //숫자 함수 -----------------------------

----------------- 시퀀스 함수(하단댓글 번호) -----------------
--시퀀스함수:순차적으로 순번을 증가시킬때 사용하는 함수(파이썬 연동)
create sequence member_seq --생성
increment by 1 --증감율
start with 1 --시작값
minvalue 1 --최소값
maxvalue 9999 --최대값
nocycle --반복X(cycle,nocycle)
--cache #--메모리에 시퀀스 미리 할당(#개 미리 생성)
;
--nextval:번호생성-증가
select member_seq.nextval from dual;--
--currval:번호확인
select member_seq.currval from dual;--

--예제)
create SEQUENCE employee_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
;
select employee_seq.nextval from dual;

alter sequence employee_seq increment by 2;--수정

drop sequence employee_seq;--삭제

----------------- //시퀸스 함수 -----------------------------
------------------------------------------------------------


update stuscore set avg = total/3;

alter table stuscore modify avg number(5,2);

commit;
rollback;
select * from stuscore
order by kor desc, eng asc
;

select * from stuscore;
insert into stuscore values(
stuscore_seq.nextval,'홍길동',100,100,99,(100+100+99),(100+100+99)/3,sysdate
);


