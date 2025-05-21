#!/usr/bin/env bash

# Colors
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
NC='\e[0m'
BOLD='\e[1m'

temp_release_file="release_temp.txt"
current_version=$(grep -oPm1 '(?<=版本：).*' release.txt)

wget -qO $temp_release_file https://www.cns11643.gov.tw/opendata/release.txt
new_version=$(grep -oPm1 '(?<=版本：).*' release.txt)

echo
if [[ "$current_version" == "$new_version" ]]; then
  rm $temp_release_file
  echo -e "${GREEN}${BOLD}No change: 0-unstable-${new_version:0:4}-${new_version:4:2}-${new_version:6:2}${NC}"
else
  dos2unix $temp_release_file
  mv $temp_release_file release.txt
  wget -O Fonts_Kai.zip https://www.cns11643.gov.tw/opendata/Fonts_Kai.zip
  wget -O Fonts_Sung.zip https://www.cns11643.gov.tw/opendata/Fonts_Sung.zip
  for file in *zip; do
    unzip $file '*.ttf'
  done
  rm *zip
  echo -e "${YELLOW}${BOLD}UPDATED: 0-unstable-${new_version:0:4}-${new_version:4:2}-${new_version:6:2}${NC}"
fi
