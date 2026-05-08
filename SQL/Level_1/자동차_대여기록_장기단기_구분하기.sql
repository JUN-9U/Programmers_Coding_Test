/*

### 문제: [프로그래머스] 자동차 대여 기록에서 장기/단기 대여 구분하기 (Level 1)

### 링크: https://school.programmers.co.kr/learn/courses/30/lessons/151138

1. 문제 설명
    - 자동차 대여 기록 중, 장기/단기 대여를 구분하는 컬럼을 추가하고, 조건에 부합하는 결과 출력하기.
    - 조건 1: 대여 시작일이 2022년 9월에 속하는 기록 출력.
    - 조건 2: 30일을 기준으로 '장기 대여'와 '단기 대여'를 구분하는 컬럼 추가하여 출력.
    - 조건 3: 결과는 대여 기록 ID를 기준으로 내림차순 정렬.
2. Input (데이터 스키마)
    - CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블
    - 주요 컬럼: HISTORY_ID, CAR_ID, START_DATE, END_DATE
3. 나의 풀이 전략
    - `CASE WHEN` 문을 활용하여 보정된 대여 기간이 30일 이상인 경우 '장기 대여', 미만일 경우 '단기 대여'로 라벨링하는 `RENT_TYPE` 컬럼을 생성.
    - 대여 종료일과 시작일의 차이를 구하는 `DATEDIFF` 함수를 사용. 이 때, 당일 대여 및 반납을 1일로 간주하는 비즈니스 로직을 반영하가 위해 결과값에 +1을 보정.
    - `WHERE` 절에서 `YEAR()`와 `MONTH()` 함수를 사용하여 2022년 8월에 시작된 대여 기록만 추출.
4. 배운 점 / 느낀 점
    - 단순히 두 날짜를 빼는 것과 `DATEDIFF` 함수를 사용하는 것의 차이를 이해했습니다. 특히 시작일을 포함하는 폐구간 계산 시 +1 처리가 데이터의 정확성을 결정짓는다는 점을 깨달았습니다.
    - 날짜 타입에 직접적인 산술 연산을 적용할 때 발생할 수 있는 '숫자형 변환 오류(월 전환 시 오차)'를 인지하고, 전용 함수의 필요성을 체감했습니다.
    - `CASE WHEN` 문법을 활용해 연속형 데이터를 비즈니스 기준에 맞게 범주형 데이터로 변환하는 법을 익혔으며, 조건문의 마무리를 짓는 `END` 명시 등 문법적 완결성의 중요성을 확인했습니다.
5. 리팩토링 및 성능 최적화 (Deep Dive)
    - **날짜 연산의 함정**: SQL에서 `DATE - DATE`를 수행하면 `YYYYMMDD` 형태의 정수로 변환되어 계산됨. 예를 들어 (20221001)에서 (20220930)을 빼면 실제 차이는 1이지만 결과값은 71이 도출. 따라서 날짜 간격을 구할 때는 반드시 `DATEDIFF()`를 사용.
    - **인덱스 가동성**: `YEAR()`, `MONTH()` 함수를 사용하면 인덱스 효율이 낮을 수 있음. 대규모 데이터셋에서는 `START_DATE >= '2022-09-01' AND START_DATE < '2022-10-01'와 같이 범위 기반 필터링을 적용하여 인덱스 풀 스캔을 방지하는 리펙토링 가능.
    - **출력 정규화**: 실제 코딩 테스트 황경에서는 날짜 포맷 규격이 중요하므로, `DATE_FORMAT(START_DATE, '%Y-%m-%d')`처리를 통해 시/분/초를 제거한 표준화된 데이터를 전달하는 것이 좋음.
    */
- - 최종 쿼리
SELECT HISTORY_ID, 
    CAR_ID, 
    START_DATE, 
    END_DATE, 
    CASE WHEN DATEDIFF(END_DATE, START_DATE)+1 >= 30 THEN '장기 대여'
    ELSE '단기 대여'
    END AS RENT_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE YEAR(START_DATE) = 2022 AND MONTH(START_DATE) = 9
ORDER BY HISTORY_ID DESC;

/*
최적화 쿼리
SELECT 
    HISTORY_ID, 
    CAR_ID, 
    -- 출력 포맷 정규화 (시분초 제거)
    DATE_FORMAT(START_DATE, '%Y-%m-%d') AS START_DATE, 
    DATE_FORMAT(END_DATE, '%Y-%m-%d') AS END_DATE, 
    CASE 
        WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 30 THEN '장기 대여'
        ELSE '단기 대여'
    END AS RENT_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
-- [최적화 포인트] 함수 대신 범위 연산자 사용 (Sargable Query)
WHERE START_DATE >= '2022-09-01' AND START_DATE < '2022-10-01'
ORDER BY HISTORY_ID DESC;
*/
