# https://repology.org/project/ncurses
# https://git.alpinelinux.org/aports/tree/main/ncurses/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/ncurses/ncurses.mk
# https://github.com/distr1/distri/blob/master/pkgs/ncurses/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/ncurses/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/ncurses/template

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
	--without-pkg-config \
	--disable-pc-files \
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
