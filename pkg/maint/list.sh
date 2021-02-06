#!/usr/bin/env bash
# This script is used to determine the list of the files installed by the pkg_install step
# The listings are stored in pkg/list/${TARGET}/${PKG}
# The development files (headers, libraries, pkg-config) are split into ${PKG}-dev listings

set -eu
#set -vx
shopt -s nullglob

PKG=$1
TARGET=$2
OUT_DIR=$3

# Delete the current package listings and temporary files
rm -f tmp/list/${TARGET}/${PKG}.new tmp/list/${TARGET}/${PKG} pkg/list/${TARGET}/${PKG} pkg/list/${TARGET}/${PKG}-dev

# Create directories for the package listings and temporary files
mkdir -p pkg/list/${TARGET} tmp/list/${TARGET}

# Find all files installed to OUT_DIR
find -L ${OUT_DIR} -type f -printf '/%P\n' | grep -v -e '^/bin/' -e '^/lib/' -e '^/sbin/' | sort -u > tmp/list/${TARGET}/${PKG}.new

# Find all files from OUT_DIR which are not present in the existing package listings
# This trick finds the new files installed by PKG as its package listing is removed at the first step
: | cat pkg/list/${TARGET}/* | sort -u | comm -3 - tmp/list/${TARGET}/${PKG}.new | sed -e "s/^[ \t]*//" > tmp/list/${TARGET}/${PKG}

# Save the list of the development files to the pkg-dev listing
cat tmp/list/${TARGET}/${PKG} | grep -e '^/usr/include/' -e '^/usr/lib/' | cat > pkg/list/${TARGET}/${PKG}-dev

# Save the list of non-development files to the pkg listing
comm -3 tmp/list/${TARGET}/${PKG} pkg/list/${TARGET}/${PKG}-dev > pkg/list/${TARGET}/${PKG}

# Cleanup temporary files
rm tmp/list/${TARGET}/${PKG}.new tmp/list/${TARGET}/${PKG}

# Cleanup empty package lists
find pkg/list/${TARGET} -type f -empty -delete

