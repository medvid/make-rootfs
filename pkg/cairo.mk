# https://repology.org/project/cairo
# https://git.alpinelinux.org/aports/tree/main/cairo/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/cairo/cairo.mk
# https://github.com/distr1/distri/blob/master/pkgs/cairo/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/cairo/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/cairo/template

pkg_ver  := 1.17.4
pkg_repo := https://gitlab.freedesktop.org/cairo/cairo
pkg_site := https://cairographics.org/snapshots
pkg_deps := libpng pixman freetype fontconfig

pkg_configure := $(meson_pkg_configure) \
	-Dfontconfig=enabled \
	-Dfreetype=enabled \
	-Dcogl=disabled \
	-Ddirectfb=disabled \
	-Dgl-backend=disabled \
	-Dgles2=disabled \
	-Dgles3=disabled \
	-Ddrm=disabled \
	-Dopenvg=disabled \
	-Dpng=enabled \
	-Dqt=disabled \
	-Dtee=disabled \
	-Dxcb=disabled \
	-Dxlib=disabled \
	-Dzlib=disabled \
	-Dtests=disabled \
	-Dgtk2-utils=disabled \
	-Dglib=disabled \
	-Dspectre=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
