pkg_ver  := 10.35
pkg_site := https://ftp.pcre.org/pub/pcre

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--enable-pcre2-8 \
	--enable-pcre2-16 \
	--enable-pcre2-32 \
	--enable-jit \
	--without-pic

pkg_build := make

# Do not install the executables
pkg_install := make install-libLTLIBRARIES install-data DESTDIR=$(OUT_DIR)
