pkg_ver  := 1.1.6
pkg_site := http://bitmath.org/code/mtdev

pkg_configure := $(pkg_srcdir)/configure \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
