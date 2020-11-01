pkg_ver  := 2.2.10
pkg_repo := https://github.com/libexpat/libexpat
pkg_site := $(pkg_repo)/releases/download/R_$(subst .,_,$(pkg_ver))

pkg_configure := cmake -G Ninja $(pkg_srcdir) \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DCMAKE_INSTALL_LIBDIR:STRING=lib \
	-DCMAKE_SYSROOT=$(OUT_DIR) \
	-DEXPAT_BUILD_EXAMPLES:BOOL=OFF \
	-DEXPAT_BUILD_TESTS:BOOL=OFF \
	-DEXPAT_SHARED_LIBS:BOOL=OFF \
	-DEXPAT_BUILD_DOCS:BOOL=OFF

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
