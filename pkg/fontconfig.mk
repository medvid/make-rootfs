pkg_ver  := 2.13.93
pkg_repo := https://gitlab.freedesktop.org/fontconfig/fontconfig
pkg_site := https://www.freedesktop.org/software/fontconfig/release
pkg_deps := expat freetype libuuid

pkg_configure := $(meson_pkg_configure) \
	-Ddoc=disabled \
	-Dnls=disabled \
	-Dtests=disabled \
	-Dtools=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
