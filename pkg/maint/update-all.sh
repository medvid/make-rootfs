#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$SCRIPTPATH"

set -e

nvchecker -c source.toml
#mv versions.json versions_new.json

jq -r 'keys[] as $k | "\($k) \(.[$k])"' versions_new.json |
while IFS= read -r pkgdef
do
  [[ $pkgdef == '#'* ]] && continue
  bash ./update.sh $pkgdef
done

mv versions_new.json versions.json
git add versions.json
git commit -m "maint: update versions.json"
