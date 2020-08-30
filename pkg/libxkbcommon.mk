pkg_ver  := 0.10.0
pkg_repo := https://github.com/xkbcommon/libxkbcommon
pkg_site := https://xkbcommon.org/download
pkg_deps := wayland wayland-protocols xkeyboard-config

pkg_configure := $(meson_pkg_configure) \
	-Dxkb-config-root=/usr/share/X11/xkb \
	-Denable-x11=false \
	-Denable-docs=false \
	-Denable-xkbregistry=false \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
