pkg_ver  := 1.3.4-20200120
pkg_repo := https://github.com/ThomasDickey/mawk-snapshots
pkg_site := ftp://ftp.invisible-island.net/mawk

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	ln -sf mawk $(OUT_DIR)/usr/bin/awk
