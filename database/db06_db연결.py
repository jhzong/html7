import oracledb

def getConnection():
    return oracledb.connect(user='ora_user',password='1111',dsn='localhost:1521/xe')

while(True):
    print('1.입력')
    print('2.출력')
    print('3.수정')
    print('4.삭제')
    choice=input('menu')
    if choice=='1':
        #db연결
        conn=getConnection()
        cursor=conn.cursor()
        
        # #insert/update/delete
        # query='insert into member values ()'
        # cursor.execute(query)
        # conn.commit
        
        #select-fetchall():여러명(list타입),fetchone():1명(tuple타입)
        query="select * from member where id='aaa'"
        cursor.execute(query)
        rows=cursor.fetchall()
        print(rows)
        
        
        #db연결종료
        conn.close()
        pass
    elif choice=='2':
        #db연결
        #db연결종료
        pass
    else:
        #db연결
        #db연결종료
        pass