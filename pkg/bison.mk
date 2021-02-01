# https://repology.org/project/bison
# https://git.alpinelinux.org/aports/tree/main/bison/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/bison/bison.mk
# https://github.com/distr1/distri/blob/master/pkgs/bison/build.textproto
# https://github.com/kisslinux/repo/blob/master/core/bison/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/bison/template

# host dependencies: help2man perl m4

pkg_ver  := 3.7.5
pkg_repo := https://git.savannah.gnu.org/git/bison
pkg_site := https://ftp.gnu.org/gnu/bison

pkg_configure := M4=/usr/bin/m4 $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-assert \
	--disable-nls

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
