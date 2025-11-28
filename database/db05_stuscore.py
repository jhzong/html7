import oracledb
# db함수
def getConnection():
    return oracledb.connect(user='ora_user',password='1111',dsn='localhost:1521/xe')
# conn=getConnection()# ora_user로 접속
# cursor=conn.cursor()# sql dev를 실행
# print('connection :',conn)
# conn.close()
title=["No.","name","Kor","Eng","Math","T.sum","Avg","Sdate"]
while True:
    print('[학생성적프로그램]')
    print('1.학생성적입력')
    print('2.학생성적출력')
    print('3.학생성적수정')
    print('4.학생성적삭제')
    print('0.프로그램종료')
    choice=int(input('수행업무 선택>>'))
    if choice==1:
        print('1.학생성적입력')
        name=input('학생이름>>')
        kor=int(input('국어성적>>'))
        eng=int(input('영어성적>>'))
        math=int(input('수학성적>>'))
        total=kor+eng+math
        avg=total/3
        conn=getConnection()# ora_user로 접속
        cursor=conn.cursor()# sql dev를 실행
        query=f"insert into stuscore values(stuscore_seq.nextval,\
            '{name}','{kor}','{eng}','{math}','{total}','{avg}',sysdate)"
        cursor.execute(query)
        conn.commit()
        print('학생성적 저장')
        
        conn.close()
    
    elif choice==2:
        print('2.학생성적출력')
        conn=getConnection()# ora_user로 접속
        cursor=conn.cursor()# sql dev를 실행
        query='select * from stuscore order by sno'
        cursor.execute(query)
        rows=cursor.fetchall()
        print('{}\t{}\t\t{}\t{}\t{}\t{}\t{}\t{}'.format(*title))
        print('-'*30)
        for row in rows:
            print('{}\t{:15s}\t{}\t{}\t{}\t{}\t{:.2f}\t{}'.format(*row))
        
        conn.close()
            
    elif choice==3:
        print('3.학생성적수정')
        # 전체리스트출력
        conn=getConnection()# db접속
        cursor=conn.cursor()# db접속
        query="select * from stuscore order by sno"
        cursor.execute(query)
        rows=cursor.fetchall()
        print('{}\t{}'.format(*title))
        for row in rows:
            print('{}\t{}'.format(*row))
        
        # 학생/과목선택
        sno=int(input('학생번호 입력>>'))
        print("{}\t{}\t\t{}\t{}\t{}".format(*title))
        print("{}\t{}\t{}\t{}\t{}".format(*rows[sno-1]))
        conn.close()
        sbj=int(input('과목선택(1.국어/2.영어/3.수학)>>'))
        
        # 수정
        if sbj==1:# 국어
            newscore=int(input('새로운 점수입력>>'))
            conn=getConnection()# db접속
            cursor=conn.cursor()# db접속
            query=f"update stuscore set kor={newscore} where sno={sno}"
            cursor.execute(query)
            conn.commit()
            conn.close()
            
        elif sbj==2:# 영어
            newscore=int(input('새로운 점수입력>>'))
            conn=getConnection()# db접속
            cursor=conn.cursor()# db접속
            query=f"update stuscore set eng={newscore} where sno={sno}"
            cursor.execute(query)
            conn.commit()
            conn.close()

        else:# 수학
            newscore=int(input('새로운 점수입력>>'))
            conn=getConnection()# db접속
            cursor=conn.cursor()# db접속
            query=f"update stuscore set math={newscore} where sno={sno}"
            cursor.execute(query)
            conn.commit()
            conn.close()

        # total,avg 갱신
        conn=getConnection()# db접속
        cursor=conn.cursor()# db접속
        query="update stuscore set total=kor+eng+math, avg=(kor+eng+math)/3"
        cursor.execute(query)
        conn.commit()
        conn.close()
        # commit
        print('수정완료')
    
    elif choice==4:
        print('4.학생성적삭제')
        # 전체리스트 출력
        conn=getConnection()# db접속
        cursor=conn.cursor()# db접속
        query='select sno,name from stuscore order by sno'
        cursor.execute(query)
        rows=cursor.fetchall()
        print('{}\t{}'.format(*title))# 학생리스트 출력       
        print('-'*30)
        for row in rows:
            print('{}\t{}'.format(*row))
        sno=int(input('성적기록삭제 학생번호>>'))# 삭제할 성적의 학생번호 선택
        confirm=int(input(f'{sno}번 학생의 성적을 삭제할까요?(1.Y/2.N)>>'))# 삭제확인문
        if confirm==1:# 삭제
            query=f"delete stuscore where sno='{sno}'"
            cursor.execute(query)
            conn.commit()
            conn.close()
            print('삭제완료')
        else:# 취소
            print('삭제취소')
            conn.close()
            continue

    else:
        print('0.프로그램종료')
        break
