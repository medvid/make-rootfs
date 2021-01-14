pkg_ver  := 563
pkg_repo := https://github.com/gwsw/less
pkg_site := http://www.greenwoodsoftware.com/less
pkg_deps := ncurses

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--with-secure \
	--with-regex=posix

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
