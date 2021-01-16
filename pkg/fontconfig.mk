# https://repology.org/project/fontconfig
# https://git.alpinelinux.org/aports/tree/main/fontconfig/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/fontconfig/fontconfig.mk
# https://github.com/distr1/distri/blob/master/pkgs/fontconfig/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/fontconfig/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/fontconfig/template

pkg_ver  := 2.13.93
pkg_repo := https://gitlab.freedesktop.org/fontconfig/fontconfig
pkg_site := https://www.freedesktop.org/software/fontconfig/release
pkg_deps := expat freetype libuuid

pkg_configure := $(meson_pkg_configure) \
	-Ddoc=disabled \
	-Dnls=disabled \
	-Dtests=enabled \
	-Dtools=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := rm -rf $(OUT_DIR)/etc/fonts/conf.d && \
	DESTDIR=$(OUT_DIR) ninja install
