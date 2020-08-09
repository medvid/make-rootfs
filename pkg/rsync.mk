pkg_ver  := 3.2.2
pkg_repo := https://git.samba.org/rsync.git
pkg_site := https://www.samba.org/ftp/rsync/src
pkg_deps := zlib libressl

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-debug \
	--disable-md2man \
	--disable-ipv6 \
	--disable-acl-support \
	--disable-xattr-support \
	--disable-xxhash \
	--disable-zstd \
	--disable-lz4 \
	--with-included-popt

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
