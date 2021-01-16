# https://repology.org/project/m4
# https://git.alpinelinux.org/aports/tree/main/m4/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/m4/m4.mk
# https://github.com/distr1/distri/blob/master/pkgs/m4/build.textproto
# https://github.com/kisslinux/repo/blob/master/core/m4/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/m4/template

pkg_ver  := 1.4.18
pkg_repo := https://git.savannah.gnu.org/git/m4
pkg_site := https://ftp.gnu.org/gnu/m4

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-assert

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
