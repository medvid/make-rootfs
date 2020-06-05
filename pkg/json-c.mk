pkg_ver  := 0.15
pkg_repo := https://github.com/json-c/json-c
pkg_site := https://s3.amazonaws.com/json-c_releases/releases

pkg_configure := cmake -G Ninja $(pkg_srcdir) \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DCMAKE_INSTALL_LIBDIR:STRING=lib \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_STATIC_LIBS:BOOL=ON \
	-DDISABLE_STATIC_FPIC:BOOL=ON

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
