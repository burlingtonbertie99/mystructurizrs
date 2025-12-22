from pathlib import Path

for svg in Path(".").glob("*.svg"):
    text = svg.read_text(encoding="utf-8")
    text = text.replace(">[Deployment Node]<", "><")
    svg.write_text(text, encoding="utf-8")

