/*
### 문제: [프로그래머스] 과일로 만든 아이스크림 고르기 (Level 1)
### 링크: https://school.programmers.co.kr/learn/courses/30/lessons/133025

1. 문제 설명
   - 찾고자 하는 조건에 부합하는 아이스크림의 맛을 출력한다.
   - 조건 1: 상반기 아이스크림 총주문량이 3,000보다 높은 맛.
   - 조건 2: 아이스크림의 주성분이 과일.
   - 조건 3: 총 주문량이 큰 순서대로 조회.

2. Input (데이터 스키마)
   #1
   - FIRST_HALF 테이블
   - 주요 컬럼: SHIPMENT_ID, VLAVOR, TOTAL_ORDER
   #2
   - ICECREAM_INFO 테이블
   - 주요 컬럼: FLAVOR, INGREDIENT_TYPE

3. 나의 풀이 전략
   - Lookup Join 수행: 주문 실적 테이블('FIRST_HALF')와 마스터 속성 테이블('ICECREAM_INFO')를 'FLAVOR' 기준으로 `INNER_JOIN` 수행.
   - 교차 필터링 및 정렬: 서로 다른 테이블에 존재하는 조건(총주문량 > 3000, 성분 = fruit_based)를 동시 만족하는 행을 필터링하고 총주문량 기준 내림차순 정렬.

4. 배운 점 / 느낀 점
   - 테이블 역할의 이해: 실적 테이블과 마스터 테이블을 조인하여 원천 데이터 속성을 확장하는 기본적인 데이터 결합 방식을 익혔습니다.
   - 컬럼 네임스페이스: 동일한 `FLAVOR` 컬럼을 조인 조건으로 삼을 때 테이블 별칭('F.', 'I.')을 명시하여 쿼리의 명확성을 높였습니다.

5. 리팩토링 및 성능 최적화 (Deep Dive)
   - 테이블 구조: 본 쿼리는 1:1 대응에 가까운 Lookup Join 구조. 실무 대용량 데이터 환경에서는 자주 변하지 않는 차원 테이블인 `ICECREAM_INFO`를 메모리에 캐싱(Brodcast Join 등)하는 방식으로 쿼리 성능을 획기적으로 향상시킬 수 있음.
   - 인덱스 전략: 대규모 조회 성능 향상을 위해 자주 필터링되는 'TOTAL_ORDER' 컬럼이나 조인 키가 되는 'FLAVOR' 컬럼에 인덱스가 적절히 구성되어 있는지 확인하는 과정이 중요.
*/

-- 최종 쿼리
SELECT F.FLAVOR
FROM FIRST_HALF AS F 
INNER JOIN ICECREAM_INFO AS I
    ON F.FLAVOR = I.FLAVOR
WHERE F.TOTAL_ORDER > 3000 
  AND I.INGREDIENT_TYPE = 'fruit_based'
ORDER BY F.TOTAL_ORDER DESC;
