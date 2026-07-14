#!/usr/bin/env bash
set -euo pipefail

source_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

sandbox_root="$tmp_dir/sandbox"
repo_root="$sandbox_root/jbv.cat"
canonical_target="$sandbox_root/jbv.cat-deploy"
mkdir -p "$repo_root/scripts"

for path in index.html privadesa.html css js assets; do
  cp -a "$source_root/$path" "$repo_root/"
done
cp -a "$source_root/scripts/prepara-deploy.sh" "$repo_root/scripts/"
script="$repo_root/scripts/prepara-deploy.sh"

# Un destí arbitrari no pot activar mai rsync --delete.
arbitrary="$tmp_dir/directori-arbitrari"
mkdir -p "$arbitrary"
printf 'no esborrar\n' > "$arbitrary/sentinel.txt"
if "$script" "$arbitrary" >/dev/null 2>&1; then
  echo "ERROR: ha acceptat un destí arbitrari en mode normal" >&2
  exit 1
fi
test -f "$arbitrary/sentinel.txt"

# --prepare-new ha d'aplicar la seva pròpia frontera de seguretat.
fake_home="$tmp_dir/home-de-prova"
mkdir -p "$fake_home"
for unsafe in / "$fake_home" "$repo_root" "$repo_root/unsafe-child"; do
  if HOME="$fake_home" "$script" --prepare-new "$unsafe" >/dev/null 2>&1; then
    echo "ERROR: --prepare-new ha acceptat el destí no segur $unsafe" >&2
    exit 1
  fi
done
test ! -e "$repo_root/unsafe-child"

# Espia els arguments reals de rsync per separar els modes destructiu i segur.
real_rsync="$(command -v rsync)"
mock_bin="$tmp_dir/mock-bin"
rsync_log="$tmp_dir/rsync-args.log"
mkdir -p "$mock_bin"
cat > "$mock_bin/rsync" <<'EOF'
#!/usr/bin/env bash
printf '%s\n' "$@" > "$RSYNC_LOG"
exec "$REAL_RSYNC" "$@"
EOF
chmod 755 "$mock_bin/rsync"

# El mode alternatiu només pot inicialitzar una carpeta nova o buida.
new_target="$tmp_dir/deploy-nou"
PATH="$mock_bin:$PATH" REAL_RSYNC="$real_rsync" RSYNC_LOG="$rsync_log" \
  "$script" --prepare-new "$new_target"
test -f "$new_target/index.html"
if grep -Fxq -- '--delete' "$rsync_log"; then
  echo "ERROR: --prepare-new ha invocat rsync amb --delete" >&2
  exit 1
fi
printf 'preservar\n' > "$new_target/sentinel.txt"
if "$script" --prepare-new "$new_target" >/dev/null 2>&1; then
  echo "ERROR: --prepare-new ha acceptat un directori no buit" >&2
  exit 1
fi
test -f "$new_target/sentinel.txt"

# El mode canònic es pot regenerar i elimina només sobrants d'aquest artefacte.
PATH="$mock_bin:$PATH" REAL_RSYNC="$real_rsync" RSYNC_LOG="$rsync_log" "$script"
grep -Fxq -- '--delete' "$rsync_log"
for path in index.html privadesa.html css js assets; do
  test -e "$canonical_target/$path"
done
printf 'sobrant\n' > "$canonical_target/fitxer-sobrant.txt"
"$script"
test ! -e "$canonical_target/fitxer-sobrant.txt"

for path in README.md docs package.json package-lock.json node_modules tests scripts .git; do
  test ! -e "$canonical_target/$path"
done

diff -qr "$repo_root/css" "$canonical_target/css"
diff -qr "$repo_root/js" "$canonical_target/js"
diff -qr "$repo_root/assets" "$canonical_target/assets"
cmp -s "$repo_root/index.html" "$canonical_target/index.html"
cmp -s "$repo_root/privadesa.html" "$canonical_target/privadesa.html"

# --check ha de detectar per separat fitxers sobrants i absents.
"$script" --check
printf 'drift\n' > "$canonical_target/sobrant.txt"
if "$script" --check >/dev/null 2>&1; then
  echo "ERROR: --check no ha detectat un fitxer sobrant" >&2
  exit 1
fi
rm "$canonical_target/sobrant.txt"
rm "$canonical_target/js/projects.js"
if "$script" --check >/dev/null 2>&1; then
  echo "ERROR: --check no ha detectat un fitxer absent" >&2
  exit 1
fi

echo "OK: preparació segura i comprovació del deploy"
