#!/usr/bin/env python3
"""SQL/<카테고리>/README.md 인덱스를 .sql 파일 헤더에서 재생성한다."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent / "SQL"
TITLE_RE = re.compile(r"^--\s*문제:\s*(.+)$")
URL_RE = re.compile(r"^--\s*(https?://\S+)")


def parse(path: Path):
    title, url = path.stem, None
    for line in path.read_text(encoding="utf-8").splitlines()[:5]:
        if m := TITLE_RE.match(line.strip()):
            title = m.group(1).strip()
        elif m := URL_RE.match(line.strip()):
            url = m.group(1)
    return title, url


def main():
    for cat in sorted(p for p in ROOT.iterdir() if p.is_dir() and p.name != "projects"):
        files = sorted(cat.glob("*.sql"))
        name = cat.name.strip()
        lines = [f"# {name}", "", f"풀이 {len(files)}개 · `scripts/build_index.py`로 자동 생성", ""]
        if files:
            lines += ["| 문제 | 풀이 |", "|---|---|"]
            for f in files:
                title, url = parse(f)
                link = f"[{title}]({url})" if url else title
                lines.append(f"| {link} | [{f.name}](<{f.name}>) |")
        else:
            lines.append("_아직 풀이 없음_")
        (cat / "README.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
        print(f"{name}: {len(files)}")


if __name__ == "__main__":
    main()
