#!/usr/bin/env bash
# UserPromptSubmit: N번째 프롬프트마다 영속화 넛지 (Hermes의 periodic memory nudge).
INTERVAL="${CLAUDE_NUDGE_INTERVAL:-10}"
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}" || exit 0
C="${TMPDIR:-/tmp}/claude-nudge-$(echo "$PWD" | md5sum | cut -c1-8)"
n=$(( $(cat "$C" 2>/dev/null || echo 0) + 1 ))
echo "$n" > "$C"
if [ $(( n % INTERVAL )) -eq 0 ]; then
  echo "🔁 [학습 루프 넛지] 프롬프트 ${n}회째. 이번 요청을 처리한 뒤, 지금까지 세션에서 저장할 가치가 있는 사실·사용자 성향·반복 절차가 있는지 판단하고 있다면 reflect 스킬로 조용히 영속화하라."
fi
exit 0
