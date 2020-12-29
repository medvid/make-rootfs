pkg_ver  := 2.10.4
pkg_repo := https://git.savannah.gnu.org/git/freetype/freetype2.git
pkg_site := https://download.savannah.gnu.org/releases/freetype

pkg_configure := $(cmake_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DFT_WITH_ZLIB:BOOL=OFF \
	-DFT_WITH_BZIP2:BOOL=OFF \
	-DFT_WITH_PNG:BOOL=OFF \
	-DFT_WITH_HARFBUZZ:BOOL=OFF \
	-DFT_WITH_BROTLI:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_BZip2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_BrotliDec:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_PNG:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
