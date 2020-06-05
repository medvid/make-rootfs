pkg_ver  := 2.13.1
pkg_repo := https://gitlab.freedesktop.org/fontconfig/fontconfig
pkg_site := https://www.freedesktop.org/software/fontconfig/release
pkg_deps := expat freetype libuuid

# TODO: check why Requires.private is not parsed from freetype2.pc
pkg_vars := LDFLAGS="$(LDFLAGS) -lz -lpng"

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-silent-rules \
	--enable-static \
	--disable-shared \
	--disable-nls \
	--disable-docs \
	--without-pic

# Only build library and headers
pkg_build := make -C src && \
	make -C fontconfig

# Only install library and headers
pkg_install := make -C src install DESTDIR=$(OUT_DIR) && \
	make -C fontconfig install DESTDIR=$(OUT_DIR) && \
	install -m 644 fontconfig.pc $(OUT_DIR)/usr/lib/pkgconfig/fontconfig.pc
