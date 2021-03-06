# https://repology.org/project/pcre
# https://git.alpinelinux.org/aports/tree/main/pcre/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/pcre/pcre.mk
# https://github.com/distr1/distri/blob/master/pkgs/pcre/build.textproto
# https://github.com/kisslinux/community/blob/master/community/pcre/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/pcre/template

pkg_ver  := 8.44
pkg_site := https://ftp.pcre.org/pub/pcre

pkg_configure := $(cmake_pkg_configure) \
	-DPCRE_BUILD_PCRE8:BOOL=ON \
	-DPCRE_BUILD_PCRE16:BOOL=OFF \
	-DPCRE_BUILD_PCRE32:BOOL=OFF \
	-DPCRE_BUILD_PCRECPP:BOOL=OFF \
	-DPCRE_SUPPORT_JIT:BOOL=ON \
	-DPCRE_SUPPORT_UTF:BOOL=ON \
	-DPCRE_BUILD_PCREGREP:BOOL=OFF \
	-DPCRE_BUILD_TESTS:BOOL=ON \
	-DPCRE_SUPPORT_LIBBZ2:BOOL=OFF \
	-DPCRE_SUPPORT_LIBZ:BOOL=OFF \
	-DPCRE_SUPPORT_LIBEDIT:BOOL=OFF \
	-DPCRE_SUPPORT_LIBREADLINE:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_BZip2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Readline:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Editline:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install && \
	install -m 644 $(pkg_files)/libpcre.pc $(pkg_files)/libpcreposix.pc $(OUT_DIR)/usr/lib/pkgconfig && \
	rm $(OUT_DIR)/usr/bin/pcretest $(OUT_DIR)/usr/bin/pcre_jit_test
