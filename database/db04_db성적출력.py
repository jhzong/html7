import oracledb
# db연결
def getConnection():
    return oracledb.connect(user="ora_user",password="1111",dsn="localhost:1521/xe")

title=["No.","name","Kor","Eng","Math","T.sum","Avg","Sdate"]

while True:
    print('[학생성적프로그램]')
    print('-'*30)
    print('1.학생성적입력')
    print('2.학생성적출력')
    print('3.학생성적수정')
    print('4.학생성적삭제')
    print('0.프로그램종료')
    print('-'*30)
    choice=int(input('원하는 번호를 입력하시오>>'))
    if choice==1:
        print('1.학생성적입력')
        name=input('학생 이름을 입력하시오>>')
        kor=int(input('국어성적을 입력하시오>>'))
        eng=int(input('영어성적을 입력하시오>>'))
        math=int(input('수학성적을 입력하시오>>'))
        total=kor+eng+math
        avg=total/3
        conn=getConnection() # ora_user사용자 연결
        cursor=conn.cursor() # sql dev 실행
        query=f"insert into stuscore values(stuscore_seq.nextval,'{name}','{kor}','{eng}','{math}','{total}','{avg}',sysdate)"
        cursor.execute(query) # query문 실행
        conn.commit() # insert, update, delete, commit 실행
        print('학생성적을 저장합니다.')
        conn.close()

    elif choice==2:
        print('2.학생성적출력')
        print('-'*50)
        conn = getConnection()# db연결
        cursor = conn.cursor()
        query = "select * from stuscore"
        cursor.execute(query)
        
        rows=cursor.fetchall() # 검색내용출력
        
        print("{}\t{}\t\t{}\t{}\t{}\t{}\t{}\t{}".format(*title))
        for row in rows:
            print("{}\t{:15s}\t{}\t{}\t{}\t{}\t{:.2f}\t{}".format(*row))
        
        conn.close() # db연결종료(※꼭 연결끊기)
        
    elif choice==3:
        pass
    elif choice==4:
        pass
    else:
        print('0.프로그램종료')
        break