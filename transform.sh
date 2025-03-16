#!/bin/zsh

# Variables
fontSuffix="Z"
fontVersion="2.304"
outDir="JetBrainsMono$fontSuffix"

# Clean up and setup
mkdir -p "$outDir"

# Process fonts
cd JetBrainsMono

# Process all fonts with a single pattern (handles both italic and non-italic)
fd -HI '\.ttf$' -x pyftfeatfreeze -f "ss02,cv03,cv04,cv15,cv16,cv18,cv19,cv20" -R "Mono/Mono $fontSuffix" -v {} "{.}.z.ttf" \;

# Move processed fonts to output directory
mv *.z.ttf ../"$outDir"/

# Rename files properly
cd ../"$outDir"/
for f in *.z.ttf; do
  mv "$f" "$(echo "$f" | sed 's/\.z/-'"$fontSuffix"'/')"
done

# Open the folder
open .
