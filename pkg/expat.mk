pkg_ver  := 2.2.9
pkg_repo := https://github.com/libexpat/libexpat
pkg_site := $(pkg_repo)/releases/download/R_$(subst .,_,$(pkg_ver))

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-xmlwf \
	--without-examples \
	--without-tests \
	--with-sys-getrandom \
	--without-docbook

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
