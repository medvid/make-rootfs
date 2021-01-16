# https://repology.org/project/glib
# https://git.alpinelinux.org/aports/tree/main/glib/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libglib2/libglib2.mk
# https://github.com/distr1/distri/blob/master/pkgs/glib/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/glib/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/glib/template

pkg_ver  := 2.66.4
pkg_repo := https://gitlab.gnome.org/GNOME/glib
pkg_site := https://download.gnome.org/sources/glib/$(basename $(pkg_ver))
pkg_deps := zlib pcre libffi

# Disable tests (gio/tests/meson.build defines shared modules)
pkg_prepare := sed -e '/^build_tests = /a build_tests = false' -i $(pkg_srcdir)/meson.build

pkg_configure := $(meson_pkg_configure) \
	-Dselinux=disabled \
	-Dxattr=false \
	-Dlibmount=disabled \
	-Dman=false \
	-Dnls=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
