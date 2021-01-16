# https://repology.org/project/libxkbcommon
# https://git.alpinelinux.org/aports/tree/main/libxkbcommon/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libxkbcommon/libxkbcommon.mk
# https://github.com/distr1/distri/blob/master/pkgs/libxkbcommon/build.textproto
# https://github.com/kisslinux/repo/blob/master/xorg/libxkbcommon/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libxkbcommon/template

pkg_ver  := 1.0.3
pkg_repo := https://github.com/xkbcommon/libxkbcommon
pkg_site := https://xkbcommon.org/download
pkg_deps := wayland wayland-protocols xkeyboard-config

pkg_configure := $(meson_pkg_configure) \
	-Dxkb-config-root=/usr/share/X11/xkb \
	-Denable-x11=false \
	-Denable-docs=false \
	-Denable-wayland=false \
	-Denable-xkbregistry=false \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
