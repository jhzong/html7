create table acc_info(
name varchar2(100),
id varchar2(100),
pw varchar2(100),
email varchar2(100),
email_yn char(2),
zonecode char(5),
address varchar2(100),
m_phone char(13),
sms_yn char(2),
h_phone char(12),
birth date,
calendar_SL char(2),
emp_mem_yn char(2)
);

alter table acc_info modify id varchar2(100) primary key;

insert into acc_info values(
'홍길동','aaa','1111','aaa@gamil.com','Y',
'11111','서울 강남구','010-1111-1111','N',
'02-111-1111','2000.01.01','S','N');

alter table acc_info add join_date date;
UPDATE acc_info set join_date=sysdate where id='aaa';
UPDATE acc_info set email='aaa@gmail.com' where id='aaa';

desc acc_info;
select * from acc_info;
commit;
delete acc_info;
rollback;

insert into acc_info values(
'유관순','bbb','2222','bbb@hanmail.net','N',
'22222','서울 광진구','010-2222-2222','N',
'02-222-2222','2000.02.02','S','Y',sysdate);

select * from employees;
desc employees;
select EMPLOYEE_ID,EMP_NAME,salary from employees
where nvl(manager_id,0)=0;