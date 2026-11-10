import csv, sys
from pathlib import Path

def main(src: str, dst: str) -> None:
    rows = list(csv.reader(Path(src).open(encoding="utf-8")))
    out = ["| " + " | ".join(rows[0]) + " |", "|" + "---|" * len(rows[0])]
    out += ["| " + " | ".join(r) + " |" for r in rows[1:]]
    Path(dst).parent.mkdir(parents=True, exist_ok=True)
    Path(dst).write_text("\n".join(out), encoding="utf-8")

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
