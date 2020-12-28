pkg_ver  := 10.36
pkg_site := https://ftp.pcre.org/pub/pcre

pkg_configure := $(cmake_pkg_configure) \
	-DPCRE2_BUILD_PCRE2_8:BOOL=ON \
	-DPCRE2_BUILD_PCRE2_16:BOOL=ON \
	-DPCRE2_BUILD_PCRE2_32:BOOL=ON \
	-DPCRE2_SUPPORT_JIT:BOOL=ON \
	-DPCRE2_BUILD_PCRE2GREP:BOOL=OFF \
	-DPCRE2_BUILD_TESTS:BOOL=OFF \
	-DPCRE2_SUPPORT_LIBBZ2:BOOL=OFF \
	-DPCRE2_SUPPORT_LIBZ:BOOL=OFF \
	-DPCRE2_SUPPORT_LIBEDIT:BOOL=OFF \
	-DPCRE2_SUPPORT_LIBREADLINE:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
