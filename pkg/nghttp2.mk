# https://repology.org/project/nghttp2
# https://git.alpinelinux.org/aports/tree/main/nghttp2/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/nghttp2/nghttp2.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/nghttp2/template

pkg_ver  := 1.43.0
pkg_repo := https://github.com/nghttp2/nghttp2
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := $(cmake_pkg_configure) \
	-DENABLE_APP:BOOL=OFF \
	-DENABLE_HPACK_TOOLS:BOOL=OFF \
	-DENABLE_ASIO_LIB:BOOL=OFF \
	-DENABLE_EXAMPLES:BOOL=OFF \
	-DENABLE_PYTHON_BINDINGS:BOOL=OFF \
	-DENABLE_FAILMALLOC:BOOL=OFF \
	-DENABLE_STATIC_LIB:BOOL=ON \
	-DENABLE_SHARED_LIB:BOOL=OFF \
	-DENABLE_STATIC_CRT:BOOL=OFF \
	-DWITH_LIBXML2:BOOL=OFF \
	-DWITH_JEMALLOC:BOOL=OFF \
	-DWITH_SPDYLAY:BOOL=OFF \
	-DWITH_MRUBY:BOOL=OFF \
	-DWITH_NEVERBLEED:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_PythonInterp:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_OpenSSL:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libev:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libcares:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Systemd:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Jansson:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libevent:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Cython:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_PythonLibs:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LibXml2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Jemalloc:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_CUnit:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Boost:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
