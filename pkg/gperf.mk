pkg_ver  := 3.1
pkg_repo := https://git.savannah.gnu.org/git/gperf
pkg_site := http://ftp.gnu.org/pub/gnu/gperf

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
