# https://repology.org/project/libuev
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libuev/template

pkg_ver  := 2.3.2
pkg_repo := https://github.com/troglobit/libuev
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
