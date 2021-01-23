# https://repology.org/project/libepoxy
# https://git.alpinelinux.org/aports/tree/main/libepoxy/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libepoxy/libepoxy.mk
# https://github.com/distr1/distri/blob/master/pkgs/libepoxy/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/libepoxy/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libepoxy/template

pkg_ver  := 1.5.5
pkg_repo := https://github.com/anholt/libepoxy
pkg_site := $(pkg_repo)/releases/download/$(pkg_ver)
pkg_deps := mesa

pkg_configure := $(meson_pkg_configure) \
	-Ddocs=false \
	-Degl=yes \
	-Dglx=no \
	-Dx11=false \
	-Dtests=true \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
