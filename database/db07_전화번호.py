# # .strip():공백제거
# choice=input('input num>>').strip()
# if choice=='1':
#     print('O')
# else:
#     print('X')

import oracledb

def getConnection():
    return oracledb.connect(user='ora_user',password='1111',dsn='localhost:1521/xe')

conn=getConnection()
cursor=conn.cursor()

# 1.member table에서 phone col을 분리한 후 국번/전화번호1/전화번호2로 출력
# query='select substr(phone,1,3),substr(phone,5,3),substr(phone,9,4) from member'
# cursor.execute(query)
# rows=cursor.fetchall()
# print('국번\t전번1\t전번2')
# print('-'*35)
# for row in rows:
#     print('{}\t{}\t{}'.format(*row))


# 2. member table에서 phone을 가져와 python에서 분리
query='select phone from member'
cursor.execute(query)
rows=cursor.fetchall()
print('국번\t전번1\t전번2')
print('-'*20)
for row in rows:
    r=row[0].split('-') # .split(a):a를 기준으로 가르기
    print('{}\t{}\t{}'.format(*r))

# print('연결')
conn.close()