#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$SCRIPTPATH"

set -e

nvchecker "source.ini"
#mv versions.txt versions_new.txt

while IFS= read -r pkgdef
do
  [[ $pkgdef == '#'* ]] && continue
  bash ./update.sh $pkgdef
done < versions_new.txt

mv versions_new.txt versions.txt
git add versions.txt
git commit -m "maint: update versions.txt"
