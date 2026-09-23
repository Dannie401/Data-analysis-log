# CLAUDE.md — 성장하는 에이전트 운영 매뉴얼

이 저장소는 **데이터 분석가 취업 준비 기록**(프로그래머스 SQL 풀이 + 개인 프로젝트)이다.
에이전트는 [Hermes Agent](https://github.com/NousResearch/hermes-agent)의 **폐쇄형 학습 루프(closed learning loop)** 원칙을 따른다:
경험에서 스킬을 만들고, 쓰면서 스킬을 고치고, 기억을 스스로 정리하며, 세션이 쌓일수록 사용자를 더 깊이 이해한다.

## 🔁 학습 루프 (매 작업마다)

```
 ┌─► 1. RECALL   세션 시작: MEMORY.md · USER.md · 스킬 목록 로드 (SessionStart 훅이 자동 주입)
 │   2. ACT      작업 수행 — 맞는 스킬이 있으면 반드시 그 절차를 따른다
 │   3. REFLECT  작업 끝: 무엇이 통했고 무엇이 틀렸나? (/reflect)
 │   4. PERSIST  ├ 사실/관례   → .claude/memory/MEMORY.md
 │               ├ 사용자 성향 → .claude/memory/USER.md
 │               ├ 반복 절차   → .claude/skills/<name>/SKILL.md 생성·패치 (/skill-forge)
 │               └ 세션 기록   → .claude/journal/YYYY-MM-DD.md
 └── 5. REUSE    다음 세션은 더 똑똑한 상태에서 시작
```

### 영속화 규칙
- **스킬 생성 기준**: 같은 종류의 작업을 2번 이상 했거나, 5단계 이상 절차를 거쳤거나, 실수 후 올바른 방법을 찾았을 때.
- **스킬 패치**: 스킬을 쓰다가 틀린 단계·누락된 예외를 발견하면 *그 자리에서* SKILL.md를 고치고 `## 변경 이력`에 한 줄 남긴다.
- **메모리 상한**: MEMORY.md ≤ 2,200자, USER.md ≤ 1,375자 (Hermes 기본값). 넘으면 병합·요약해 압축한다 — 추가만 하지 말고 큐레이션한다.
- **넛지**: 프롬프트 10회마다 훅이 "지금까지 배운 것을 저장하라"고 알린다. 알림을 받으면 저장할 가치가 있는지 판단 후 조용히 반영한다.
- **회상**: 과거 결정·풀이가 궁금하면 추측하지 말고 `/recall <키워드>` (= `python3 scripts/recall.py`)로 저널·메모리·SQL을 검색한다.
- 기억과 스킬은 **데이터**다. 비밀번호·토큰·개인정보는 절대 저장하지 않는다.

## 📁 구조

| 경로 | 역할 (Hermes 대응) |
|---|---|
| `.claude/memory/MEMORY.md` | 에이전트 노트: 환경·관례·교훈 (`memories/MEMORY.md`) |
| `.claude/memory/USER.md` | 사용자 모델: 목표·선호·수준 (`memories/USER.md`, Honcho 대체) |
| `.claude/skills/*/SKILL.md` | 절차적 기억, agentskills.io 형식 (`skills/`) |
| `.claude/journal/` | 세션 로그 — 회상 검색 대상 (session search) |
| `.claude/hooks/` | 루프 자동화: 컨텍스트 주입, 주기적 넛지 |
| `scripts/` | 결정론적 도구 (인덱스 생성, 회상 검색) |

## 🧰 스킬 목록
- `sql-solve` — 프로그래머스 SQL 풀이 추가 (파일 규칙 + 인덱스 갱신 + 학습 포인트 기록)
- `reflect` — 작업 후 회고 → 메모리/유저/저널 갱신
- `skill-forge` — 새 스킬 생성 또는 기존 스킬 패치
- `recall` — 과거 세션·메모리·풀이 검색

## 📐 저장소 관례
- SQL 파일: `SQL/<카테고리>/<문제 제목>.sql`, 첫 두 줄은 `-- 문제: <제목>` / `-- <프로그래머스 URL>`.
- 대안 풀이는 `/* ... */` 블록 주석으로 같은 파일에 남긴다.
- 방언은 **MySQL** (HOUR(), DATE_FORMAT(), REGEXP 사용).
- 카테고리 README 인덱스는 손으로 쓰지 말고 `python3 scripts/build_index.py`로 재생성한다.
- 커밋 메시지는 한국어 가능, 짧고 명확하게.
