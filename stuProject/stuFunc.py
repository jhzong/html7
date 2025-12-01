from stuConnect import*

title=['sno','name','kor','eng','math','total','avg','rank','grade','sdate']

# 1.성적입력함수
def stuInput():
    print('1.성적입력')
    print('-'*30)
    name=input('학생이름 입력>>')
    kor=int(input('국어성적 입력>>'))
    eng=int(input('영어성적 입력>>'))
    math=int(input('수학성적 입력>>'))
    total=kor+eng+math
    avg=total/3
    conn=getConnection()
    cursor=conn.cursor()
    query=f"insert into stuscore4 values(\
    stuscore4_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},'','',sysdate)"
    cursor.execute(query)
    conn.commit()
    conn.close()
    print('성적입력완료')
# test
# stuInput()

# 2.성적출력
def stuPrint():
    print('2.성적출력')
    print('-'*40)
    conn=getConnection()
    cursor=conn.cursor()
    query="select * from stuscore4"
    cursor.execute(query)
    rows=cursor.fetchall()
    print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
    print('-'*80)
    for row in rows:
        print('{}\t{}\t{}\t{}\t{}\t{}\t{:.2f}\t{}\t{}\t{}'.format(*row))
    conn.commit()
    conn.close()

# 3.성적수정

# 4.성적삭제
def stuDelete():
    search=input('학생이름 입력>>')
    conn=getConnection()
    cursor=conn.cursor()
    query=f"select * from stuscore4 where name like '%{search}%'"
    cursor.execute(query)
    rows=cursor.fetchall()
    if len(rows)>0:
        print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
        print('-'*80)
        for row in rows:
            print('{}\t{}\t{}\t{}\t{}\t{}\t{:.2f}\t{}\t{}\t{}'.format(*row))
        conn.commit()
        conn.close()
        choice=int(input('삭제할 성적의 학생번호>>'))
        confirm=int(input('정말로 삭제할까요?(1.예/0.아니오)'))
        if confirm==1:
            conn=getConnection()
            cursor=conn.cursor()
            query=f"delete stuscore4 where sno={choice}"
            cursor.execute(query)
            conn.commit()
            conn.close()
            print('삭제완료')
        else:
            print('삭제취소')
    
    else:
        print('검색결과 없음...')

# 5.성적검색

# 6.성적정렬

# 7.등수산출

# 8.등급산출














# search=input('학생이름>>')

# if len(rows)>0:
#     print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
#     print('-'*80)
#     for row in rows:
#         print('{}\t{}\t{}\t{}\t{}\t{:.2f}\t{}\t{}\t{}'.format(*row))
#     conn.commit()
#     conn.close()
#     choice=int(input('삭제할 성적의 학생번호>>'))
#     conn=getConnection()
#     cursor=conn.cursor()
#     query=f"delete stuscore4 where sno={choice}"
