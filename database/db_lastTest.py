import datetime
from db_lastConn import *


title=['번호','이름','국어','영어','수학','합계','평균','날짜','등수','등급']


# 4.성적삭제

# 3.성적수정
# 3-1.학생검색
name=input('학생이름 입력>>')
# db연결-효율배치요망
conn=getConnection()
cursor=conn.cursor()
query=f"select * from stuscore where name like '%{name}%'"
cursor.execute(query)
rows=cursor.fetchall()
print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
print('-'*80)
if len(rows)>0:
    # print('개수:',len(rows))
    for r in rows:
        # r[7].strftime('%y-%m-%d'):sysdate-시/분/초 생략
        print(f'{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime('%y-%m-%d')}\t{r[8]}\t{r[9]}'.format(*r))
    choice=int(input('수정하려는 학생번호>>'))
    query=f"select * from stuscore where sno={choice}"
    cursor.execute(query)
    row=cursor.fetchone()
    if row:print(row)
    else:print('잘못입력...')
else:
    print('검색결과없음...')
print()

conn.commit()
conn.close()
print('성적수정완료')

# 1.성적입력-stuscore3
def stuInput():
    name=input('이름 입력>>')
    kor=int(input('국어 점수 입력>>'))
    eng=int(input('영어 점수 입력>>'))
    math=int(input('수학 점수 입력>>'))
    total=kor+eng+math
    avg=total/3
    # db연결-효율배치요망
    conn=getConnection()
    cursor=conn.cursor()
    query=f"insert into stuscore3 values(\
    stuscore3_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},sysdate,0,'')"
    cursor.execute(query)

    conn.commit()
    conn.close()

    print(name,'학생성적 입력완료')

# 2.성적출력
def stuOutput():
    print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
    print('-'*80)
    # db연결-효율배치요망
    conn=getConnection()
    cursor=conn.cursor()
    query='select * from stuscore3 order by sno'
    cursor.execute(query)
    rows=cursor.fetchall()
    for r in rows:
        # r[7].strftime('%y-%m-%d'):sysdate-시/분/초 생략
        print(f'{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime('%y-%m-%d')}\t{r[8]}\t{r[9]}'.format(*r))
    print()
    conn.commit()
    conn.close()


# test호출
# stuInput()
# stuOutput()