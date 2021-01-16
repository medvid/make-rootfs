# https://repology.org/project/libevent
# https://git.alpinelinux.org/aports/tree/main/libevent/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libevent/libevent.mk
# https://github.com/distr1/distri/blob/master/pkgs/libevent/build.textproto
# https://github.com/kisslinux/community/blob/master/community/libevent/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libevent/template

pkg_ver  := 2.1.12
pkg_repo := https://github.com/libevent/libevent
pkg_site := $(pkg_repo)/releases/download/release-$(pkg_ver)-stable
pkg_dir  := libevent-$(pkg_ver)-stable
pkg_deps := openssl

pkg_configure := $(cmake_pkg_configure) \
	-DEVENT__DISABLE_DEBUG_MODE:BOOL=OFF \
	-DEVENT__DISABLE_BENCHMARK:BOOL=ON \
	-DEVENT__DISABLE_TESTS:BOOL=OFF \
	-DEVENT__DISABLE_REGRESS:BOOL=ON \
	-DEVENT__DISABLE_SAMPLES:BOOL=ON \
	-DEVENT__LIBRARY_TYPE:STRING="STATIC" \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
