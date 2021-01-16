# https://repology.org/project/mawk
# https://git.alpinelinux.org/aports/tree/community/mawk/APKBUILD
# https://github.com/kisslinux/community/blob/master/community/mawk/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/mawk/template

pkg_ver  := 1.3.4-20200120
pkg_repo := https://github.com/ThomasDickey/mawk-snapshots
pkg_site := https://invisible-mirror.net/archives/mawk

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	ln -sf mawk $(OUT_DIR)/usr/bin/awk
