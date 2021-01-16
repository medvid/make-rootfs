# https://repology.org/project/libffi
# https://git.alpinelinux.org/aports/tree/main/libffi/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libffi/libffi.mk
# https://github.com/distr1/distri/blob/master/pkgs/libffi/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/libffi/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libffi/template

pkg_ver  := 3.3
pkg_repo := https://github.com/libffi/libffi
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

# TODO: testsuite depends on runtest

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--enable-portable-binary \
	--disable-docs \
	--disable-multi-os-directory \
	--without-pic

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
