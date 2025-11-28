-- 데이터 : 자료집합(원석), 정보 : 유용한 자료(보석)
-- 무결성 제약조건 : data입력시 잘못된 data의 입력을 제약
-- primary key, foreign key, not null, unique, check

-- table생성시 primary key 등록방법
create table mem3(
id varchar2(100) primary key,
pw varchar2(100),
);

-- primary key 등록,수정
-- constraint : 별칭
alter table mem2 add constraint pk_mem2_id primary key(id);


-- table생성시 foreign key 등록
-- 다른table의 primary key로 등록 되어있어야함.
create table board4(
bno number(4) primary key,
btitle varchar2(100) not null,
bcontent clob,
id varchar2(100),
constraint fk_board4_mem2_id foreign key(id) references mem2(id)
);

-- foreign key 수정
create table board3 as select * from board;
alter table board3
add constraint fk_board3_mem2_id foreign key(id) references mem2(id);

-- foreign key 삭제
alter table board3 drop constraint fk_board3_mem2_id;

--drop table board2;

create table mem2 as select * from member;
select * from mem2;
select * from board3;

insert into board3 values(
board_seq.nextval,'제목입니다3.','내용입니다3.','abc',board_seq.currval,0,0,0,'1.jpq',sysdate
);
select board_seq.nextval from dual;

select * from mem2 where id='aaa';

delete mem2 where id='aaa';

select * from board3 where id='abc';

delete board3 where id='abc';

commit;
--------------------------------------------------------------------------------

alter table board3 drop constraint fk_board3_mem2_id;

-- 부모키 삭제시 foreign ky로 등록된 데이터 모두 삭제
alter table board3 add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete cascade
;
-- 부모키 삭제시 foreign key로 등록된 데이터 null로
alter table board3 add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete set null
;
------------------------------------------------------------------------------

create table mem(
id varchar2(100) primary key,
pw varchar2(100) not null,
name varchar2(100) unique,--중복 X,null O
phone char(13) default '010-0000-0000',--입력값이 없으묜 default값 입력
gender nvarchar2(2) check(gender in ('남자','여자')),
hobby varchar2(100) default '게임',
age number(3) check(age between 0 and 120)
);
insert into mem(id,pw,gender) values('aaa','1111','남자');

select * from mem;

--------------------------------------------------------------------------------
create table stuscore2 as select * from stuscore;



------ 논리/조건 ----------------------------------------------------------------
select * from stuscore2;

alter table stuscore2 add leader nvarchar2(2);

update stuscore2 set leader=null; --where name=''

-- decode:조건이 같은 경우에 실행
select sno,name,
decode(sno,10,'반장',20,'부반장',30,'총무',40,'총무2') as leader2 from stuscore2;


--case when:조건이 같은 경우에 실행(비교연산자 활용 가능)
select sno,name,
case when sno<=10 then '반장'
when sno<=20 then '부반장'
when sno>=30 then '총무'
end as leader2
from stuscore2;

--ex)avg로 A,B,C,D,F rank
select sno, name, avg,
case when avg>=90 then'A'
when avg>=80 then'B'
when avg>=70 then'C'
when avg>=60 then'D'
else 'F'
end as rank from stuscore2;



select * from stuscore2;
alter table stuscore2 add event date;
alter table stuscore2 add rank nvarchar2(1);

--ex)
select sdate,last_day(sdate),trunc(sdate,'month') from stuscore2;
select sdate, event,last_day(sdate) from stuscore2;
update stuscore2 set event=last_day(sdate);
update stuscore2 set event=sysdate;

--ex)case when구문을 이용해 구한 값을 col에 삽입
update stuscore2 set rank='A';

select sno, name, avg, rank,
case when avg>=90 then'A'
when avg>=80 then'B'
when avg>=70 then'C'
when avg>=60 then'D'
else 'F'
end as rank from stuscore2;

update stuscore2 set rank=(

case when avg>=90 then'A'
when avg>=80 then'B'
when avg>=70 then'C'
when avg>=60 then'D'
else 'F'
end

);

select * from stuscore2;

commit;
rollback;

-- ex) rank를 avg뒤로



-- ex) leader를 맨뒤로



select * from stuscore2;

--ex)add 'class' col
--sno 1~10 1반, 
alter table stuscore2 add class varchar2(100);
select sno,name,
case when sno between 1 and 10 then '1반'
when sno between 11 and 20 then '2반'
when sno between 21 and 30 then '3반'
when sno between 31 and 40 then '4반'
when sno between 41 and 50 then '5반'
when sno between 51 and 60 then '6반'
when sno between 61 and 70 then '7반'
when sno between 71 and 80 then '8반'
when sno between 81 and 90 then '9반'
when sno between 91 and 100 then '10반'
end as class from stuscore2;

update stuscore2 set class=(
case when sno between 1 and 10 then '1반'
when sno between 11 and 20 then '2반'
when sno between 21 and 30 then '3반'
when sno between 31 and 40 then '4반'
when sno between 41 and 50 then '5반'
when sno between 51 and 60 then '6반'
when sno between 61 and 70 then '7반'
when sno between 71 and 80 then '8반'
when sno between 81 and 90 then '9반'
when sno between 91 and 100 then '10반'
end
);

select sno,name,total from stuscore2;
select * from stuscore2;

select name, total, rank()over(order by total desc) from stuscore2;



------ //논리/조건 --------------------------------------------------------------
--형변환 함수
--to_char(),to_number(),to_number()

--group함수(select내에서 단일함수와는 같이 못씀)select name max(kor) from stuscore2;(X)
--sum,avg,count,max,min
select sum(kor),avg(kor),count(kor),max(kor),min(kor) from stuscore2;

--group by(그룹함수와 단일함수를 같이 씀)
select * from stuscore2;

--반별 평균
select avg(total),avg(avg) from stuscore2;--전체
select class,avg(avg) from stuscore2
group by class;

--전체 평균보다 낮은 반
--group col+단이 col의 조건절은 having
select class,avg(avg) from stuscore2

group by class
having avg(avg)<=52.33;

--**group by, having, 다중 query
--ex) 부서별 월급 합계
select salary, department_id from employees
order by department_id;

select avg(salary) from employees;
--ex-1) 부서별 월급 합계중 평균보다 큰 부서
select department_id, sum(salary),avg(salary) from employees
group by department_id
having avg(salary)>=(select avg(salary) from employees)--2중 query
order by department_id;

------------------------------------------------------------------------


select sysdate from dual;
select sysdate,add_months(sysdate,6) from dual;

--ex)입사일, 입사일+6개월
select hire_date,add_months(hire_date,6) from employees;


select distinct department_id from employees;--중복제거

select count(*) from employees;
select count(manager_id) from employees;--null no count

--------------- join ----------------------------------------------------------
-- join:2개의 table을 동시에 나열
select count(*) from member,board;
select count(*) from member;--100
select count(*) from board;--100


select emp_name,department_id 
from employees;
select department_id,department_name 
from departments;
select emp_name,department_id,department_name 
from employees,departments;

--(cross join(100*100=10000))
--서로 중복되는 col을 이용해 join(where A.a=B.a)
select emp_name,employees.department_id,department_name,parent_id
from employees,departments
where employees.department_id=departments.department_id;

--([equi join]): 동일한 col이 존재할때
select * from employees,departments
where employees.department_id=departments.department_id;

--작성자,id
select * from board;

--id,이름,전화번호
select * from memeber;

select member.id,name,phone,bno,btitle from member,board
where member.id=board.id;
update member set name='길동스' where id='aaa';
commit;
--join한 경우 변경된 값을 가져옴

drop table mem;

create table mem as select * from member;

select * from mem;

delete mem where id not in('aaa','bbb','ccc','ddd','eee','fff','ggg','hhh','iii','jjj','kkk');

alter table mem add nickname varchar2(100);

select name, substr(name,2,length(name)-1)||'즈' from mem;

update mem set nickname=(
substr(name,2,length(name)-1)||'즈'
);

alter table mem modify phone invisible;
alter table mem modify email invisible;
alter table mem modify gender invisible;
alter table mem modify hobby invisible;

alter table mem modify phone visible;
alter table mem modify email visible;
alter table mem modify gender visible;
alter table mem modify hobby visible;

--[equi-join 예제]
--ex)board-mem id로 equi-join
select bno btitle,bcontent,mem.id,nickname 
from board,mem
where mem.id=board.id;

--ex)사원table-부서table join
--사원이름,부서번호,부서이름,월급
select emp_name,employees.department_id,department_name,salary 
from employees,departments
where employees.department_id=departments.department_id;


select a.id,nickname bno, btitle 
from mem a, board b
where a.id=b.id and a.id='aaa';

--([non equi join]): 공통 col 없이 table을 join
select * from stuscore;

--
create table scoregrade(
grade char(1),
lowgrade number(7,4),
highgrade number(7,4)
);

insert into scoregrade values('A',90,100);
insert into scoregrade values('B',80,89.9999);
insert into scoregrade values('C',70,79.9999);
insert into scoregrade values('D',60,69.9999);
insert into scoregrade values('F',0,59.9999);
commit;
drop table scoregrade;
--ex)stuscore-scoregrade join해 grade 입력
select * from stuscore;
select * from scoregrade;

select grade,lowgrade,highgrade from scoregrade;
select sno,name,kor,eng,math,total,avg,sdate from stuscore;

--stuscore의 avg를 scoregrade의 lowgarde와 highgrade 범위에서 조회해 grade 추가
select name,avg,grade
from stuscore a,scoregrade b
where avg between lowgrade and highgrade;


--[non equi join 예제]
--ex)월급을 가지고 직급 나누기
--salgrade 20k~50k, 13k~,10k~,8k~,6k~
--'대표','부사장','부장','과장','대리','사원'
select emp_name,salary
from employees
order by salary desc;

create table salrank(
rank char(3),
lowsalary number(6),
highsalary number(6)
);
select * from salrank;
commit;
alter table salrank modify rank char(16);

insert into salrank values('대표',20000,50000);
insert into salrank values('부사장',13000,19999);
insert into salrank values('부장',10000,12999);
insert into salrank values('과장',8000,9999);
insert into salrank values('대리',6000,7999);
insert into salrank values('사원',0,5999);

select emp_name,salary,rank
from employees a,salrank b
where salary between lowsalary and highsalary
order by salary desc;

--case when
select emp_name, salary,
case when salary between 20000 and 50000 then '사장'
when salary between 13000 and 19999 then '부사장'
when salary between 10000 and 12999 then '부장'
when salary between 8000 and 9999 then '과장'
when salary between 6000 and 7999 then '대리'
else '사원'
end as rank
from employees
;

--inner_join = equi_join + non_equi_join


select * from scoregrade;
select * from stuscore2;
alter table stuscore2 drop column grade;
commit;
--stuscore2-scoregrade join해 grade 출력
select name,avg,grade 
from stuscore2,scoregrade
where avg between lowgrade and highgrade;


--stuscore2 table에 grade col 추가후 입력(scoregrade 이용)
alter table stuscore2 add grade varchar2(1);


update stuscore2 
set grade=(
select grade 
from scoregrade
where avg between lowgrade and highgrade
);

select name,avg,grade from stuscore2;


--([self join]):같은 table 두개를 join

select employee_id,emp_name,manager_id,emp_name 
from employees;

select a.employee_id,a.emp_name,a.manager_id,b.emp_name 
from employees a,employees b
where a.manager_id=b.employee_id;

select count(*) from employees;

--([outer join]):해당 col에 null값이 있어도 출력시켜줌.
--manager_id에 null 값이 존재 그반편에 (+)
select a.employee_id,a.emp_name,a.manager_id,b.emp_name 
from employees a,employees b
where a.manager_id=b.employee_id(+)
;


--count:null은 no cout
select count(manager_id) from employees
where manager_id is null;
select count(*) from employees
where manager_id is null;

--ex) employees,departments에서 사원명,부서번호,부서명 출력{equi-join}
select emp_name,a.department_id,department_name
from employees a,departments b
where a.department_id=b.department_id(+)
;--a null
select emp_name,a.department_id,department_name
from employees a,departments b
where a.department_id(+)=b.department_id
;--b null

select distinct department_id from employees
order by department_id
;
select distinct department_id from departments
order by department_id
;

--([ansi join])
--ansi-equi join
select emp_name,department_id,department_name
from employees inner join departments
using(department_id)
;

--ansi outer join(left-full-right)
select emp_name,department_id,department_name
from employees full outer join departments
using(department_id)
;

--------------- //join --------------------------------------------------------

-------------------------------------------------------------------------------


-------------([순번 출력하는 방법])----------------------------------------------
select * from member;
select rownum,a.* from member a;

select rownum,a.* from employees a;

select * from board
order by bno;

create table board2 as select * from board;

select * from board2
where bno between 21 and 30
order by bno
;

--[rownum]
select rownum,a.* from board2 a
where rownum between 1 and 20
order by bno
;


--((rownum))
select * from
(
select rownum rnum,a.* from
(select * from board2 order by bno asc) a
)
where rnum between 11 and 20
;--(3)

select rownum rnum,a.* from
(select * from board2 order by bno asc) a
;--(2)

select * from board2 order by bno asc
;--(1)


delete board2 where bno=4;
delete board2 where bno=7;
delete board2 where bno=11;
delete board2 where bno=12;
delete board2 where bno=15;
delete board2 where bno=22;
delete board2 where bno=25;
delete board2 where bno=40;

--((row_number()))
select * 
from(
select row_number()over(order by bno asc) rnum,a.*
from board2 a
);--(2)

select row_number()over(order by bno asc) rnum,a.*
from board2 a
;--(1)row_number()로 정렬된 table
--------------------------------------------------------------------------------

select * from stuscore2;
select * from board2;


select row_number()over(order by bno asc) rnum,a.*
from board2 a
;

select * 
from (
select row_number()over(order by bno asc) rnum,a.*
from board2 a
)
where rnum between 21 and 30
;

