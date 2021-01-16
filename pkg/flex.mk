# https://repology.org/project/flex
# https://git.alpinelinux.org/aports/tree/main/flex/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/flex/flex.mk
# https://github.com/distr1/distri/blob/master/pkgs/flex/build.textproto
# https://github.com/kisslinux/repo/blob/master/core/flex/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/flex/template

# host dependencies: bison m4

pkg_ver  := 2.6.4
pkg_repo := https://github.com/westes/flex
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_deps := bison

pkg_configure := $(pkg_srcdir)/configure \
	CC_FOR_BUILD=$(CC) \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-nls \
	--disable-shared \
	--disable-bootstrap

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
