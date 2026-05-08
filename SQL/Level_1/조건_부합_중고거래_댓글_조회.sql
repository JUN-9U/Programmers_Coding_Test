/*
### 문제: [프로그래머스] 조건에 부합하는 중고거래 댓글 조회하기 (Level 1)
### 링크: https://school.programmers.co.kr/learn/courses/30/lessons/164673

1. 문제 설명
   - 찾고자 하는 조건에 부합하는 댓글들을 출력한다.
   - 조건 1: 'USDED_GOODS_BOARD'와 'USED_GOOD_REPLY' 테이블에서 댓글을 조회하는 쿼리 작성.
   - 조건 2: 2022년 10월에 작성된 게시글을 조회.
   - 조건 3: 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회하는 쿼리 작성.
   - 조건 4: 결과는 댓글 작성일 기준으로 오름차순, 댓글 작성일이 같다면 게시글 제목 기준으로 오름차순 정렬.

2. Input (데이터 스키마)
   #1
   - USED_GOOD_BOARD 테이블
   - 주요 컬럼: BOARD_ID, WRITER_ID, TITLE, CONTENTS, CREATED_DATE, STATUS
   #2
   - USED_GOODS_REPLY 테이블
   - 주요 컬럼: REPLY_ID, BOARD_ID, WRITER_ID, CONTENTS, CREATED_DATE

3. 나의 풀이 전략
   - **데이터 결합**: 게시글(`USED_GOODS_BOARD`)과 댓글(`USED_GOODS_REPLY`) 테이블을 `BOARD_ID`를 외래키로 활용하여 `INNER_JOIN`을 수행.
   - **조건 필터링**: `YEAR()`와 `MONTH()` 함수를 사용하여 2022년 10월에 작성된 **게시글** 데이터를 추출.
   - **데이터 정렬**: 다중 정렬(`ORDER_BY B.CREATED_DATE ASC, A.TITLE ASC`)을 통해 조건에 부합하는 데이터 순서를 정렬.

4. 배운 점 / 느낀 점
   - **컬럼 식별의 중요성**: 조인된 두 테이블에 동일한 이름의 컬럼(ex. CREATED_DATE)이 있을 때, 어떤 테이블의 컬럼을 필터링 기준으로 삼고 어떤 컬럼을 최종 출력할지 명확하게 구분하는 쿼리 설계의 중요성을 배웠습니다.
   - **날짜 데이터 처리**: `YEAR()`, `MONTH()` 함수를 활용한 직관적인 필터링 방식에 익숙해졌으며, 대규모 데이터셋에서 이를 더 효율적으로 개선할 수 있는 범위 연산자 사용법에 대해서도 고민해보는 계기가 되었습니다.

5. 리팩토링 및 성능 최적화 (Deep Dive)
   - **인덱스 스캔 효율성**: 현재 `YEAR()`, `MONTH()` 함수를 사용하여 필터링 했으나, 대규모 데이터셋에서는 인덱스 활용을 위해 `A.CREATED_DATE BETWEEN '2022-10-01' AND '2022-10-32'`와 같이 범위 기반 연산자로 리펙토링하는 것이 쿼리 성능 면에서 더 유리.
   - **날짜 포맷팅**: 실무에서는 결과값의 가독성을 위해 `DATE_FORMAT(B.CREATED_DATE, '%Y-%m-%d')` 처리를 통해 시간 정보를 제외한 날짜 정보만 명확히 전달하는 전처리가 권장.
*/

-- 최종 쿼리
/*방법 1*/
SELECT A.TITLE, 
  A.BOARD_ID, 
  B.REPLY_ID, 
  B.WRITER_ID, 
  B.CONTENTS, 
  B.CREATED_DATE
FROM USED_GOODS_BOARD AS A 
    INNER JOIN USED_GOODS_REPLY AS B
    ON A.BOARD_ID = B.BOARD_ID
WHERE (YEAR(A.CREATED_DATE) = 2022) AND (MONTH(A.CREATED_DATE) = 10)
ORDER BY B.CREATED_DATE ASC, A.TITLE ASC;

/*
방법 2
SELECT 
    A.TITLE, 
    A.BOARD_ID, 
    B.REPLY_ID, 
    B.WRITER_ID, 
    B.CONTENTS, 
    DATE_FORMAT(B.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
FROM USED_GOODS_BOARD AS A 
INNER JOIN USED_GOODS_REPLY AS B 
    ON A.BOARD_ID = B.BOARD_ID
WHERE A.CREATED_DATE >= '2022-10-01' AND A.CREATED_DATE < '2022-11-01'
ORDER BY B.CREATED_DATE ASC, A.TITLE ASC;
*/
