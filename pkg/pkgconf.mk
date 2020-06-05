pkg_ver  := 1.7.3
pkg_repo := https://github.com/pkgconf/pkgconf
pkg_site := https://distfiles.dereferenced.org/pkgconf

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-pic \
	--with-pkg-config-dir=/usr/lib/pkgconfig:/usr/share/pkgconfig

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	ln -sf pkgconf $(OUT_DIR)/usr/bin/pkg-config
