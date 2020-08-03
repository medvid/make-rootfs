pkg_ver  := 5.7
pkg_repo := https://github.com/strace/strace
pkg_site := https://strace.io/files/$(pkg_ver)

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--enable-stacktrace=no \
	--enable-mpers=no \
	--without-libdw \
	--without-libunwind \
	--without-libiberty \
	CC_FOR_BUILD=$(CC)

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
