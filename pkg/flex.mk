pkg_ver  := 2.6.4
pkg_repo := https://github.com/westes/flex
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_deps := bison

pkg_configure := $(pkg_srcdir)/configure \
	CC_FOR_BUILD=$(CC) \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-nls \
	--disable-shared \
	--disable-bootstrap

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
