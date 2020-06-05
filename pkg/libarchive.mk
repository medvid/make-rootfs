pkg_ver  := 3.4.3
pkg_repo := https://github.com/libarchive/libarchive
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_deps := zlib

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--enable-bsdtar=static \
	--enable-bsdtar=static \
	--enable-bsdcpio=static \
	--enable-posix-regex-lib=libc \
	--disable-xattr \
	--disable-acl \
	--without-pic \
	--without-bz2lib \
	--without-libb2 \
	--without-iconv \
	--without-lz4 \
	--without-zstd \
	--without-lzma \
	--without-cng \
	--without-openssl \
	--without-xml2 \
	--without-expat

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
