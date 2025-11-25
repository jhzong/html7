--ddl 테이블 생성,수정,삭제 명령어

--테이블 생성
create table member(
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(50)
);

--dml 테이블 안의 데이터를 추가,수정,삭제,검색 명령어

--테이블에 데이터 추가(insert)
insert into member (id,pw,name) values (
'aaa','1111','홍길동'
);
insert into member (id,pw,name) values (
'bbb','2222','유관순'
);
insert into member (id,pw,name) values (
'ccc','3333','이순신'
);
insert into member (id,pw,name) values (
'ddd','4444','김구'
);
insert into member (id,pw,name) values (
'eee','5555','강감찬'
);
insert into member (id,pw,name) values (
'fff','6666','김유신'
);
insert into member (id,pw,name) values (
'ggg','7777','홍길자'
);
-- 임시저장만 됨

--삭제
delete member where id='aaa';
delete member;

--부활(commit~rollback 데이터 복구)
rollback;


-- 저장 확정(commit)
commit;


--테이블의 데이터 검색(select)
select id,pw,name from member;

--테이블의 데이터 수정(update)
update member set pw='7777' where id='aaa';

select * from member;

--테이블의 타입 확인
desc member;
