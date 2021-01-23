# https://repology.org/project/libpng
# https://git.alpinelinux.org/aports/tree/main/libpng/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libpng/libpng.mk
# https://github.com/distr1/distri/blob/master/pkgs/libpng/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/libpng/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libpng/template

pkg_ver  := 1.6.37
pkg_repo := https://git.code.sf.net/p/libpng/code
pkg_site := https://download.sourceforge.net/libpng
pkg_deps := zlib

pkg_configure := $(cmake_pkg_configure) \
	-DPNG_SHARED:BOOL=OFF \
	-DPNG_TESTS:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

# FIXME: tests depend on PNG_SHARED
#pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install && rm -f \
	$(OUT_DIR)/usr/bin/libpng16-config \
	$(OUT_DIR)/usr/bin/libpng-config
