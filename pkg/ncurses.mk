pkg_ver  := 6.2
pkg_site := https://invisible-mirror.net/archives/ncurses

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--without-ada \
	--without-cxx \
	--without-cxx-binding \
	--without-manpages \
	--without-tack \
	--without-tests \
	--enable-pc-files \
	--with-build-cc="$(CC)-11" \
	--with-build-cflags="$(HOST_CFLAGS)" \
	--with-build-ldflags="$(HOST_LDFLAGS)" \
	--without-debug \
	--without-dlsym \
	--disable-lib-suffixes \
	--disable-rpath-hack \
	--enable-symlinks \
	--with-pthread \
	--without-develop

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
