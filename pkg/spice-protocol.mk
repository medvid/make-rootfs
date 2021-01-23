# https://repology.org/project/spice-protocol
# https://git.alpinelinux.org/aports/tree/main/spice-protocol/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/spice-protocol/spice-protocol.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/spice-protocol/template

pkg_ver  := 0.14.3
pkg_repo := https://gitlab.freedesktop.org/spice/spice-protocol
pkg_site := https://www.spice-space.org/download/releases

pkg_configure := $(meson_pkg_configure) \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
