import oracledb

def getConnection():
    return oracledb.connect(user='ora_user',password='1111',dsn='localhost:1521/xe')
# conn=getConnection()
# cursor=conn.cursor()
# query="select to_char(salary,'999,999'), to_char(salary*12,'999,999'),\
#     to_char(salary*12*1465,'999,999,999') from employees"
# cursor.execute(query)
# rows=cursor.fetchall()

### ex)stuscore에서 입력값보다 total이 높은 사람
while True:
    score=int(input('점수를 입력하시오>>'))
    conn=getConnection()
    cursor=conn.cursor()
    query=f"select count(*) from stuscore where total>={score}"
    cursor.execute(query)
    rows=cursor.fetchall()
    # 입력점수보다 합계점수가 높은 사람이 몇명인지 출력
    # stuscore의 total
    print(rows)
    print('입력 :',score)
    print('입력한 점수보다 높은 학생수 :',rows[0][0])

    conn.close()





# # ex)월급 년봉 원화(1464) 천단위
# print('{}\t{}\t{}'.format('월급(달러)','연봉(달러)','연봉(원)'))
# print('-'*45)
# for row in rows:
#     print('{}\t{}\t{}'.format(*row))
    
# conn.close()