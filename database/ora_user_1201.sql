--[1]rownum
select rownum,* from memeber;--error
select rownum,a.* from member a;--별칭이 꼭있어야함

select rownum,a.* from member a--1열 먼저 실행(번호 달기)
order by id asc;--정렬

select rownum,a.* from
(select * from member order by id asc) a;

select rownum,a.* from
(select * from member order by id asc) a
where rownum>=1 and rownum<=10
;--11~20안됨, 1이 없어 초기화

select * from(
select rownum rnum,a.* from(
select * from member order by id asc) a
)
where rnum>=11 and rnum<=20
;

--[2]row_number():정렬이 있는 경우 사용
select row_number()over(order by id asc),a.* from member a;

select * from(
select row_number()over(order by id asc) rnum,a.* from member a
)
where rnum>=11 and rnum<=20
;

--select * from (table명);
--[3]select * (select 조건문);
--ex1-1)employees 가운데 이름에 a가 들어간 사람 출력
select * from employees
where emp_name like '%a%';
--ex1-2)그 가운데 월급이 7000 이상인 사람
select * from employees
where salary>=7000;
--ex1-1)+ex1-2)
select * from 
(select * from employees where emp_name like '%a%')
where salary>=7000;

select * from employees
where emp_name like '%a%' and salary>=7000;

--------------------------------------------------------------------------------
--[4]rank()over(order by A asc/desc): A 기준으로 (순/역순)등수 정렬
select rank()over(order by total desc),name,total from stuscore;
select rank()over(order by total desc),dense_rank()over(order by total desc),name,total
from stuscore;--dense_rank():중복순위 후 건너뛰기 없음

select dence_rank()over(order by name asc) rank,name,avg from stuscore;

--------------------------------------------------------------------------------

--ex2)
select * from stuscore;

alter table stuscore add rank number(3) default '0';

select rank()over(order by total desc) ranks,sno,name,total,avg from stuscore;
select rank()over(order by total desc) ranks from stuscore;

select sno,rank()over(order by total desc) ranks from stuscore;

--(*)column,row 수정 명령어 update
update stuscore a set rank=
(
select ranks from(
select sno,rank()over(order by total desc) ranks from stuscore) b
where a.sno=b.sno
)
;

--rollback;
commit;

create table stuscore3 as select * from stuscore;
select * from stuscore3;

update stuscore3 set rank=0;

alter table stuscore add grade nchar(1) default '';

--ex3)non-equi join
--ex3-1)avg로 grade구해 입력
--stuscore3-scorgrade
--avg 90 이상 A, 80 이상 B, 70 C, 60 D, F table 입력수정
--step1)출력
select name, avg, b.grade 
from stuscore3 a,scoregrade  b
where avg between lowgrade and highgrade;
--step2)입력
update stuscore3 set grade=(
select grade 
from scoregrade
where avg between lowgrade and highgrade
)
; 
--ex3-2)avg로 rank를 구해 입력
--step1)출력
select sno,name,avg,dense_rank()over(order by avg desc) ranks
from stuscore3;
--step2)입력
update stuscore3 a set rank=(
select dense_rank()over(order by avg desc) ranks from stuscore3
);--stuscore3와 ranks의 순번이 달라서 에러

update stuscore3 a set rank=(
select ranks from(
select sno, dense_rank()over(order by avg desc) ranks from stuscore3
) b
where a.sno=b.sno
)
;
--------------------------------------------------------------------------------
--
select * from stuscore2;
select name, avg, g.grade from stuscore2,scoregrade g
where avg between lowgrade and highgrade;


--------------------------------------------------------------------------------
select * from stuscore
;

commit;
update stuscore set rank='';

select max(sno) from stuscore;
select stuscore_seq.nextval from dual;

--drop table stuscore3;
--delete stuscore3;

create table stuscore3 as select * from stuscore where 1=2;
select * from stuscore3;

insert into stuscore3 values(
stuscore3_seq.nextval,'홍길동',100,100,99,(100+100+99),(100+100+99)/3,sysdate,0,''
);

select * from stuscore
where name like '%na%';

rollback;