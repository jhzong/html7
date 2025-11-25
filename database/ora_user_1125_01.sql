--table 생성 create
create table student (
sno number(4) primary key,--중복,null 불가
name varchar2(100),--한글3byte
kor number(3),--number(4,1)>정수:4자리,소수:1자리
eng number(3),
math number(3),
total number(3),
avg number(5,2)
);
--table 생성 + 복사(데이터까지)
create table student2 as select * from student;
--table 생성 + table의 구조만 복사
create table student3 as select * from student where 1=2;

--col의 특정 요소만 가져오기(table의 형태가 있어야함)
insert into student3(sno,name,kor,eng,math,sdate) select sno,name,kor,eng,math,sdate from student;
--col의 요소 가져오기(table의 형태가 있어야함)
insert into student2 select * from student;

--table 변경(alter)
--col 추가 alter add
alter table student add sdate date;
--col 삭제 alter drop
alter table student drop column sdate;
--col 수정
alter table student modify name varchar2(1000);
alter table student modify name varchar2(90);
alter table student modify name varchar2(5);--입력된 데이터 크기 아래로 변경불가

--col명
desc student;
desc employees;

--데이터 추가
--select,insert,update,delete
--commit,rollback
--insert into 테이블명 (모든 col의 value값)
--insert into table명 values (모든값)
insert into student (sno,name,kor,eng,math,total,avg)
values(1,'홍길동',100,100,100,300,100);
insert into student values(
2,'유관순',90,90,90,270,90);
insert into student values(
3,'이순신',80,80,80,240,80);

--select col명 from table명
select sno,name,kor,eng,math,total,avg from student;
select sno,name,total from student;
select * from student;

--update table명 set수정할 col = 값 where col=값(조건절)
update student set name = '홍길영' where sno=1;
update student set name = '홍길동' where sno=1;

select employee_id,emp_name from employees;
select * from employees where employee_id>200;

--delete table명 where col=값
delete student where sno=3;
delete student;


--commit 또는 rollback
commit;
rollback;



--현재 tab에 존재하는 table 확인
select * from tab;

select * from student;

desc student;

--------------------------------------------
--예제)
update student set sdate = '2025.01.01';
update student set sdate = sysdate; --sysdate:현재날짜,시간을 입력/mysql-now()

select * from student;

commit;
rollback;

select * from employees;
select manager_id from employees;
select distinct manager_id from employees;--distinct:중복제거
select distinct manager_id from employees order by manager_id;--order by:~기준 정렬

--사원번호, 사원이름, 부서번호
desc employees;
select EMPLOYEE_ID,EMP_NAME,DEPARTMENT_ID from employees;
--//예제)
-----------------------------------------------------------
--예제)
--홍길동>홍길순
update student set name='홍길순' where sno=1;
--날짜 2025-10-10 변경
update student set sdate='2025.10.10';--where를 안붙이면 모든 열에 적용
--3번 삭제
delete student where sno=3;
--4,'김구',70,70,70,210,70
insert into student values (
4,'김구',70,70,70,210,70,'2025.10.10'
);
update student set sdate=sysdate where sno=4;

select * from student;
commit;
rollback;
--//예제)
----------------------------------------------
--type: number type
--연산자:산술연산자 + - * /
select sdate,sdate+100 from student;

select * from student;
update student set kor = 90 where sno=1;
update student set total=kor+eng+math,avg=(kor+eng+math)/3 where sno=1;

select * from employees;
--월급(달러)>>환율계산1474원
--as:별칭{col명 as(생략 가능) alias(별칭)}
select emp_name, salary, salary*1474 as k_salary, salary*1474*12 year_k_salary from employees order by salary;
--별칭=변수

----------------------------------------------------------
--table 생성 + 복사(데이터까지)
create table student2 as select * from student;
--table 생성 + table의 구조만 복사
create table student3 as select * from student where 1=2;


--col의 특정 요소만 가져오기(table의 형태가 있어야함)
insert into student3(sno,name,kor,eng,math,sdate) select sno,name,kor,eng,math,sdate from student;
--col의 요소 가져오기(table의 형태가 있어야함)
insert into student2 select * from student;

--예제)
delete student2;

alter table student3 drop column total;
alter table student3 drop column avg;

select * from student;
select * from student2;
select * from student3;

commit;
--//예제)
---------------------------------------
desc student3;
alter table student3 add total number(3);
alter table student3 add avg number(5,2);

update student3 set total=kor+eng+math,avg=(kor+eng+math)/3 where sno=1;
update student3 set total=kor+eng+math,avg=(kor+eng+math)/3 where sno=2;
update student3 set total=kor+eng+math,avg=(kor+eng+math)/3 where sno=4;

update student3 set total=kor+eng+math,avg=(kor+eng+math)/3;--전체적용

--------------------------------------------------------------
select * from employees;

--null값과 사칙연산을 하면 null이 됨(null=무한대)
--nvl(col명,0):null값을 0으로 대체
select emp_name,salary,nvl(commission_pct,0),salary+(salary*nvl(commission_pct,0)) real_salary from employees;

--실제 연봉을 출력
select emp_name,salary+(salary*nvl(commission_pct,0)) real_salary, (salary+(salary*nvl(commission_pct,0)))*12 yearly_real_salary from employees;

select * from employees;
--부서번호
select distinct department_id from employees;
select distinct job_id from employees;
select * from jobs;

------------------회원정보입력-------------------------------------------
--쇼핑몰html 회원정보 입력
--mem
--회원번호, 이름, 아이디, 비밀번호, 이메일, 이메일 수신여부, 우편번호,
--주소1, 주소2, 휴대폰, sms수신여부, 유선전화, 생년월일, 기업회원, 가입날짜
create table zmember (
 id varchar2(100),
 pw varchar2(100),
 name varchar2(100),
 email varchar2(50),
 email_check number(1),
 zonecode char(5),
 address varchar2(100),
 phone char(13),
 phone_check number(1),
 tel char(13),
 birth date,
 birth_check number(1),
 business number(1)
);

select * from zmember;
--alter table mem add id varchar2(100);
--alter table mem add id varchar2(100);
insert into zmember values(
'aaa','1111','홍길동','aaa@gmail.com',1,'00000','서울 감남구','010-1111-1111',
0,'02-1111-1111','2000-01-01',1,0
);

commit;
delete zmember;
drop table zmember;

----------------//회원정보입력-------------------------------------------
----------------seoul_stu,seoul_grade JOIN----------------------------------------------------------
--seoul_stu
--학생정보 테이블
--학생고유번호, 이름, 학년-반-번호(1), 학년-반-번호(2), 학년-반-번호(3),전화, 주소, 입학일, 학과, 선택과목

create table seoul_stu (
stuno char(5),--s0001
name varchar2(100),
birth date,
phone char(13),
address varchar2(100),
enroll_date date,
write_date date
);

insert into seoul_stu values (
's0001','홍길동','2000-01-01','010-1111-1111','서울',sysdate,sysdate
);

drop table seoul_stu;
select * from seoul_stu;
commit;

create table seoul_grade(
stuno char(5),
grade number(1),--학년
grade_no number(2),--반
class_no number(3)--번호
);

insert into seoul_grade values(
's0001',1,1,1
);
insert into seoul_grade values(
's0001',2,2,2
);
insert into seoul_grade values(
's0001',3,3,3
);

commit;
select * from seoul_grade;
select * from seoul_stu;

select seoul_stu.stuno,name,birth,phone,address,enroll_date,write_date,
grade,grade_no,class_no
from seoul_stu,seoul_grade  --join:중복제거
where seoul_stu.stuno=seoul_grade.stuno;


drop table seoul_stu;
-----------//seoul_stu,seoul_grade  JOIN-------------------------------------------------
update seoul_stu set grade=3, grade_no=3, class_no=3 where stuno='s0001';




-------------------- uni_stu ----------------------------
create table uni_stu(
stuno char(5),
name varchar2(100),
major_code varchar2(100),
major_name varchar2(100),
major_date date,
college varchar2(100)
);

insert into uni_stu values(
's0001','홍길동','com','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0002','유관순','com','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0003','이순신','com','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0004','김구','com','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0005','강감찬','com','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0006','김유신','math','수학과','2000-01-01','인문대학'
);
select * from uni_stu;

update uni_stu set major_date='2000-02-02' where stuno='s0006';

create table major_collect (
major_code varchar2(100),
major_name varchar2(100),
major_date date,
college varchar2(100)
);

insert into major_collect values(
'com','컴퓨터공학과','2000-01-01','공과대학'
);
insert into major_collect values(
'math','수학과','2000-02-02','인문대학'
);

commit;
select * from major_collect;
select * from uni_stu;

select stuno, name, uni_stu.major_code, major_name, major_date, college
from uni_stu,major_collect
where uni_stu.major_code=major_collect.major_code;

alter table uni_stu drop column major_name;
alter table uni_stu drop column major_date;
alter table uni_stu drop column college;

--------------------------------------------------------------------------------
-------------------------조건절-------------------------------------------
--where절:조건절 =,!=(다르다),<>(다르다),>=,<=,>,<,and,or
--where절>>column,연산자,비교값
-- 예제)--
select * from employees where department_id=30 or department_id=50;
select * from employees where department_id in (30, 50);--{x or y == in(x,y)}
select * from employees where department_id=30 and manager_id=100;
select * from employees where department_id<30;
select * from employees where department_id>30;
select * from employees where department_id<>30;

select * from employees where salary>=5000;
select * from employees where salary=6000;
select * from employees where salary in (5000,6000,7000);
select * from employees where salary not in (5000,6000,7000);

select emp_name,salary,salary*12 from employees
where salary*12>=200000;

desc employees;
--
select EMPLOYEE_ID,EMP_NAME,SALARY from employees
where salary<=4000 order by salary;
--예제)날짜 등가비교
select hire_date from employees;
select hire_date from employees
where hire_date>='2005-01-01';

select EMP_NAME,hire_date,hire_date+100 from employees;
select email,hire_date from employees
where hire_date>='2007-06-01';

--예제)등가비교 between A and B
select EMP_NAME,salary from employees
where salary>7000 and salary<7500;
select EMP_NAME,salary from employees
where salary between 7000 and 7500;--(salary>=7000 and salary<=7500)

select EMP_NAME,salary from employees
where salary<7000 or salary>7500;
select EMP_NAME,salary from employees
where salary not between 7000 and 7500;

select emp_name,hire_date from employees;
--예제)
select employee_id,emp_name,department_id,hire_date from employees
where hire_date>='2005.01.01' and hire_date<='2007.12.31' order by hire_date;
select employee_id,emp_name,department_id,hire_date from employees
where hire_date between '2005.01.01' and '2007.12.31' order by hire_date;

-------------------------//조건절-------------------------------------------

--상품관리 table?--
--상품번호id, 상품명, 카테고리, 가격, 재고수량, 중고유/무, 등록일reg, 수정일mod
create TABLE inventory(
prod_id number(10),
prod_name varchar2(100),
category varchar2(100),
price number(10),
stock_qty number(10),
use_yn char(1),
reg_date date,
mod_date date
);
select * from inventory;
alter table inventory modify use_yn char(2);

insert into inventory values(
1,'aaa','A',10000,50,'N',sysdate,sysdate);
delete inventory;

commit;