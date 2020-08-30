pkg_ver  := 2.10.2
pkg_repo := https://git.savannah.gnu.org/git/freetype/freetype2.git
pkg_site := https://download.savannah.gnu.org/releases/freetype
pkg_deps := zlib libpng

# TODO: figure out circular dependency on harfbuzz
pkg_configure := cmake -G Ninja $(pkg_srcdir) \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DCMAKE_INSTALL_LIBDIR:STRING=lib \
	-DCMAKE_SYSROOT=$(OUT_DIR) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DFT_WITH_ZLIB:BOOL=ON \
	-DFT_WITH_BZIP2:BOOL=OFF \
	-DFT_WITH_PNG:BOOL=ON \
	-DFT_WITH_HARFBUZZ:BOOL=OFF \
	-DFT_WITH_BROTLI:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_BZip2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_BrotliDec:BOOL=ON

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
