pkg_ver  := 0.8.4
pkg_repo := https://github.com/landley/toybox
pkg_site := https://landley.net/toybox/downloads
pkg_deps := openssl

# toybox doesn't support out-of-tree build
# http://lists.landley.net/pipermail/toybox-landley.net/2017-December/009305.html
pkg_copy := true

ifeq ($(STAGE),)
pkg_vars := HOSTCC="clang -static"
else
pkg_vars := HOSTCC="clang -static --sysroot=$(SYSROOT)"
endif

# Default OPTIMIZE includes -Os which is not compatible with -flto
# https://reviews.llvm.org/D63976
pkg_vars += V=2 OPTIMIZE="-ffunction-sections -fdata-sections -fno-asynchronous-unwind-tables -fno-strict-aliasing"

pkg_prepare := cp -v $(pkg_files)/config $(pkg_objdir)/.config

pkg_configure := make silentoldconfig

# Build system doesn't like TARGET variable
pkg_build := make TARGET=

pkg_install := make install_flat PREFIX=$(OUT_DIR)/usr/bin
