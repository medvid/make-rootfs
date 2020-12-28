pkg_ver  := 1.17.4
pkg_repo := https://gitlab.freedesktop.org/cairo/cairo
pkg_site := https://cairographics.org/snapshots
pkg_deps := libpng pixman freetype fontconfig

pkg_configure := $(meson_pkg_configure) \
	-Dfontconfig=enabled \
	-Dfreetype=enabled \
	-Dpng=enabled \
	-Dtests=disabled \
	-Dglib=disabled \
	-Dspectre=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
