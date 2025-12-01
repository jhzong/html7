import oracledb
def getConnection():
    return oracledb.connect(user='ora_user',password='1111',dsn='localhost:1521/xe')

# conn=getConnection()
# print('connected',conn)
# conn.close()