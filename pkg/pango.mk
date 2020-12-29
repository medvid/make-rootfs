pkg_ver  := 1.48.0
pkg_repo := https://gitlab.gnome.org/GNOME/pango
pkg_site := https://ftp.gnome.org/pub/GNOME/sources/pango/$(basename $(pkg_ver))
pkg_deps := expat fontconfig cairo glib harfbuzz fribidi

pkg_configure := LDFLAGS="$(LDFLAGS) -lz -lpng -luuid -lexpat -lpcre -lpixman-1 -lffi" \
	$(meson_pkg_configure) \
	-Dgtk_doc=false \
	-Dintrospection=disabled \
	-Dfontconfig=enabled \
	-Dlibthai=disabled \
	-Dcairo=enabled \
	-Dxft=disabled \
	-Dfreetype=enabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
