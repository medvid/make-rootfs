pkg_ver  := 1.4.18
pkg_repo := https://git.savannah.gnu.org/git/m4
pkg_site := https://ftp.gnu.org/gnu/m4

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-assert

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
