pkg_ver  := 1.4.1
pkg_repo := https://github.com/rhash/RHash
pkg_url  := $(pkg_repo)/archive/v$(pkg_ver).tar.gz
pkg_dir  := RHash-$(pkg_ver)
pkg_copy := true
pkg_deps := openssl

pkg_configure := $(pkg_srcdir)/configure \
	--cc=$(CC) \
	--ar=$(AR) \
	--target=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-gettext \
	--enable-openssl \
	--enable-static \
	--enable-lib-static \
	--disable-lib-shared \
	--disable-symlinks \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LDFLAGS)"

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
