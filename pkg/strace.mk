pkg_ver  := 5.8
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
	CC_FOR_BUILD=$(CC) \
	CFLAGS_FOR_BUILD="$(HOST_CFLAGS) --sysroot=$(OUT_DIR)" \
	LDFLAGS_FOR_BUILD="$(HOST_LDFLAGS) --sysroot=$(OUT_DIR)"

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
