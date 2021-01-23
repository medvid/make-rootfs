# https://repology.org/project/libjpeg-turbo
# https://git.alpinelinux.org/aports/tree/main/libjpeg-turbo/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/jpeg-turbo/jpeg-turbo.mk
# https://github.com/distr1/distri/blob/master/pkgs/libjpeg-turbo/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/libjpeg-turbo/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libjpeg-turbo/template

pkg_ver  := 2.0.6
pkg_repo := https://github.com/libjpeg-turbo/libjpeg-turbo
pkg_site := https://downloads.sourceforge.net/libjpeg-turbo

# TODO: enable SIMD

pkg_configure := $(cmake_pkg_configure) \
	-DENABLE_SHARED:BOOL=OFF \
	-DENABLE_STATIC:BOOL=ON \
	-DWITH_JPEG8:BOOL=ON \
	-DWITH_SIMD:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install && rm -f \
	$(OUT_DIR)/usr/bin/tjbench \
	$(OUT_DIR)/usr/bin/cjpeg \
	$(OUT_DIR)/usr/bin/djpeg \
	$(OUT_DIR)/usr/bin/jpegtran \
	$(OUT_DIR)/usr/bin/rdjpgcom \
	$(OUT_DIR)/usr/bin/wrjpgcom
