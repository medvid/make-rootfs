# https://repology.org/project/freetype
# https://git.alpinelinux.org/aports/tree/main/freetype/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/freetype/freetype.mk
# https://github.com/distr1/distri/blob/master/pkgs/freetype/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/freetype-harfbuzz/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/freetype/template

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
