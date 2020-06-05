pkg_ver  := 2.10.2
pkg_repo := https://git.savannah.gnu.org/git/freetype/freetype2.git
pkg_site := https://download.savannah.gnu.org/releases/freetype
pkg_deps := zlib libpng

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-shared \
	--without-pic \
	--with-zlib \
	--without-bzip2 \
	--with-png \
	--without-harfbuzz \
	--without-brotli

pkg_build := make CCexe="$(CC) $(HOST_CFLAGS)"

pkg_install := make install DESTDIR=$(OUT_DIR)
