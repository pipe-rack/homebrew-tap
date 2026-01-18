#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PIPERACK_DIR="${PIPERACK_DIR:-$ROOT/../piperack}"
PIPERACK_DIR="$(cd "$PIPERACK_DIR" && pwd)"
CARGO_TOML="$PIPERACK_DIR/Cargo.toml"
FORMULA="$ROOT/Formula/piperack.rb"
SHA_DIR="${SHA_DIR:-}"

if [[ ! -f "$CARGO_TOML" ]]; then
  echo "Cargo.toml not found at $CARGO_TOML" >&2
  exit 1
fi

if [[ ! -f "$FORMULA" ]]; then
  echo "Formula not found at $FORMULA" >&2
  exit 1
fi

version="$(
CARGO_TOML="$CARGO_TOML" python3 - <<'PY'
import os
import re
from pathlib import Path

path = Path(os.environ["CARGO_TOML"])
text = path.read_text()

in_package = False
version = None
for line in text.splitlines():
    if line.strip().startswith("["):
        in_package = line.strip() == "[package]"
        continue
    if in_package:
        m = re.match(r"\s*version\s*=\s*\"([^\"]+)\"", line)
        if m:
            version = m.group(1)
            break

if not version:
    raise SystemExit("Could not find [package] version in Cargo.toml")

print(version)
PY
)"

VERSION="$version" FORMULA="$FORMULA" SHA_DIR="$SHA_DIR" python3 - <<'PY'
import os
import re
from pathlib import Path

version = os.environ["VERSION"]
formula_path = Path(os.environ["FORMULA"])
sha_dir = os.environ.get("SHA_DIR", "").strip()
text = formula_path.read_text()

text, n_ver = re.subn(r"(^\s*version\s+\")([^\"]+)(\")", rf"\1{version}\3", text, flags=re.M)
if n_ver == 0:
    raise SystemExit("Failed to update version in formula")

# Update download URLs to the new tag/version
text = re.sub(r"/download/v[^/]+/", f"/download/v{version}/", text)
text = re.sub(r"piperack-v[^-]+-", f"piperack-v{version}-", text)

if sha_dir:
    sha_root = Path(sha_dir)
    if not sha_root.exists():
        raise SystemExit(f"SHA_DIR does not exist: {sha_dir}")

    targets = [
        "aarch64-apple-darwin",
        "x86_64-apple-darwin",
        "aarch64-unknown-linux-gnu",
        "x86_64-unknown-linux-gnu",
    ]
    sha_map = {}
    for target in targets:
        pattern = f"piperack-v{version}-{target}.tar.gz.sha256"
        matches = list(sha_root.rglob(pattern))
        if not matches:
            raise SystemExit(f"Missing sha256 for {target} (expected {pattern})")
        sha = matches[0].read_text().strip().split()[0]
        sha_map[target] = sha

    lines = text.splitlines()
    for i, line in enumerate(lines):
        if "url " not in line:
            continue
        m = re.search(r"piperack-v[^-]+-([^.]+)\.tar\.gz", line)
        if not m:
            continue
        target = m.group(1)
        if target not in sha_map:
            continue
        for j in range(i + 1, min(i + 4, len(lines))):
            if re.match(r"\s*sha256\s+\"[^\"]*\"", lines[j]):
                lines[j] = re.sub(
                    r"(\s*sha256\s+\")[^\"]*(\")",
                    rf"\1{sha_map[target]}\2",
                    lines[j],
                )
                break
        else:
            raise SystemExit(f"Failed to find sha256 line for {target}")

    text = "\n".join(lines) + "\n"

formula_path.write_text(text)
PY

echo "Updated formula to version $version"
