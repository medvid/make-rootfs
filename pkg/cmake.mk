pkg_ver  := 3.19.3
pkg_repo := https://github.com/Kitware/CMake
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_deps := curl expat zlib bzip2 zstd xz nghttp2 jsoncpp rhash libuv openssl

pkg_configure := LDFLAGS="$(LDFLAGS) -lcurl -lcrypto -lssl" \
	$(cmake_pkg_configure) \
	-DCMAKE_DATA_DIR=share/cmake \
	-DCMAKE_DOC_DIR=share/doc/cmake \
	-DCMAKE_USE_SYSTEM_LIBARCHIVE:BOOL=OFF \
	-DCMAKE_USE_SYSTEM_CURL:BOOL=ON \
	-DCMAKE_USE_SYSTEM_EXPAT:BOOL=ON \
	-DCMAKE_USE_SYSTEM_ZLIB:BOOL=ON \
	-DCMAKE_USE_SYSTEM_BZIP2:BOOL=ON \
	-DCMAKE_USE_SYSTEM_ZSTD:BOOL=ON \
	-DCMAKE_USE_SYSTEM_LIBLZMA:BOOL=ON \
	-DCMAKE_USE_SYSTEM_NGHTTP2:BOOL=ON \
	-DCMAKE_USE_SYSTEM_JSONCPP:BOOL=ON \
	-DCMAKE_USE_SYSTEM_LIBRHASH:BOOL=ON \
	-DCMAKE_USE_SYSTEM_LIBUV:BOOL=ON \
	-DBUILD_TESTING:BOOL=OFF \
	-DBUILD_CursesDialog:BOOL=OFF \
	-DBUILD_QtDialog:BOOL=OFF \
	-DCMake_RUN_CXX_FILESYSTEM:INTERNAL=0 \
	-DCMake_RUN_CXX_FILESYSTEM__TRYRUN_OUTPUT:INTERNAL="" \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
