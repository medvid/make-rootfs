# https://repology.org/project/dash
# https://git.alpinelinux.org/aports/tree/community/dash/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/dash/dash.mk
# https://github.com/kisslinux/community/blob/master/community/dash/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/dash/template

pkg_ver  := 0.5.11.2
pkg_repo := https://git.kernel.org/pub/scm/utils/dash/dash.git
pkg_site := http://gondor.apana.org.au/~herbert/dash/files

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--enable-static

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
