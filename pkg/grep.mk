pkg_ver  := 3.4
pkg_repo := https://git.savannah.gnu.org/git/grep
pkg_site := https://ftp.gnu.org/gnu/grep

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-assert \
	--disable-nls \
	--disable-perl-regexp

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
