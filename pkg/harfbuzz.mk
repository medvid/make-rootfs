pkg_ver  := 2.7.4
pkg_repo := https://github.com/harfbuzz/harfbuzz
pkg_url  := $(pkg_repo)/archive/$(pkg_ver).tar.gz
pkg_deps := freetype cairo

pkg_configure := $(meson_pkg_configure) \
	-Dglib=disabled \
	-Dgobject=disabled \
	-Dcairo=enabled \
	-Dfontconfig=disabled \
	-Dicu=disabled \
	-Dgraphite=disabled \
	-Dfreetype=enabled \
	-Dtests=disabled \
	-Dintrospection=disabled \
	-Ddocs=disabled \
	-Dbenchmark=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
