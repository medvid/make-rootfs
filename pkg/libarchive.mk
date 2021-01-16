# https://repology.org/project/libarchive
# https://git.alpinelinux.org/aports/tree/main/libarchive/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libarchive/libarchive.mk
# https://github.com/distr1/distri/blob/master/pkgs/libarchive/build.textproto
# https://github.com/kisslinux/community/blob/master/community/libarchive/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libarchive/template

pkg_ver  := 3.5.1
pkg_repo := https://github.com/libarchive/libarchive
pkg_site := https://libarchive.org/downloads
pkg_deps := zlib bzip2 zstd xz

pkg_configure := $(cmake_pkg_configure) \
	-DENABLE_MBEDTLS:BOOL=OFF \
	-DENABLE_NETTLE:BOOL=OFF \
	-DENABLE_OPENSSL:BOOL=OFF \
	-DENABLE_LIBB2:BOOL=OFF \
	-DENABLE_LZ4:BOOL=OFF \
	-DENABLE_LZO:BOOL=OFF \
	-DENABLE_LZMA:BOOL=ON \
	-DENABLE_ZSTD:BOOL=ON \
	-DENABLE_ZLIB:BOOL=ON \
	-DENABLE_BZip2:BOOL=ON \
	-DENABLE_LIBXML2:BOOL=OFF \
	-DENABLE_EXPAT:BOOL=OFF \
	-DENABLE_PCREPOSIX:BOOL=OFF \
	-DENABLE_LibGCC:BOOL=OFF \
	-DENABLE_CNG:BOOL=OFF \
	-DENABLE_TAR:BOOL=ON \
	-DENABLE_CPIO:BOOL=ON \
	-DENABLE_XATTR:BOOL=OFF \
	-DENABLE_ACL:BOOL=OFF \
	-DENABLE_ICONV:BOOL=OFF \
	-DENABLE_TEST:BOOL=ON \
	-DENABLE_INSTALL:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
