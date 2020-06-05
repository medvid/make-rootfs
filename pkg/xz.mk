pkg_ver  := 5.2.5
pkg_repo := https://git.tukaani.org/xz.git
pkg_site := https://tukaani.org/xz

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-lzma-links \
	--disable-doc \
	--disable-silent-rules \
	--disable-shared \
	--disable-nls

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
