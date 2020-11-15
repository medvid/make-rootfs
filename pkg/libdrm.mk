pkg_ver  := 2.4.103
pkg_repo := https://gitlab.freedesktop.org/mesa/drm
pkg_site := https://dri.freedesktop.org/libdrm
pkg_deps := libudev-zero

# TODO: figure out how to parse from NM and patch properly
pkg_prepare := find -L $(pkg_srcdir) -name meson.build \
	-exec sed -e "s/'nm'/'llvm-nm'/g" -e "s/shared_library/library/g" -i {} \;

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

pkg_install := DESTDIR=$(OUT_DIR) ninja install
