# https://repology.org/project/grep
# https://git.alpinelinux.org/aports/tree/main/grep/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/grep/grep.mk
# https://github.com/distr1/distri/blob/master/pkgs/grep/build.textproto
# https://github.com/kisslinux/community/blob/master/community/gnugrep/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/grep/template

pkg_ver  := 3.6
pkg_repo := https://git.savannah.gnu.org/git/grep
pkg_site := https://ftp.gnu.org/gnu/grep

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-assert \
	--disable-nls \
	--disable-perl-regexp

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
