# https://repology.org/project/libdrm
# https://git.alpinelinux.org/aports/tree/main/libdrm/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libdrm/libdrm.mk
# https://github.com/distr1/distri/blob/master/pkgs/libdrm/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/libdrm/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libdrm/template

pkg_ver  := 2.4.104
pkg_repo := https://gitlab.freedesktop.org/mesa/drm
pkg_site := https://dri.freedesktop.org/libdrm
pkg_deps := libudev-zero

# TODO: -Dintel=true requires libpciaccess
pkg_configure := $(meson_pkg_configure) \
	-Dlibkms=true \
	-Dintel=false \
	-Dradeon=true \
	-Damdgpu=true \
	-Dnouveau=true \
	-Dvmwgfx=true \
	-Domap=false \
	-Dexynos=false \
	-Dfreedreno=false \
	-Dtegra=false \
	-Dvc4=false \
	-Detnaviv=false \
	-Dcairo-tests=false \
	-Dman-pages=false \
	-Dvalgrind=false \
	-Dudev=true \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
