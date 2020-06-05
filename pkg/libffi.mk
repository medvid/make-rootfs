pkg_ver  := 3.3
pkg_repo := https://github.com/libffi/libffi
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--enable-portable-binary \
	--disable-docs \
	--disable-multi-os-directory \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
