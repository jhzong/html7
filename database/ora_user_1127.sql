update stuscore set kor={} where sno={};--{}번 학생의 국어 수정
update stuscore set eng={} where sno={};--{}번 학생의 영어 수정
update stuscore set math={} where sno={};--{}번 학생의 수학 수정
--------------------------------------------------------------------------------
select * from board;
select * from employees;
--------------- 날짜함수 --------------------------------------------------------
-- 날짜함수는 +/-,<,>,<=,>= 연산 가능
select sysdate from dual;
select sysdate-1,sysdate,sysdate+1,sysdate+100 from dual;

select bdate from board
where bdate>'2025-11-01';

--ex)가장 오래 근무한 사원순으로 정렬 출력
select emp_name, sysdate-hire_date as hdate from employees
order by sysdate-hire_date;

--ex)board에서 게시글이 얼마나 지났는지 출력
--둘째에서 반올림
desc board;
select BNO,BTITLE,round(sysdate-bdate,2) from board
order by round(sysdate-bdate,2);

select * from board;
select * from stuscore order by sno desc;

--date 시간까지 표시
select to_char(sdate,'yyyy-mm-dd hh:mi:ss') 
from stuscore order by sno desc;
select to_char(sdate,'yyyy-mm-dd hh24:mi:ss') 
from stuscore order by sno desc;--24시
select to_char(sdate,'yyyy-mm-dd am hh:mi:ss') 
from stuscore order by sno desc;--am/pm


insert into stuscore values(
stuscore_seq.nextval,'이순신',80,81,88,80+81+88,(80+81+88)/3,sysdate
);
commit;

select hire_date from employees;

--날짜 round
--ex)month:15일 미만 이번달 1일,15일 이상 다음달 1일
select hire_date, round(hire_date,'month') from employees;
--ex)day:수요일 미만이면 일요일 날짜,수요일 이상이면 다음주 일요일 날짜
select hire_date, round(hire_date,'day') from employees;

--날짜 trunc
select hire_date,trunc(hire_date,'month') from employees;
--ex)
select bdate, trunc(bdate,'month') from board;

select * from board;
select * from member;

--ex)게시글 24.12.1~25.5.31
select bno,bdate from board
where bdate between '2024-12-01' and'2025-05-31'
order by bdate;
select bno,bdate,trunc(bdate,'month'),bdate-30 from board
where bdate>='2024-12-01' and bdate<='2025-05-31'
order by bdate;

select bdate, to_char(bdate,'yyyy.mm.dd hh:mi:ss') from board;
select bdate, trunc(bdate,'month') from board;

select bdate, trunc(bdate,'yyyy') from board;
select bdate, trunc(bdate,'mm') from board;
select bdate, to_char(trunc(bdate,'dd'),'yyyy-mm-dd hh:mi:ss') from board;
select name, sdate, to_char(trunc(sdate,'dd'),'yyyy-mm-dd hh:mi:ss') from stuscore;

--날짜사이의 개월수:month_between(a,b)
select sdate from stuscore;
select sysdate,sdate,trunc(months_between(sysdate,sdate))||'개월' from stuscore
where months_between(sysdate-1,sdate)=9;

--add_months:특정 개월수를 더한 날짜확인
select name,sdate,add_months(sdate,6) from stuscore;


--------------- //날짜함수 ------------------------------------------------------

------------------ 문자열 함수---------------------------------------------------
--col 합치기
select concat(btitle,bcontent) from board;--concat(a,b)
select btitle||bcontent from board;--a||b

select * from member;
select id||pw from member;
select id||','||pw from member;
select id||'-'||pw||'-'||name as tel from member;--전화번호

--length:문자 길이,lengthb:byte수(한글:3byte,영어:1byte)
select name,length(name),lengthb(name) from stuscore;

--substr(A,b,c):A문자열을 b째자리부터 c개 만큼 출력(col명,시작위치,개수)
select name, substr(name,0,2) from stuscore;

--ex)s1423,s2798 숫자의 합
select substr('s1423',2,4),substr('s2798',2,4)from dual;
select to_number(substr('s1423',2,4)),to_number(substr('s2798',2,4))from dual;
select to_number(substr('s1423',2,4))+to_number(substr('s2798',2,4))from dual;

select name from member;
--ex)ni가 있는 이름
--**A like '%b%': A 중 b가 있는 것
select name from member
where name like '%n%';

--instr(A,'b'):A 문자열에서 'b'가 있는 위치(0값:'b'가 없음)
--!=,<>,^=:not
select name, instr(name, 'n') from member
where instr(name, 'n')!=0--0이 아닌거
;

--**trim함수:공백제거,ltrim(왼),rtrim(오)
select '    abc     ' from dual;
select trim('    abc     ') from dual;
select ltrim('    abc     ') from dual;
select rtrim('    abc     ') from dual;

--**replace(A,b,c):문자열 A에서 'b'를 'c'로 교체
SELECT replace('    abc     ',' ','')from dual;

select 'rove,rive,rife' from dual;
select replace('rove,rive,rife','r','l') from dual;

--ex)
select name, replace(name,'r','l') from member
where name like '%r%'
;

select id, pw from member;
--lpad(A,b,c)/rpad(A,b,c):
select id,rpad(pw,10,'*') from member;

select id,rpad(pw,4,'*') from member;
select id,rpad(substr(pw,0,2),4,'*') from member;--개인정보 보호


------------------ //문자열 함수-------------------------------------------------

--drop table stu;
create table stu (
sno number(4),
name varchar2(100),
sdate date,
sdate2 date
);

select * from stu;

insert into stu(sno,name,sdate) select sno,name,sdate from stuscore;

commit;

--ex00)**sdate2에 10년후 날짜 삽입
select sno,name,sdate,sdate2,add_months(sdate,120) from stu;
select add_months(sdate,120) from stu;
update stu set sdate2=sysdate
where name='이순신';
--풀이)join
update stu a set sdate2=(
select add_months(sdate,120) from stu b
where a.sno=b.sno
);
select * from stu;
rollback;
commit;


--trunc(A,'month'),last_day(A):
select hire_date,trunc(hire_date,'month'), last_day(hire_date) from employees;
--next_day(A,'요일')
select sysdate,next_day(sysdate,'월') from dual;

-----------------------------------------------------------------------------
--순번 구하기rank()over(order by A asc/desc)
select * from stuscore;
select sno,name,total,rank()over(order by total desc) rank from stuscore;
-----------------------------------------------------------------------------

----------------- 형변환함수 to_char(),to_number(),to_date()----------------
--to_char():천단위표시
--'000,000':빈자리는 0으로 채움,'999,999':빈자리는 공백으로 남김
--',':천단위 자리 '.':소수점 자리
select salary,salary*12,salary*12*1473 from employees;
--12,000,000
select salary,to_char(salary*12,'$999,999'),to_char(salary*12*1473,'999,999,999')
from employees;--9:남는 자리는 

--날짜 형변환
--to_char(T,'yyyy-mm-dd hh24:mi:ss')
--to_char(T,'yyyy-mon-dd hh24:mi:ss day')
select sdate from stuscore;
select sdate,to_char(sdate,'yyyy-mm-dd hh24:mi:ss day') from stuscore;
select sdate,to_char(sdate,'yyyy/mm/dd day') from stuscore;
select sdate,to_char(sdate,'mm') from stuscore;

select sdate,substr(sdate,4,2) from stuscore;

select * from member;
select phone from member;
select phone,substr(phone,1,3),substr(phone,5,3),substr(phone,9,4) from member;


--to_date():문자를 날짜로 형변환
select sysdate-'20251127', sysdate-to_date('20251127','yyyy.mm.dd') from dual;
select sysdate-'20251127' from dual;--문자열과 날짜 타입 연산X
select sysdate-to_date('20251127','yyyy.mm.dd') from dual;
select add_months(to_date('20251127','yyyy.mm.dd'),1) from dual;
select months_between(sysdate,to_date('20251120','yyyy.mm.dd')) from dual;

--to_number():문자열을 숫자로 변경
select '20,000','30,000' from dual;
select to_number('20,000','99,999'),replace('30,000',',','') from dual;
select '30000',to_number('30000') from dual;

select to_char(salary,'999,999'), to_char(salary*12,'999,999'), to_char(salary*12*1465,'999,999,999') from employees;

------------------ //형변환함수 ---------------------------------------------

--그룹함수(단일함수와 동일 select에서 함께 사용불가)
--max()최대값,min()최소값,median()중간값,variance()분산,stddev()표준편차
--sum()합계,avg()평균,count()개수
select max(kor),min(kor),median(kor),round(variance(kor),2),round(stddev(kor),2) from stuscore;
select sum(kor),avg(kor),count(kor) from stuscore;

select count(*) from employees;
select department_id,salary from employees;
select sum(salary),round(avg(salary),2),max(salary),min(salary),count(salary) from employees
where department_id=50;

--ex)
select max(salary) from employees
where department_id=50;
select emp_name from employees
where department_id=50 and salary=(
select max(salary) from employees
where department_id=50
);
--ex)
select max(salary) from employees;
select emp_name from employees
where salary=(
select max(salary) from employees
);

--ex)avg salary보다 월급이 높은 사원
select round(avg(salary),2) from employees;

select emp_name,salary from employees
where salary>=(select avg(salary) from employees)
order by salary desc;

select count(*) from employees
where salary>=(select avg(salary) from employees)
order by salary desc;

--ex)stuscore에서 국어가 평균이상인 사람은 몇명?
select avg(kor) from stuscore;
select count(*) from stuscore
where kor>=(select avg(kor) from stuscore);

--count(*)
select count(*) from employees;
select count(emp_name) from employees;
select count(manager_id) from employees;--검색 항목에 null값은 no카운트
--null 찾기
select manager_id from employees
where manager_id is null;


------------------------------------------------------------------------------
--ex)
select count(*) from stuscore
where total>={'입력값'};

select count(*) from stuscore
where total>=250    ;

--ex) 전화 번호를 받아 111-****-1111 형태로 출력
select phone from member;
select substr(phone,1,3)||'-****-'||substr(phone,9,4) from member;

--ex) pw를 11**로 출력
select pw from member;
select rpad(substr(pw,0,2),4,'*') from member;
select rpad(substr(pw,0,length(pw)-2),4,'*') from member;--length사용

--ex) 뒤의 두글자를 '*'로 대체. 홍**, Luci**,gregoi**
select name from member;
select name, substr(name,0,length(name)-2)from member;
select name,rpad(substr(name,0,length(name)-2),length(name),'*') from member;


----------------------------------------------------------------------------
-- 제약조건:primary key, foreign key, not null, unique, check
--primay key: null X, 중복 X
--foreign key: 다른 table에 primary key로 등록되어야 FK로 등록 가능
--not null:null불가,중복가능
--unique:중복불가 null가능
--check:설정값만 입력가능
create table mem(
id varchar2(100) primary key,
pw varchar2(100) not null,
name varchar2(100) unique,
phone char(13),
gender nvarchar2(2) check(gender in ('남자','여자')),
hobby varchar2(100),
mdate date
);

insert into mem values(
'aaa','1111','홍길동','010-111-1111','남자','게임',sysdate
);
insert into mem values(
'bbb','1111',null,'010-111-1111','남자','게임',sysdate
);
insert into mem values(
'ccc','1111',null,'010-111-1111','여자','게임',sysdate
);
insert into mem values(
'ddd','1111',null,'010-111-1111','여자','게임',sysdate
);
insert into mem values(
'eee','1111',null,null,null,null,null
);
select * from mem;

insert into mem (id,pw,gender) values(
'fff','1111','남자'
);

select * from board;
commit;

create table board2 as select * from board;

--foreign key 등록
alter table board2
add constraint fk_mem_board2_id foreign key(id)
references mem(id)
;
--mem과 board2dml id가 연결됨
--mem에 없는 id는 board2에 id 등록불가
--mem은 board2의 id가 삭제되지 않으면 mem 삭제불가