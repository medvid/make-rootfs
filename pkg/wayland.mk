pkg_ver  := 1.18.0
pkg_repo := https://gitlab.freedesktop.org/wayland/wayland
pkg_site := https://wayland.freedesktop.org/releases
pkg_deps := libffi expat

# TODO: figure out how to parse from NM and patch properly
pkg_prepare := sed -e "s/'nm'/'llvm-nm'/g" -i $(pkg_srcdir)/egl/meson.build && \
	sed -e "/'tests'/s/^\t/\t\#/" -i $(pkg_srcdir)/meson.build

pkg_configure := $(meson_pkg_configure) \
	-Ddocumentation=false \
	-Ddtd_validation=false \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
