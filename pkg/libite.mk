pkg_ver  := 2.2.0
pkg_repo := https://github.com/troglobit/libite
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
