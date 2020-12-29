pkg_ver  := 3.5.1
pkg_repo := https://github.com/libarchive/libarchive
pkg_site := https://libarchive.org/downloads
pkg_deps := zlib bzip2 zstd xz

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
	--with-bz2lib \
	--without-libb2 \
	--without-iconv \
	--without-lz4 \
	--with-zstd \
	--with-lzma \
	--without-cng \
	--without-openssl \
	--without-xml2 \
	--without-expat

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
