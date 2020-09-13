#!/bin/bash

ROOTPATH="$( cd "$(dirname "$0")/../.." >/dev/null 2>&1 ; pwd -P )"

set -eu

pkg_name=$1
pkg_ver=$2

grep -q "^pkg_ver[ ]\+:= $pkg_ver\$" "$ROOTPATH/pkg/$pkg_name.mk" && exit 0
old_ver="$(sed -n -e '/^pkg_ver/s/pkg_ver[ ]\+:= //p' "$ROOTPATH/pkg/$pkg_name.mk")"

echo "$@"

pkg_base="$(sed -n -e '/^pkg_base/s/pkg_base[ ]\+:= //p' "$ROOTPATH/pkg/$pkg_name.mk")"
[[ -z "$pkg_base" ]] && pkg_base=$pkg_name

pkg_dir="$(sed -n -e '/^pkg_dir/s/pkg_dir[ ]\+:= //p' "$ROOTPATH/pkg/$pkg_name.mk")"
[[ -z "$pkg_dir" ]] && pkg_dir=$pkg_base-$pkg_ver
pkg_dir="${pkg_dir/\$(pkg_ver)/$pkg_ver}"
echo pkg_dir=$pkg_dir

if ! git diff --stat --exit-code; then
  echo "Working tree dirty, aborting.."
  exit 1
fi

sed -e "/^pkg_ver/s/$old_ver/$pkg_ver/" -i "$ROOTPATH/pkg/$pkg_name.mk"

pkg_old_sha="$(basename "$(cd "$ROOTPATH/src" && find . -maxdepth 1 -name "$pkg_base*.sha256sum" | tail -1)")"
if [[ -f "$ROOTPATH/src/$pkg_old_sha" ]]; then
  pkg_new_sha="$(echo "$pkg_old_sha" | sed -e "s/$old_ver/$pkg_ver/")"
  if [[ "$pkg_old_sha" != "$pkg_new_sha" ]]; then
    mv -v "$ROOTPATH/src/$pkg_old_sha" "$ROOTPATH/src/$pkg_new_sha"
  fi
  find "$ROOTPATH/pkg/patches" -maxdepth 1 -type d -name "$pkg_dir*" -exec mv {} "$ROOTPATH/pkg/patches/$pkg_dir" \;
else
  echo "Error: cannot find source checksums matching src/$pkg_dir.*.sha256sum pattern"
  exit 1
fi

MAINT=1 make -C "$ROOTPATH" "src/$pkg_dir"
git add "$ROOTPATH/pkg/$pkg_name.mk" "$ROOTPATH/src/$pkg_old_sha" "$ROOTPATH/src/$pkg_new_sha"
git commit -m "$pkg_name: update to $pkg_ver"
