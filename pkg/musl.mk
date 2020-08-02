pkg_ver  := 1.2.0
pkg_repo := git://git.musl-libc.org/musl
pkg_site := https://www.musl-libc.org/releases

pkg_configure := $(pkg_srcdir)/configure \
	--prefix=/usr \
	--target=$(TARGET) \
	--disable-shared

pkg_build := make

pkg_install := make install-libs install-headers DESTDIR=$(OUT_DIR)