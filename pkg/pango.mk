pkg_ver  := 1.45.4
pkg_repo := https://gitlab.gnome.org/GNOME/pango
pkg_site := https://ftp.gnome.org/pub/GNOME/sources/pango/$(basename $(pkg_ver))
pkg_deps := expat fontconfig cairo glib harfbuzz

pkg_configure := meson \
	-Ddefault_library=static \
	-Dintrospection=false \
	-Dgtk_doc=false \
	--prefix=/usr \
	--sysconfdir=/etc \
	--mandir=/usr/share/man \
	--localstatedir=/var \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
