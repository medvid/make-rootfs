# https://repology.org/project/diffutils
# https://git.alpinelinux.org/aports/tree/main/diffutils/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/diffutils/diffutils.mk
# https://github.com/distr1/distri/blob/master/pkgs/diffutils/build.textproto
# https://github.com/kisslinux/community/blob/master/community/diffutils/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/diffutils/template

pkg_ver  := 3.7
pkg_repo := https://git.savannah.gnu.org/git/diffutils
pkg_site := https://ftp.gnu.org/gnu/diffutils

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-nls

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
