#!/bin/bash
# Patches all RDLC/RDL reports to use Maiandra GD at 8pt.
# Run from the root of your reports folder.
# Always run on a clean branch or backup first.

FONT="Maiandra GD"
SIZE="8pt"
DRY_RUN=false

if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "=== DRY RUN — no files will be modified ==="
fi

find . -type f \( -name "*.rdlc" -o -name "*.rdl" \) | while read -r file; do
    if $DRY_RUN; then
        echo "--- $file ---"
        grep -n "<FontFamily>\|<FontSize>" "$file" | head -20
    else
        sed -i \
            's|<FontFamily>[^<]*</FontFamily>|<FontFamily>'"$FONT"'</FontFamily>|g;
             s|<FontSize>[^<]*</FontSize>|<FontSize>'"$SIZE"'</FontSize>|g' \
            "$file"
        echo "Patched: $file"
    fi
done

echo "Done."
