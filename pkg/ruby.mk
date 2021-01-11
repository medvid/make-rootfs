pkg_ver  := 3.0.0
pkg_repo := https://github.com/ruby/ruby
pkg_site := https://cache.ruby-lang.org/pub/ruby/$(basename $(pkg_ver))
pkg_deps := openssl libedit zlib

pkg_prepare := mkdir -p ext && cp -v $(pkg_files)/Setup.local ext

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--enable-static \
	--disable-shared \
	--disable-pie \
	--disable-install-doc \
	--disable-install-rdoc \
	--disable-install-capi \
	--disable-install-static-library \
	--disable-dln \
	--enable-openssl \
	--enable-libedit \
	--enable-zlib \
	--without-git \
	--without-gcc \
	--without-gmp \
	--without-valgrind \
	--with-static-linked-ext \
	--with-setup=Setup.local

pkg_build := make V=1

pkg_install := make install DESTDIR=$(OUT_DIR)
