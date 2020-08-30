pkg_ver  := 1.1.6
pkg_site := http://bitmath.org/code/mtdev

pkg_prepare := cp -v $(ROOT_DIR)/$(PKG_DIR)/files/config.sub \
	$(pkg_srcdir)/config-aux/config.sub

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
