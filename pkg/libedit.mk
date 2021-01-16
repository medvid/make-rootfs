# https://repology.org/project/libedit
# https://git.alpinelinux.org/aports/tree/main/libedit/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libedit/libedit.mk
# https://github.com/kisslinux/community/blob/master/community/libedit/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libedit/template

pkg_ver  := 20191231-3.1
pkg_site := https://thrysoee.dk/editline
pkg_deps := ncurses

# http://lists.buildroot.org/pipermail/buildroot/2016-January/149100.html
pkg_configure := CFLAGS="$(CFLAGS) -D__STDC_ISO_10646__=201103L" \
	$(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-shared \
	--disable-examples \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
