# https://repology.org/project/libuv
# https://git.alpinelinux.org/aports/tree/main/libuv/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libuv/libuv.mk
# https://github.com/kisslinux/community/blob/master/community/libuv/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libuv/template

pkg_ver  := 1.40.0
pkg_repo := https://github.com/libuv/libuv
pkg_site := https://dist.libuv.org/dist/v$(pkg_ver)
pkg_dir  := libuv-v$(pkg_ver)

pkg_configure := $(cmake_pkg_configure) \
	-DBUILD_TESTING:BOOL=FALSE \
	-DLIBUV_BUILD_TESTS:BOOL=FALSE \
	-DLIBUV_BUILD_BENCH:BOOL=FALSE \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install && \
	mv $(OUT_DIR)/usr/lib/libuv_a.a $(OUT_DIR)/usr/lib/libuv.a && \
	rm $(OUT_DIR)/usr/lib/pkgconfig/libuv-static.pc
