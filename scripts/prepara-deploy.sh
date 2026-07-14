#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Ús:
  scripts/prepara-deploy.sh
  scripts/prepara-deploy.sh --check [DESTÍ]
  scripts/prepara-deploy.sh --prepare-new DESTÍ

Sense arguments, sincronitza només el destí canònic ../jbv.cat-deploy.
--check compara un destí sense modificar-lo.
--prepare-new permet generar una carpeta alternativa nova o buida, sense --delete.
EOF
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
canonical_target="$(dirname "$repo_root")/jbv.cat-deploy"
mode="canonical"
target="$canonical_target"

absolute_existing_or_parent() {
  local raw="$1"
  local parent base

  if [[ "$raw" != /* ]]; then
    raw="$PWD/$raw"
  fi

  if [[ -d "$raw" ]]; then
    (cd "$raw" && pwd -P)
    return
  fi

  parent="$(dirname "$raw")"
  base="$(basename "$raw")"
  if [[ ! -d "$parent" ]]; then
    echo "ERROR: no existeix el directori pare: $parent" >&2
    return 1
  fi

  parent="$(cd "$parent" && pwd -P)"
  printf '%s/%s\n' "$parent" "$base"
}

case "${1:-}" in
  "")
    ;;
  --check)
    mode="check"
    shift
    if (( $# > 1 )); then
      usage >&2
      exit 2
    fi
    target="${1:-$canonical_target}"
    ;;
  --prepare-new)
    mode="prepare-new"
    shift
    if (( $# != 1 )); then
      usage >&2
      exit 2
    fi
    target="$1"
    ;;
  --help|-h)
    usage
    exit 0
    ;;
  *)
    echo "ERROR: el mode normal només admet el destí canònic" >&2
    usage >&2
    exit 2
    ;;
esac

target="$(absolute_existing_or_parent "$target")"

public_paths=(
  index.html
  privadesa.html
  css
  js
  assets
)

for path in "${public_paths[@]}"; do
  if [[ ! -e "$repo_root/$path" ]]; then
    echo "ERROR: falta el recurs públic $path" >&2
    exit 1
  fi
done

staging="$(mktemp -d)"
trap 'rm -rf "$staging"' EXIT

for path in "${public_paths[@]}"; do
  cp -a "$repo_root/$path" "$staging/"
done

if [[ "$mode" == "check" ]]; then
  if [[ ! -d "$target" ]]; then
    echo "ERROR: no existeix la carpeta de deploy: $target" >&2
    exit 1
  fi

  if diff -qr "$staging" "$target"; then
    echo "OK: el deploy coincideix amb la font pública"
    exit 0
  fi

  echo "ERROR: el deploy no coincideix amb la font pública" >&2
  exit 1
fi

if [[ "$mode" == "prepare-new" ]]; then
  case "$target" in
    /|"$HOME"|"$repo_root"|"$repo_root"/*|"$canonical_target")
      echo "ERROR: destí no segur per a --prepare-new: $target" >&2
      exit 2
      ;;
  esac

  if [[ -e "$target" && ! -d "$target" ]]; then
    echo "ERROR: el destí existeix i no és una carpeta: $target" >&2
    exit 2
  fi

  if [[ -d "$target" ]]; then
    shopt -s dotglob nullglob
    entries=("$target"/*)
    shopt -u dotglob nullglob
    if (( ${#entries[@]} > 0 )); then
      echo "ERROR: --prepare-new requereix una carpeta nova o buida: $target" >&2
      exit 2
    fi
  fi

  mkdir -p "$target"
  rsync -a "$staging/" "$target/"
  echo "OK: deploy nou preparat a $target"
  exit 0
fi

if [[ "$target" != "$canonical_target" ]]; then
  echo "ERROR: la sincronització amb --delete només és permesa al destí canònic" >&2
  exit 2
fi

mkdir -p "$canonical_target"
rsync -a --delete "$staging/" "$canonical_target/"
echo "OK: deploy preparat a $canonical_target"
