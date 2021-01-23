# https://repology.org/project/liburing
# https://git.alpinelinux.org/aports/tree/main/liburing/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/liburing/template

pkg_ver  := 0.7
pkg_repo := https://git.kernel.dk/liburing
pkg_site := https://git.kernel.dk/cgit/liburing/snapshot
pkg_deps := libucontext
pkg_copy := true

pkg_vars := V=1 ENABLE_SHARED=0 CFLAGS="$(CFLAGS) -Wl,-lucontext"

pkg_configure := $(pkg_srcdir)/configure \
	--prefix=/usr

pkg_build := make

pkg_check := make test

pkg_install := make install DESTDIR=$(OUT_DIR)
