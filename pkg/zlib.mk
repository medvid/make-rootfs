# https://repology.org/project/zlib
# https://git.alpinelinux.org/aports/tree/main/zlib/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/zlib/zlib.mk
# https://github.com/distr1/distri/blob/master/pkgs/zlib/build.textproto
# https://github.com/kisslinux/repo/blob/master/core/zlib/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/zlib/template

pkg_ver  := 1.2.11
pkg_repo := https://github.com/madler/zlib
pkg_site := https://www.zlib.net

pkg_configure := $(pkg_srcdir)/configure \
	--prefix=/usr \
	--static

pkg_build := make libz.a

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
