# 문제 : [프로그래머스] 문자열 붙여서 출력하기 (Level 0)
# 링크 : https://school.programmers.co.kr/learn/courses/30/lessons/181946

"""
### 1. 문제 설명
두 개의 문자열 str1, str2가 공백으로 구분되어 주어집니다. 
입력받은 두 문자열을 공백 없이 붙여서 출력하는 프로그램을 작성하세요.
- 입출력 예
- 입력 1: apple pen / 입력 2: Hello World!
- 출력 1: applepen / 출력 2: HelloWorld!
  
### 2. 나의 풀이 전략
- 파이썬의 input().split()을 활용해 공백을 기준으로 두 문자열을 분리합니다.
- 분리된 두 문자열을 + 연산자를 이용해 결합하거나, print() 함수의 sep 옵션을 활용합니다.
- 문자열 결합 시 추가적인 공백이 생기지 않도록 주의합니다.

### 3. 배운 점 / 느낀 점
- input().split()이 반환하는 리스트 형태를 활용하는 법을 익혔습니다.
- print(s1, s2, sep="")와 같이 sep 옵션을 빈 문자열로 설정하면 별도의 결합 없이도 붙여서 출력이 가능하다는 점을 배웠습니다.
"""

# 방법 1: 문자열 더하기 활용
str1, str2 = input().strip().split(' ')
print(str1 + str2)

# 방법 2: print() 함수의 sep 옵션 활용
# print(str1, str2, sep="")
