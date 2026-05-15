#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="zd-oplus-excellence-glyphs"
DIST_DIR="dist"
TMPDIR=$(mktemp -d)
REPO_ROOT="$(pwd)"

mkdir -p "$DIST_DIR"

echo "Building ${THEME_NAME}.zip..."

# Files/dirs to include (copy if present)
INCLUDE=(theme.json shared.css README.md config_USER.json assets)
for f in "${INCLUDE[@]}"; do
  if [ -e "$f" ]; then
    cp -R "$f" "$TMPDIR/"
  fi
done

# Clean unwanted or backup files from copied assets
if [ -d "$TMPDIR/assets" ]; then
  rm -rf "$TMPDIR/assets/backups" || true
  find "$TMPDIR/assets" -name ".DS_Store" -delete || true
  find "$TMPDIR/assets" -type f -iname "*8bitdo*" -delete || true
fi

ZIP_PATH="${REPO_ROOT}/${DIST_DIR}/${THEME_NAME}.zip"
pushd "$TMPDIR" > /dev/null
zip -r "$ZIP_PATH" ./* > /dev/null
popd > /dev/null

rm -rf "$TMPDIR"

echo "Wrote ${ZIP_PATH}"

# Unpack the freshly created zip into dist/${THEME_NAME} for inspection
unzip -o "$ZIP_PATH" -d "${DIST_DIR}/${THEME_NAME}" >/dev/null || true

if [ "${1:-}" = "--deploy" ]; then
  THEMES_DIR="$HOME/homebrew/themes"
  mkdir -p "$THEMES_DIR"
  echo "Deploying to ${THEMES_DIR} (unzipping into folder named ${THEME_NAME})..."
  unzip -o "${DIST_DIR}/${THEME_NAME}.zip" -d "${THEMES_DIR}/${THEME_NAME}" >/dev/null
  echo "Deployed to ${THEMES_DIR}/${THEME_NAME}"
fi

echo "Done. Use './scripts/package_theme.sh --deploy' to also deploy locally."
