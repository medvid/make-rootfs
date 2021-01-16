# https://repology.org/project/musl
# https://git.alpinelinux.org/aports/tree/main/musl/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/musl/musl.mk
# https://github.com/distr1/distri/blob/master/pkgs/musl/build.textproto
# https://github.com/kisslinux/repo/blob/master/core/musl/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/musl/template

pkg_ver  := 1.2.1
pkg_repo := git://git.musl-libc.org/musl
pkg_site := https://musl.libc.org/releases

pkg_configure := $(pkg_srcdir)/configure \
	--prefix=/usr \
	--target=$(TARGET) \
	--disable-shared

pkg_build := make

pkg_install := make install-libs install-headers DESTDIR=$(OUT_DIR)
