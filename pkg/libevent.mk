pkg_ver  := 2.1.12
pkg_repo := https://github.com/libevent/libevent
pkg_site := $(pkg_repo)/releases/download/release-$(pkg_ver)-stable
pkg_dir  := libevent-$(pkg_ver)-stable
pkg_deps := libressl

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-debug-mode \
	--disable-samples \
	--disable-shared \
	--disable-doxygen-html \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
