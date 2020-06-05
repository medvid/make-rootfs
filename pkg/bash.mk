pkg_ver  := 5.0
pkg_repo := https://git.savannah.gnu.org/git/bash
pkg_site := https://ftp.gnu.org/gnu/bash

pkg_configure := $(pkg_srcdir)/configure \
	CC_FOR_BUILD=$(CC) \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-nls \
	--enable-readline \
	--enable-static-link \
	--without-bash-malloc \
	--without-installed-readline

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	ln -sf bash $(OUT_DIR)/usr/bin/sh && \
	rm -f $(OUT_DIR)/usr/bin/bashbug
