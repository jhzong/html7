import datetime
from db_lastConn import *

title=['번호','이름','국어','영어','수학','합계','평균','날짜','등수','등급']

# 1.성적입력-stuscore3------------------------------------------------------------------
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

# 2.성적출력----------------------------------------------------------------------------
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
        print(f'''{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t
              {r[5]}\t{r[6]:.2f}\t{r[7].strftime('%y-%m-%d')}\t{r[8]}\t{r[9]}''')
    print()
    conn.commit()
    conn.close()

# 3.성적수정----------------------------------------------------------------------------
def stuUpdate():
    # 3-1.학생검색
    name=input('학생이름 입력>>')
    # db연결-효율배치요망
    conn=getConnection()
    cursor=conn.cursor()
    query=f"select * from stuscore3 where name like '%{name}%'"
    cursor.execute(query)
    rows=cursor.fetchall()
    print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
    print('-'*80)
    if len(rows)>0:
        # print('개수:',len(rows))
        for r in rows:
            # r[7].strftime('%y-%m-%d'):sysdate-시/분/초 생략
            print(f'{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\
                \t{r[6]:.2f}\t{r[7].strftime('%y-%m-%d')}\t{r[8]}\t{r[9]}')
        choice=int(input('수정하려는 학생번호>>'))
        query=f"select * from stuscore3 where sno={choice}"
        cursor.execute(query)
        r=cursor.fetchone()
        r=list(r)# 튜플타입을 리스트타입으로 변경
        conn.commit()
        conn.close()
        if r:
            print(f'[{r[1]}학생 성적수정]')
            print('1.국어수정')
            print('2.영어수정')
            print('3.수학수정')
            choice2=int(input('과목선택>>'))
            # title[2] kor, title[3] eng, title[4] math
            if 1<=choice2<=3:
                print(f'{title[choice2+1]} 현재점수 :',r[choice2+1])
                r[choice2+1]=int(input(f'{title[choice2+1]} 새로운 점수>>'))
                r[5]=r[2]+r[3]+r[4]
                r[6]=r[5]/3
                conn=getConnection()
                cursor=conn.cursor()
                query=f"update stuscore3 set kor={r[2]},eng={r[3]},\
                    math={r[4]},total={r[5]},avg={r[6]} where sno={r[0]}"
                cursor.execute(query)
                conn.commit()
                conn.close()
                print(f'{title[choice2+1]} 수정완료')
                
            else:
                print('잘못된 과목번호...다시입력')
        else:
            print('잘못입력...다시입력')
    else:
        print('검색결과없음...')
    print()

    print('성적수정완료')


# 4.성적삭제----------------------------------------------------------------------------
def stuDelete():
    name=input('학생이름 입력>>')
    # db연결-효율적인 배치권장
    conn=getConnection()
    cursor=conn.cursor()
    query=f"select * from stuscore3 where name = '{name}'"
    cursor.execute(query)
    r=cursor.fetchone()
    if r:# 있는경우
        # 출력
        print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
        print('-'*80)
        print(f'{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\
            \t{r[6]:.2f}\t{r[7].strftime('%y-%m-%d')}\t{r[8]}\t{r[9]}'.format(*r))
        choice=int(input('정말 삭제하시겠습니까?(1.예/0.아니오)'))
        if choice==1:
            query=f"delete stuscore3 where name ='{name}'"
            cursor.execute(query)
            conn.commit()
            print(f'{name}학생 성적이 삭제되었습니다.')
        else:
            print('삭제가 취소됩니다.')

    else:
        print('삭제하려는 학생이 없습니다.')

    conn.commit()
    conn.close()

# 5.학생검색----------------------------------------------------------------------------
def stuSearch():
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
            print(f'{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\
                \t{r[6]:.2f}\t{r[7].strftime('%y-%m-%d')}\t{r[8]}\t{r[9]}'.format(*r))
    conn.commit()
    conn.close()

# 6.학생성적 정렬------------------------------------------------------------------------
def stuOrder():
    print('1.학생이름')
    print('2.학생성적')
    choice=int(input('번호입력>>'))
    conn=getConnection()
    cursor=conn.cursor()
    if choice==1:
        query=f"select * from stuscore order by name"
        cursor.execute(query)
    else:
        query=f"select * from stuscore order by total desc"
        cursor.execute(query)
    
    rows=cursor.fetchall()
    print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
    print('-'*80)
    if len(rows)>0:
        for r in rows:
            print(f'{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\
                \t{r[6]:.2f}\t{r[7].strftime('%y-%m-%d')}\t{r[8]}\t{r[9]}'.format(*r))

# 7.등수처리----------------------------------------------------------------------------
def stuRank():
    conn=getConnection()
    cursor=conn.cursor()
    query=f"""
    update stuscore a set rank=(select ranks from
    (select sno, rank()over(order by total desc) ranks from stuscore)b
    where a.sno=b.sno)
    """
    cursor.execute(query)
    
    conn.commit()
    conn.close()
    print('등수처리완료')

# 8.등급처리----------------------------------------------------------------------------
def stuGrade():
    conn=getConnection()
    cursor=conn.cursor()
    query=f"""
    update stuscore set grade=(
    select grade from scoregrade
    where avg between lowgrade and highgrade)
    """
    cursor.execute(query)
    
    conn.commit()
    conn.close()
    print('등급처리완료')
