#!/bin/zsh

fontSuffix="Z"
fontVersion="2.304"

mkdir -p "JetBrains-Mono-$fontSuffix"
cd JetBrains-Mono

# Non-italic versions
for f in $(fd -HI JetBrainsMono -e otf -E '*Italic.otf'); do
  pyftfeatfreeze -f "ss02,cv03,cv04,cv15,cv16,cv18,cv19,cv20" -R "Mono/Mono $fontSuffix" -v $f "${f%.otf}.z.otf"
done

# Italicized versions
for f in $(fd -HI Italic.otf -e otf); do
  pyftfeatfreeze -f "ss02,cv03,cv04,cv15,cv16,cv18,cv19,cv20" -R "Mono/Mono $fontSuffix" -v $f "${f%.otf}.z.otf"
done

mv *.z.otf ../"JetBrains-Mono-$fontSuffix"/
cd ../"JetBrains-Mono-$fontSuffix"/
for f in *.z.otf; do
  mv $f "$(echo "$f" | sed s/"\.z"/"-$fontSuffix"/)"
done

open .
