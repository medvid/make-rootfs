pkg_ver  := 3.7
pkg_repo := https://git.savannah.gnu.org/git/diffutils
pkg_site := https://ftp.gnu.org/gnu/diffutils

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-nls

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
