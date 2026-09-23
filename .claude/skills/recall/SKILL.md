---
name: recall
description: 과거 세션에서 한 일, 예전 풀이, 이전 결정·교훈을 찾아야 할 때 사용 (Hermes의 session search). 추측하기 전에 먼저 검색한다.
---

# recall

## 절차
1. `python3 scripts/recall.py <키워드> [키워드...]` 실행 — 저널·메모리·스킬·SQL 파일을 대소문자 무시로 검색하고 파일별로 매치 줄을 보여준다.
   - `--sql` : SQL 풀이만 검색 (예: `recall.py HAVING --sql`)
   - `--journal` : 세션 로그만 검색
2. 결과를 요약해 답하고, 출처 파일 경로를 함께 제시.
3. 찾은 내용이 이번 작업에 중요하게 쓰였다면 `reflect`에서 MEMORY로 승격을 고려.

## 변경 이력
- 2026-09-23: 최초 생성.
