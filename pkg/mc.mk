# https://repology.org/project/mc
# https://git.alpinelinux.org/aports/tree/main/mc/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/mc/mc.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/mc/template

pkg_ver  := 4.8.26
pkg_repo := https://github.com/MidnightCommander/mc
pkg_site := https://www.midnight-commander.org/downloads
pkg_deps := check glib slang

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-shared \
	--enable-tests \
	--disable-nls \
	--disable-rpath \
	--disable-charset \
	--disable-assert \
	--disable-aspell \
	--enable-background \
	--enable-vfs-tar \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-html \
	--with-screen=slang \
	--with-search-engine=glib \
	--without-pcre \
	--without-x \
	--with-mmap \
	--without-gpm-mouse \
	--with-internal-edit \
	--with-diff-viewer \
	--with-subshell

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
