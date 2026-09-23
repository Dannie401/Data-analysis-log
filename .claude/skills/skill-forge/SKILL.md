---
name: skill-forge
description: 반복되는 작업 절차를 새 스킬로 만들거나, 사용 중 결함이 드러난 기존 스킬을 패치할 때 사용 (Hermes의 autonomous skill creation / self-improvement).
---

# skill-forge

## 새 스킬 만들기
생성 기준: 같은 유형 작업 2회 이상 · 5단계 이상 절차 · 시행착오 끝에 찾은 방법 · 사용자가 명시 요청.

1. 이름: 소문자-케밥 (`eda-report`, `sql-review` 등). 기존 스킬과 겹치면 새로 만들지 말고 패치.
2. `.claude/skills/<name>/SKILL.md` 작성:
   ```markdown
   ---
   name: <name>
   description: <언제 쓰는지 — 트리거 상황을 구체적으로>
   ---
   # <name>
   ## 절차
   1. ...
   ## 함정
   ## 변경 이력
   - YYYY-MM-DD: 최초 생성 (<계기>)
   ```
3. 결정론적인 반복 작업(파일 생성, 집계 등)은 `scripts/`에 스크립트로 빼고 스킬에서 호출.
4. CLAUDE.md `## 🧰 스킬 목록`에 한 줄 추가.

## 기존 스킬 패치
1. 틀린 단계는 고치고, 빠진 예외는 `## 함정`에 추가.
2. `## 변경 이력`에 `- 날짜: 무엇을 왜` 한 줄.
3. 한 스킬이 너무 커지면(≈150줄) 분할.

## 변경 이력
- 2026-09-23: 최초 생성.
