/*
### 문제: [프로그래머스] Python 개발자 찾기 (Level 1)
### 링크: https://school.programmers.co.kr/learn/courses/30/lessons/276013

1. 문제 설명
   - DEVELOPER_INFOS 테이블에서 Python 스킬을 보유한 개발자의 정보를 조회합니다.
   - 대상 컬럼: SKILL_1, SKILL_2, SKILL_3 중 하나라도 'Python'이 포함된 경우.
   - 출력 컬럼: ID, EMAIL, FIRST_NAME, LAST_NAME
   - 정렬 기준: ID를 기준으로 오름차순(ASC) 정렬.

2. Input (데이터 스키마)
   - DEVELOPER_INFOS 테이블
   - 주요 컬럼: ID (PK), EMAIL, FIRST_NAME, LAST_NAME, SKILL_1, SKILL_2, SKILL_3

3. 나의 풀이 전략
   - Python 스킬이 어떤 컬럼(SKILL_1~3)에 위치할지 알 수 없으므로, 모든 스킬 컬럼에 대해 필터링 조건을 부여합니다.
   - `OR` 연산자를 사용하여 세 조건 중 하나라도 참이면 결과에 포함되도록 설계했습니다.
   - `LIKE '%Python%'`을 사용하여 혹시 모를 문자열 내 포함 여부를 확인했습니다.

4. 배운 점 / 느낀 점
   - 컬럼이 정규화되지 않고 SKILL_1, 2, 3으로 나뉘어 있는 경우, 다소 번거롭더라도 모든 컬럼을 체크해야 함을 배웠습니다.
   - 데이터 분석 실무에서는 이런 비정형적인 컬럼 구조를 만났을 때, `IN` 연산자나 별도의 매핑 테이블을 활용하는 방법도 고려해 볼 수 있을 것 같습니다.

5. 리팩토링 및 성능 최적화 (Deep Dive)
  - 성능: 정규화된 데이터라면 =이 효율적이나, 검색 유연성을 위해 LIKE 선택.  
  - 비용(BigQuery): OR 조건 증가는 스캔 비용을 높이므로, 대용량 처리 시 Unnest 등 구조 최적화 검토 필요.
*/

-- 최종 쿼리
SELECT ID, EMAIL, FIRST_NAME, LAST_NAME
FROM DEVELOPER_INFOS
WHERE SKILL_1 LIKE '%Python%'
   OR SKILL_2 LIKE '%Python%'
   OR SKILL_3 LIKE '%Python%'
ORDER BY ID ASC;
