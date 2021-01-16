# https://repology.org/project/fribidi
# https://git.alpinelinux.org/aports/tree/main/fribidi/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libfribidi/libfribidi.mk
# https://github.com/distr1/distri/blob/master/pkgs/fribidi/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/fribidi/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/fribidi/template

pkg_ver  := 1.0.10
pkg_repo := https://github.com/fribidi/fribidi
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := $(meson_pkg_configure) \
	-Ddeprecated=false \
	-Ddocs=false \
	-Dtests=true \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
