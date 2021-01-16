# https://repology.org/project/pcre2
# https://git.alpinelinux.org/aports/tree/main/pcre2/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/pcre2/pcre2.mk
# https://github.com/kisslinux/community/blob/master/community/pcre2/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/pcre2/template

pkg_ver  := 10.36
pkg_site := https://ftp.pcre.org/pub/pcre

pkg_configure := $(cmake_pkg_configure) \
	-DPCRE2_BUILD_PCRE2_8:BOOL=ON \
	-DPCRE2_BUILD_PCRE2_16:BOOL=ON \
	-DPCRE2_BUILD_PCRE2_32:BOOL=ON \
	-DPCRE2_SUPPORT_JIT:BOOL=ON \
	-DPCRE2_SUPPORT_UNICODE:BOOL=ON \
	-DPCRE2_BUILD_PCRE2GREP:BOOL=OFF \
	-DPCRE2_BUILD_TESTS:BOOL=ON \
	-DPCRE2_SUPPORT_LIBBZ2:BOOL=OFF \
	-DPCRE2_SUPPORT_LIBZ:BOOL=OFF \
	-DPCRE2_SUPPORT_LIBEDIT:BOOL=OFF \
	-DPCRE2_SUPPORT_LIBREADLINE:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_BZip2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Readline:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Editline:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install && rm \
	$(OUT_DIR)/usr/bin/pcre2test \
	$(OUT_DIR)/usr/bin/pcre2_jit_test \
	$(OUT_DIR)/usr/bin/pcre2-config
