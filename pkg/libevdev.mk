# https://repology.org/project/libevdev
# https://git.alpinelinux.org/aports/tree/community/libevdev/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libevdev/libevdev.mk
# https://github.com/distr1/distri/blob/master/pkgs/libevdev/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/libevdev/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libevdev/template

pkg_ver  := 1.10.1
pkg_repo := https://gitlab.freedesktop.org/libevdev/libevdev
pkg_site := https://www.freedesktop.org/software/libevdev

# tests depend on check tool (unpackaged)

pkg_configure := $(meson_pkg_configure) \
	-Dtests=disabled \
	-Ddocumentation=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
