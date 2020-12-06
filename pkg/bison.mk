pkg_ver  := 3.7.4
pkg_repo := https://git.savannah.gnu.org/git/bison
pkg_site := https://ftp.gnu.org/gnu/bison

pkg_configure := M4=/usr/bin/m4 $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-assert \
	--disable-nls

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
