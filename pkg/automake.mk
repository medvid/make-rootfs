# https://repology.org/project/automake
# https://git.alpinelinux.org/aports/tree/main/automake/APKBUILD
# https://github.com/distr1/distri/blob/master/pkgs/automake/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/automake/template

pkg_ver  := 1.16.3
pkg_repo := https://git.savannah.gnu.org/git/automake
pkg_site := https://ftp.gnu.org/gnu/automake
pkg_deps := perl autoconf

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
