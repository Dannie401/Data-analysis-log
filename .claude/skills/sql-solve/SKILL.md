---
name: sql-solve
description: 프로그래머스 SQL 문제 풀이를 저장소에 추가하거나 리뷰할 때 사용. 파일 명명·헤더 규칙을 지키고, 카테고리 README 인덱스를 재생성하고, 학습 포인트를 기록한다.
---

# sql-solve

## 절차
1. **카테고리 결정**: SELECT / SUM_MAX_MIN / GROUP_BY / `  JOIN` / `  SUBQUERY` (앞 공백 2칸 — 경로 따옴표 필수). 애매하면 프로그래머스 Kit 분류를 따른다.
2. **파일 생성**: `SQL/<카테고리>/<문제 제목>.sql`
   - 제목의 `/`는 파일명에서 제거하거나 공백으로 대체 (예: `대여중 / 대여 가능` → `대여 중 대여 가능`).
   - 헤더 2줄:
     ```sql
     -- 문제: <원래 제목 그대로>
     -- https://school.programmers.co.kr/learn/courses/30/lessons/<id>
     ```
3. **본문**: MySQL 문법. 사용자가 준 풀이는 그대로 보존(스타일 수정 금지). 대안 풀이는 `/* */` 블록으로 추가.
4. **리뷰 요청 시**: 정답 여부 → 엣지 케이스(NULL, 동률, 경계값 BETWEEN) → 더 나은 대안 순서로 짧게.
5. **인덱스 갱신**: `python3 scripts/build_index.py`
6. **학습 포인트**: 새로 쓴 함수·패턴(예: REGEXP, HAVING, CASE+MAX)이 있으면 `/reflect`로 MEMORY `## 교훈`이나 저널에 남긴다.
7. 커밋: `Create <문제 제목>.sql`

## 흔한 함정 (MySQL)
- `GROUP BY` 별칭 참조, `HAVING` 별칭 참조는 MySQL에서 허용되지만 다른 DB에선 안 될 수 있음.
- `BETWEEN '2022-05-01' AND '2022-05-31'`은 DATETIME 컬럼이면 31일 00:00 이후를 놓친다 → `DATE_FORMAT`/`LIKE '2022-05%'` 고려.
- 한글 별칭은 따옴표(`'5월예약건수'`)로 감싸기.

## 변경 이력
- 2026-09-23: 최초 생성 (기존 커밋 12건의 패턴에서 추출).
