pkg_ver  := 3.8.5
pkg_repo := https://github.com/python/cpython
pkg_site := https://www.python.org/ftp/python/$(pkg_ver)
pkg_base := Python
pkg_deps := zlib libffi libressl expat

pkg_prepare := mkdir -p Modules && cp -v $(pkg_files)/Setup.local Modules

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-shared \
	--disable-ipv6 \
	--with-system-expat \
	--with-system-ffi \
	--without-ensurepip \
	ac_cv_func_dlopen=no \
	ac_cv_file__dev_ptmx=no \
	ac_cv_file__dev_ptc=no \
	ax_cv_c_float_words_bigendian=no # https://bugs.gentoo.org/700012

pkg_build := make LINKFORSHARED= EXTRA_CFLAGS="$(CFLAGS) -DTHREAD_STACK_SIZE=0x100000"

pkg_install := make install DESTDIR=$(OUT_DIR)
