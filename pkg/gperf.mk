# https://repology.org/project/gperf
# https://git.alpinelinux.org/aports/tree/main/gperf/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/gperf/gperf.mk
# https://github.com/distr1/distri/blob/master/pkgs/gperf/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/gperf/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/gperf/template

pkg_ver  := 3.1
pkg_repo := https://git.savannah.gnu.org/git/gperf
pkg_site := http://ftp.gnu.org/pub/gnu/gperf

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
