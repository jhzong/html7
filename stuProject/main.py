from stuConnect import*
from stuFunc import*

while True:
    print('[학생성적프로그램]')
    print('-'*30)
    print('1.성적입력')
    print('2.성적출력')
    print('3.성적수정')
    print('4.성적삭제')
    print('5.성적검색')
    print('6.학생정렬')
    print('7.등수처리')
    print('8.등급처리')
    print('0.프로그램종료')
    choice=int(input('수행업무 선택>>'))
    if choice==1:# 성적입력
        stuInput()
    elif choice==2:# 성적출력
        stuPrint()
    elif choice==3:# 성적수정
        pass
    elif choice==4:# 성적삭제
        stuDelete()
    elif choice==5:# 성적검색
        pass
    elif choice==6:# 학생정렬
        pass
    elif choice==7:# 등수처리
        pass
    else:
        print('((프로그램종료))')
        break