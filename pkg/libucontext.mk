# https://repology.org/project/libucontext
# https://git.alpinelinux.org/aports/tree/main/libucontext/APKBUILD
# https://code.foxkit.us/adelie/packages/-/blob/master/system/libucontext/APKBUILD

pkg_ver  := 1.0
pkg_repo := https://github.com/kaniini/libucontext
pkg_site := https://distfiles.dereferenced.org/libucontext

# TODO: add to meson.build
pkg_prepare := mkdir -p $(pkg_srcdir)/include/libucontext && \
	cp -v $(pkg_srcdir)/arch/common/bits.h $(pkg_srcdir)/include/libucontext/

pkg_configure := $(meson_pkg_configure) \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
