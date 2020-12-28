pkg_ver  := 1.6.37
pkg_repo := https://git.code.sf.net/p/libpng/code
pkg_site := https://download.sourceforge.net/libpng
pkg_deps := zlib

pkg_configure := $(cmake_pkg_configure) \
	-DPNG_SHARED:BOOL=OFF \
	-DPNG_TESTS:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install && rm -f \
	$(OUT_DIR)/usr/bin/libpng16-config \
	$(OUT_DIR)/usr/bin/libpng-config
