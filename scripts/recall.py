#!/usr/bin/env python3
"""저널·메모리·스킬·SQL 풀이를 키워드로 검색한다 (Hermes session search 대응).

사용: python3 scripts/recall.py <키워드...> [--sql | --journal]
모든 키워드가 들어간 줄만 출력(AND, 대소문자 무시).
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SCOPES = {
    "--journal": [".claude/journal"],
    "--sql": ["SQL"],
}
DEFAULT = [".claude/journal", ".claude/memory", ".claude/skills", "SQL"]


def main(argv):
    flags = [a for a in argv if a.startswith("--")]
    terms = [a.lower() for a in argv if not a.startswith("--")]
    if not terms:
        print(__doc__)
        return 1
    dirs = [d for f in flags for d in SCOPES.get(f, [])] or DEFAULT
    hits = 0
    for d in dirs:
        for path in sorted((ROOT / d).rglob("*")):
            if path.suffix not in {".md", ".sql"} or not path.is_file():
                continue
            lines = path.read_text(encoding="utf-8", errors="ignore").splitlines()
            matched = [(i, l) for i, l in enumerate(lines, 1) if all(t in l.lower() for t in terms)]
            if matched:
                print(f"\n{path.relative_to(ROOT)}")
                for i, l in matched[:8]:
                    print(f"  {i:>4}: {l.strip()}")
                hits += len(matched)
    print(f"\n— {hits}건" if hits else "일치 없음")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
