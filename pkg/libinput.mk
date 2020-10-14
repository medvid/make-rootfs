pkg_ver  := 1.16.2
pkg_repo := https://gitlab.freedesktop.org/libinput/libinput
pkg_site := https://www.freedesktop.org/software/libinput
pkg_deps := libevdev mtdev libudev-zero

pkg_prepare := sed -e "s/shared_library/library/g" -i $(pkg_srcdir)/meson.build

pkg_configure := $(meson_pkg_configure) \
	-Dlibwacom=false \
	-Ddebug-gui=false \
	-Dtests=false \
	-Ddocumentation=false \
	-Dzshcompletiondir=no \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
