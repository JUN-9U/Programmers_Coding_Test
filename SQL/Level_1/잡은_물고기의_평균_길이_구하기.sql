/*
### 문제: [프로그래머스] 잡은 물고기의 평균 길이 구하기 (Level 1)
### 링크: https://school.programmers.co.kr/learn/courses/30/lessons/293259

1. 문제 설명
   - 잡은 물고기의 평균 길이를 출력하는 쿼리를 작성한다.
   - 조건 1: 평균 길이를 나타내는 컬럼 명은 AVERAGE_LENGTH로 출력.
   - 조건 2: 평균 길이는 소수점 3째자리에서 반올림.
   - 조건 3: 10cm 이하의 물고기들은 10cm로 취급하여 구하기.

2. Input (데이터 스키마)
   - FISH_INFO 테이블
   - 주요 컬럼: ID, FISH_TYPE, LENGTH, TIME

3. 나의 풀이 전략
   - 'IFNULL(LENGTH, 10)'을 사용하여 길이가 NULL인 데이터를 10으로 치환.
   - 'AVG()' 함수를 사용하여 값들의 평균을 계산.
   - 'ROUND()' 함수를 사용하여 최종 값의 소수점 둘째 자리까지 반올림.

4. 배운 점 / 느낀 점
   - 집계 함수(`AVG`)는 기본적으로 NULL을 무시하지만, 비즈니스 요구사항에 따라 NULL을 특정 값으로 포함시켜야 할 때 `IFNULL`의 중요성을 익혔습니다.
   - 함수를 중첩(`ROUND(AVG(IFNULL(...)))`)하여 데이터 처리 단계를 논리적으로 구성하는 법을 연습했습니다.

5. 리팩토링 및 성능 최적화 (Deep Dive)
   - **함수 선택**: `IFNULL`은 MySQL 전용이며, 표준 SQL인 `COALESCE`를 사용하면 다른 DB 환경(BigQuery, PostgreSQL 등)에서도 동일하게 작동하여 이식성이 높아집니다.
*/

-- 최종 쿼리
SELECT ROUND(AVG(IFNULL(LENGTH, 10)), 2) AS AVERAGE_LENGTH
FROM FISH_INFO;
