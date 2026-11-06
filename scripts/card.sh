#!/usr/bin/env bash
# Genera assets/card-<repo>.svg con datos del API de GitHub
set -e
repo="$1"
json=$(gh api "repos/cgarciagl/$repo")
desc=$(echo "$json" | jq -r '.description // "Sin descripción"' | sed 's/&/\&amp;/g;s/</\&lt;/g;s/>/\&gt;/g' | cut -c1-110)
stars=$(echo "$json" | jq -r .stargazers_count)
forks=$(echo "$json" | jq -r .forks_count)
lang=$(echo "$json" | jq -r '.language // "—"')
l1=$(echo "$desc" | cut -c1-55); l2=$(echo "$desc" | cut -c56-110)
cat > "assets/card-$repo.svg" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="400" height="130" viewBox="0 0 400 130">
  <rect x="0.5" y="0.5" width="399" height="129" rx="8" fill="#0d1117" stroke="#7f1d1d"/>
  <g font-family="Segoe UI, Ubuntu, sans-serif">
    <text x="20" y="35" font-size="18" font-weight="600" fill="#dc2626">📦 $repo</text>
    <text x="20" y="62" font-size="13" fill="#c9d1d9">$l1</text>
    <text x="20" y="80" font-size="13" fill="#c9d1d9">$l2</text>
    <circle cx="26" cy="106" r="6" fill="#dc2626"/>
    <text x="38" y="111" font-size="13" fill="#8b949e">$lang</text>
    <text x="170" y="111" font-size="13" fill="#8b949e">★ $stars</text>
    <text x="240" y="111" font-size="13" fill="#8b949e">⑂ $forks</text>
  </g>
</svg>
SVG
