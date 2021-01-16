# https://repology.org/project/harfbuzz
# https://git.alpinelinux.org/aports/tree/main/harfbuzz/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/harfbuzz/harfbuzz.mk
# https://github.com/distr1/distri/blob/master/pkgs/harfbuzz/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/freetype-harfbuzz/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/harfbuzz/template

pkg_ver  := 2.7.4
pkg_repo := https://github.com/harfbuzz/harfbuzz
pkg_url  := $(pkg_repo)/archive/$(pkg_ver).tar.gz
pkg_deps := freetype cairo

pkg_configure := $(meson_pkg_configure) \
	-Dglib=disabled \
	-Dgobject=disabled \
	-Dcairo=enabled \
	-Dfontconfig=disabled \
	-Dicu=disabled \
	-Dgraphite=disabled \
	-Dfreetype=enabled \
	-Dtests=enabled \
	-Dintrospection=disabled \
	-Ddocs=disabled \
	-Dbenchmark=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
