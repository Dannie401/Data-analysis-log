#!/usr/bin/env bash
# SessionStart: 학습 루프 1단계(RECALL) — 메모리·사용자 모델·스킬 목록을 컨텍스트에 주입한다.
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}" || exit 0
MEM=.claude/memory

echo "=== 🧠 폐쇄형 학습 루프: 세션 컨텍스트 ==="
for f in MEMORY USER; do
  [ -f "$MEM/$f.md" ] || continue
  echo; cat "$MEM/$f.md"
done

# 상한 초과 경고 (Hermes 기본 한도)
warn() { local n; n=$(wc -m < "$1"); [ "$n" -gt "$2" ] && echo "⚠️ $1 이 ${n}자 (상한 $2) — /reflect 로 압축하라."; }
[ -f "$MEM/MEMORY.md" ] && warn "$MEM/MEMORY.md" 2200
[ -f "$MEM/USER.md" ] && warn "$MEM/USER.md" 1375

echo; echo "## 사용 가능한 스킬"
for s in .claude/skills/*/SKILL.md; do
  [ -f "$s" ] || continue
  d=$(grep -m1 '^description:' "$s" | sed 's/^description: *//')
  echo "- $(basename "$(dirname "$s")"): $d"
done

last=$(ls .claude/journal/20*.md 2>/dev/null | tail -1)
if [ -n "$last" ]; then
  echo; echo "## 최근 저널 ($last)"; tail -n 12 "$last"
fi

# 넛지 카운터 초기화
rm -f "${TMPDIR:-/tmp}/claude-nudge-$(echo "$PWD" | md5sum | cut -c1-8)"
exit 0
