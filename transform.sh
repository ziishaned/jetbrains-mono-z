#!/bin/zsh

# Variables
fontSuffix="Z"
fontVersion="2.304"
outDir="JetBrains-Mono-$fontSuffix"
patcherRepo="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FontPatcher.zip"

# Clean up and setup
rm -rf FontPatcher FontPatcher.zip
mkdir -p "$outDir"

# Download and extract patcher
curl -LO "$patcherRepo"
unzip -d FontPatcher FontPatcher.zip

# Process fonts
cd JetBrains-Mono

# Process all fonts with a single pattern (handles both italic and non-italic)
fd -HI '\.otf$' -x pyftfeatfreeze -f "ss02,cv03,cv04,cv15,cv16,cv18,cv19,cv20" -R "Mono/Mono $fontSuffix" -v {} "{.}.z.otf" \;

# Move processed fonts to output directory
mv *.z.otf ../"$outDir"/

# Rename files properly
cd ../"$outDir"/
for f in *.z.otf; do
  mv "$f" "$(echo "$f" | sed 's/\.z/-'"$fontSuffix"'/')"
done

for f in *.otf; do
  fontforge -script ../FontPatcher/font-patcher "$f" --out "../$outDir" --name "${f%.otf}" --octicons
done

# Open the folder
open .
