pkg_ver  := 1.47.0
pkg_repo := https://gitlab.gnome.org/GNOME/pango
pkg_site := https://ftp.gnome.org/pub/GNOME/sources/pango/$(basename $(pkg_ver))
pkg_deps := expat fontconfig cairo glib harfbuzz fribidi

pkg_configure := LDFLAGS="$(LDFLAGS) -lpng -luuid -lexpat -lpixman-1" \
	$(meson_pkg_configure) \
	-Dintrospection=false \
	-Dgtk_doc=false \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
