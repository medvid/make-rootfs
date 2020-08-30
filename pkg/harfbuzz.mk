pkg_ver  := 2.7.1
pkg_repo := https://github.com/harfbuzz/harfbuzz
pkg_url  := $(pkg_repo)/archive/$(pkg_ver).tar.gz
pkg_deps := freetype fontconfig cairo glib

# TODO: check why Requires.private is not parsed from fontconfig.pc
pkg_configure := LDFLAGS="$(LDFLAGS) -lz -lpng -lexpat -luuid -lfontconfig -lpixman-1" meson \
	--cross-file $(TARGET).txt \
	--prefix=/usr \
	--sysconfdir=/etc \
	-Ddefault_library=static \
	-Dglib=enabled \
	-Dgobject=disabled \
	-Dcairo=enabled \
	-Dfontconfig=enabled \
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
