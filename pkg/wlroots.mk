# https://repology.org/project/wlroots
# https://git.alpinelinux.org/aports/tree/community/wlroots/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/wlroots/wlroots.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/wlroots/template

pkg_ver  := 0.12.0
pkg_repo := https://github.com/swaywm/wlroots
pkg_url  := $(pkg_repo)/archive/$(pkg_ver).tar.gz
pkg_deps := seatd libudev-zero libinput libxkbcommon mesa pixman wayland wayland-protocols xkeyboard-config

pkg_configure := $(meson_pkg_configure) \
	--prefix=/usr \
	-Dlogind=disabled \
	-Dlibseat=enabled \
	-Dxcb-errors=disabled \
	-Dxcb-icccm=disabled \
	-Dxwayland=disabled \
	-Dx11-backend=disabled \
	-Dexamples=false \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
