# https://repology.org/project/pango
# https://git.alpinelinux.org/aports/tree/main/pango/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/pango/pango.mk
# https://github.com/distr1/distri/blob/master/pkgs/pango/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/pango/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/pango/template

pkg_ver  := 1.48.2
pkg_repo := https://gitlab.gnome.org/GNOME/pango
pkg_site := https://ftp.gnome.org/pub/GNOME/sources/pango/$(basename $(pkg_ver))
pkg_deps := expat fontconfig cairo glib harfbuzz fribidi

pkg_configure := LDFLAGS="$(LDFLAGS) -lc -lz -lpng -luuid -lexpat -lpcre -lpixman-1 -lffi" \
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

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
