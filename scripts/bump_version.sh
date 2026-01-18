#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PIPERACK_DIR="$(cd "$ROOT/../piperack" && pwd)"
CARGO_TOML="$PIPERACK_DIR/Cargo.toml"

part="${1:-patch}"
if [[ "$part" != "major" && "$part" != "minor" && "$part" != "patch" ]]; then
  echo "Usage: $0 [major|minor|patch]" >&2
  exit 1
fi

if [[ ! -f "$CARGO_TOML" ]]; then
  echo "Cargo.toml not found at $CARGO_TOML" >&2
  exit 1
fi

CARGO_TOML="$CARGO_TOML" PART="$part" python3 - <<'PY'
import os
import re
from pathlib import Path

path = Path(os.environ["CARGO_TOML"])
part = os.environ["PART"]
text = path.read_text()

lines = text.splitlines()
in_package = False
version_line_index = None
current = None

for i, line in enumerate(lines):
    if line.strip().startswith("["):
        in_package = line.strip() == "[package]"
        continue
    if in_package:
        m = re.match(r"(\s*version\s*=\s*\")([^\"]+)(\")", line)
        if m:
            version_line_index = i
            current = m.group(2)
            break

if current is None:
    raise SystemExit("Could not find [package] version in Cargo.toml")

parts = current.split(".")
if len(parts) != 3 or not all(p.isdigit() for p in parts):
    raise SystemExit(f"Version '{current}' is not a simple semver X.Y.Z")

major, minor, patch = map(int, parts)
if part == "major":
    major += 1
    minor = 0
    patch = 0
elif part == "minor":
    minor += 1
    patch = 0
else:
    patch += 1

new_version = f"{major}.{minor}.{patch}"

m = re.match(r"(\s*version\s*=\s*\")([^\"]+)(\")", lines[version_line_index])
lines[version_line_index] = f"{m.group(1)}{new_version}{m.group(3)}"

path.write_text("\n".join(lines) + "\n")
print(new_version)
PY

"$ROOT/scripts/update_formula.sh"
