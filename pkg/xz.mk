# https://repology.org/project/xz
# https://git.alpinelinux.org/aports/tree/main/xz/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/xz/xz.mk
# https://github.com/kisslinux/repo/blob/master/core/xz/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/xz/template

pkg_ver  := 5.2.5
pkg_repo := https://git.tukaani.org/xz.git
pkg_site := https://tukaani.org/xz

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-lzma-links \
	--disable-doc \
	--disable-silent-rules \
	--disable-shared \
	--disable-nls

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
