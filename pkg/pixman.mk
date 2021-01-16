# https://repology.org/project/pixman
# https://git.alpinelinux.org/aports/tree/main/pixman/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/pixman/pixman.mk
# https://github.com/distr1/distri/blob/master/pkgs/pixman/build.textproto
# https://github.com/kisslinux/repo/blob/master/xorg/pixman/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/pixman/template

pkg_ver  := 0.40.0
pkg_repo := https://gitlab.freedesktop.org/pixman/pixman
pkg_site := https://www.cairographics.org/releases

pkg_configure := LDFLAGS="$(LDFLAGS) -Wl,-z,stack-size=2097152" \
	$(meson_pkg_configure) \
	-Darm-simd=disabled \
	-Dneon=disabled \
	-Diwmmxt=disabled \
	-Dgnu-inline-asm=disabled \
	-Dopenmp=disabled \
	-Dgtk=disabled \
	-Dlibpng=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
