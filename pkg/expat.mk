pkg_ver  := 2.2.10
pkg_repo := https://github.com/libexpat/libexpat
pkg_site := $(pkg_repo)/releases/download/R_$(subst .,_,$(pkg_ver))

pkg_configure := $(cmake_pkg_configure) \
	-DEXPAT_BUILD_EXAMPLES:BOOL=OFF \
	-DEXPAT_BUILD_TESTS:BOOL=OFF \
	-DEXPAT_SHARED_LIBS:BOOL=OFF \
	-DEXPAT_BUILD_DOCS:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
