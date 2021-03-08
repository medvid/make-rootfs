# https://repology.org/project/autoconf
# https://git.alpinelinux.org/aports/tree/main/autoconf/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/autoconf/autoconf.mk
# https://github.com/distr1/distri/blob/master/pkgs/autoconf/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/autoconf/template

pkg_ver  := 2.71
pkg_repo := https://git.savannah.gnu.org/git/autoconf
pkg_site := https://ftp.gnu.org/gnu/autoconf
pkg_deps := m4 perl

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
