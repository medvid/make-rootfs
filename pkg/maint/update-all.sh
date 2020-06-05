#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$SCRIPTPATH"

set -e

if ! git diff --stat; then
  echo "Working tree dirty, aborting.."
  exit 1
fi

nvchecker "source.ini"
#mv versions.txt versions_new.txt

while IFS= read -r pkgdef
do
  [[ $pkgdef == '#'* ]] && continue
  ./update.sh $pkgdef
done < versions_new.txt

mv versions_new.txt versions.txt
