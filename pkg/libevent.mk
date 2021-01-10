pkg_ver  := 2.1.12
pkg_repo := https://github.com/libevent/libevent
pkg_site := $(pkg_repo)/releases/download/release-$(pkg_ver)-stable
pkg_dir  := libevent-$(pkg_ver)-stable
pkg_deps := openssl

pkg_configure := $(cmake_pkg_configure) \
	-DEVENT__DISABLE_DEBUG_MODE:BOOL=OFF \
	-DEVENT__DISABLE_BENCHMARK:BOOL=ON \
	-DEVENT__DISABLE_TESTS:BOOL=ON \
	-DEVENT__DISABLE_REGRESS:BOOL=ON \
	-DEVENT__DISABLE_SAMPLES:BOOL=ON \
	-DEVENT__LIBRARY_TYPE:STRING="STATIC" \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
