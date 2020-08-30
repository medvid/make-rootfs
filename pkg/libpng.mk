pkg_ver  := 1.6.37
pkg_repo := https://git.code.sf.net/p/libpng/code
pkg_site := http://prdownloads.sourceforge.net/libpng
pkg_deps := zlib

pkg_configure := cmake -G Ninja $(pkg_srcdir) \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DCMAKE_INSTALL_LIBDIR:STRING=lib \
	-DCMAKE_SYSROOT=$(OUT_DIR) \
	-DPNG_SHARED:BOOL=OFF \
	-DPNG_TESTS:BOOL=OFF

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install && rm -f \
	$(OUT_DIR)/usr/bin/libpng16-config \
	$(OUT_DIR)/usr/bin/libpng-config
