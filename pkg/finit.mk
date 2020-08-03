pkg_ver  := 3.2-rc3
pkg_repo := https://github.com/troglobit/finit
pkg_site := $(pkg_repo)/releases/download/$(pkg_ver)
pkg_deps := libuev libite

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sbindir=/usr/bin \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-silent-rules \
	--disable-shared \
	--enable-static \
	--enable-emergency-shell \
	--enable-fallback-shell \
	--enable-progress \
	--disable-doc \
	--disable-contrib \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	cp -v $(pkg_files)/finit.conf $(OUT_DIR)/etc
