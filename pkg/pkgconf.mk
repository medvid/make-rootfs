pkg_ver  := 1.7.3
pkg_repo := https://git.sr.ht/~kaniini/pkgconf
pkg_site := https://distfiles.dereferenced.org/pkgconf

pkg_prepare := sed -e "s/shared_library/library/g" -i $(pkg_srcdir)/meson.build

pkg_configure := $(meson_pkg_configure) \
	-Dtests=false \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install && \
	ln -sf pkgconf $(OUT_DIR)/usr/bin/pkg-config
