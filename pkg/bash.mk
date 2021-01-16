# https://repology.org/project/bash
# https://git.alpinelinux.org/aports/tree/main/bash/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/bash/bash.mk
# https://github.com/distr1/distri/blob/master/pkgs/bash/build.textproto
# https://github.com/kisslinux/community/blob/master/community/bash/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/bash/template

# host dependencies: bison

pkg_ver  := 5.1
pkg_repo := https://git.savannah.gnu.org/git/bash
pkg_site := https://ftp.gnu.org/gnu/bash

pkg_configure := $(pkg_srcdir)/configure \
	CC_FOR_BUILD=$(CC) \
	CFLAGS_FOR_BUILD="$(HOST_CFLAGS)" \
	LDFLAGS_FOR_BUILD="$(HOST_LDFLAGS)" \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-nls \
	--enable-readline \
	--enable-static-link \
	--without-bash-malloc \
	--without-curses \
	--without-installed-readline

pkg_build := make

pkg_check := make tests

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	ln -sf bash $(OUT_DIR)/usr/bin/sh && \
	rm -f $(OUT_DIR)/usr/bin/bashbug
