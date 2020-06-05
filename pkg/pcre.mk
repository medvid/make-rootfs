pkg_ver  := 8.44
pkg_site := https://ftp.pcre.org/pub/pcre

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--disable-cpp \
	--enable-jit \
	--enable-utf8 \
	--without-pic

pkg_build := make

# Do not install the executables
pkg_install := make install-libLTLIBRARIES install-data DESTDIR=$(OUT_DIR)
