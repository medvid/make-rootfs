# https://repology.org/project/libinput
# https://git.alpinelinux.org/aports/tree/community/libinput/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libinput/libinput.mk
# https://github.com/distr1/distri/blob/master/pkgs/libinput/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/libinput/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libinput/template

pkg_ver  := 1.17.0
pkg_repo := https://gitlab.freedesktop.org/libinput/libinput
pkg_site := https://www.freedesktop.org/software/libinput
pkg_deps := libevdev mtdev libudev-zero check

pkg_prepare := sed -e "s/shared_library/library/g" -i $(pkg_srcdir)/meson.build

pkg_configure := $(meson_pkg_configure) \
	-Dlibwacom=false \
	-Ddebug-gui=false \
	-Dtests=true \
	-Ddocumentation=false \
	-Dzshcompletiondir=no \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
