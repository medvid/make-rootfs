pkg_ver  := 1.07.1
pkg_repo := https://git.savannah.gnu.org/git/bc
pkg_site := https://ftp.gnu.org/gnu/bc

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--without-libedit \
	--without-readline

pkg_build := make MAKEINFO=true

pkg_install := make install DESTDIR=$(OUT_DIR) MAKEINFO=true
