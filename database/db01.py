import oracledb
# db연결함수
def getConnection():
    return oracledb.connect\
    (user="ora_user",password="1111",dsn="localhost:1521/xe")

# db연결
conn = getConnection() ## sql실행
cursor = conn.cursor() ## 창

# query구문
query = "select * from member"
cursor.execute(query)
# 데이터를 가져옴
rows = cursor.fetchall()

# 데이터를 출력
print(f"아이디\t비밀번호\t이름\t전화번호\t이메일\t성별\t취미")
print('-'*70)
for row in rows:
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}".format(*row))

## [[aaa,1111],[bbb,2222],...]
print('-'*70)
# print('연결 : ',conn)
