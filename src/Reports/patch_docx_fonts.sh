#!/bin/bash
# Patches all Word layout (.docx) reports to use Maiandra GD at 8pt.
# Run from the root of your reports folder.
# Always run on a clean branch or backup first.
#
# Font size in Word XML is in half-points, so 8pt = 16 (w:sz) and 16 (w:szCs).
# w:ascii  = Latin characters
# w:hAnsi  = high-ANSI characters
# w:cs     = complex script (Arabic, Hebrew, etc.)
# w:eastAsia = East Asian characters
# All four are set to ensure no character slips through using a different font.

FONT="Maiandra GD"
HALF_PT="16"   # 8pt × 2 = 16 in Word's half-point unit
DRY_RUN=false

if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "=== DRY RUN — no files will be modified ==="
fi

find . -type f -name "*.docx" | while read -r docx; do
    tmpdir=$(mktemp -d)

    cp "$docx" "$tmpdir/original.docx"
    unzip -q "$tmpdir/original.docx" -d "$tmpdir/extracted"

    if $DRY_RUN; then
        echo "--- $docx ---"
        grep -rn 'w:ascii\|w:sz[^C]\|w:szCs' "$tmpdir/extracted/word/" | head -20
        rm -rf "$tmpdir"
        continue
    fi

    # Patch font name across all XML files in the word/ folder.
    # document.xml carries body text, styles.xml carries named styles,
    # header/footer XMLs carry those sections — all must be patched.
    find "$tmpdir/extracted/word" -name "*.xml" | xargs sed -i \
        's|w:ascii="[^"]*"|w:ascii="'"$FONT"'"|g;
         s|w:hAnsi="[^"]*"|w:hAnsi="'"$FONT"'"|g;
         s|w:cs="[^"]*"|w:cs="'"$FONT"'"|g;
         s|w:eastAsia="[^"]*"|w:eastAsia="'"$FONT"'"|g;
         s|w:sz w:val="[^"]*"|w:sz w:val="'"$HALF_PT"'"|g;
         s|w:szCs w:val="[^"]*"|w:szCs w:val="'"$HALF_PT"'"|g'

    # Patch the theme file too — reports using majorHAnsi/minorHAnsi
    # theme references will otherwise ignore the above changes entirely.
    THEME="$tmpdir/extracted/word/theme/theme1.xml"
    if [[ -f "$THEME" ]]; then
        sed -i \
            's|<a:latin typeface="[^"]*"|<a:latin typeface="'"$FONT"'"|g;
             s|<a:ea typeface="[^"]*"|<a:ea typeface="'"$FONT"'"|g;
             s|<a:cs typeface="[^"]*"|<a:cs typeface="'"$FONT"'"|g' \
            "$THEME"
    fi

    # Repack — zip must be run from inside extracted/ so paths inside the
    # archive are relative (Word rejects absolute paths on open).
    (cd "$tmpdir/extracted" && zip -qr "$tmpdir/patched.docx" .)

    cp "$tmpdir/patched.docx" "$docx"
    rm -rf "$tmpdir"

    echo "Patched: $docx"
done

echo "Done."
