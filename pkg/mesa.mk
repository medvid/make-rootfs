# https://repology.org/project/mesa
# https://git.alpinelinux.org/aports/tree/main/mesa/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/mesa3d/mesa3d.mk
# https://github.com/distr1/distri/blob/master/pkgs/mesa/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/mesa/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/mesa/template

pkg_ver  := 20.3.4
pkg_repo := https://gitlab.freedesktop.org/mesa/mesa
pkg_site := https://mesa.freedesktop.org/archive
pkg_deps := libdrm libudev-zero wayland wayland-protocols zstd

# TODO: figure out how to parse from NM and patch properly
pkg_prepare := find -L $(pkg_srcdir) -name meson.build \
	-exec sed -e "s/'nm'/'llvm-nm'/g" -e "s/shared_library/library/g" -i {} \;

pkg_configure := $(meson_pkg_configure) \
	-Dplatforms=wayland \
	-Ddri3=disabled \
	-Ddri-drivers=[] \
	-Dgallium-drivers=swrast \
	-Dgallium-vdpau=disabled \
	-Dgallium-xvmc=disabled \
	-Dgallium-omx=disabled \
	-Dgallium-va=disabled \
	-Dgallium-xa=disabled \
	-Dvulkan-drivers=[] \
	-Dshared-glapi=enabled \
	-Dgles1=disabled \
	-Dgles2=enabled \
	-Dopengl=true \
	-Dgbm=enabled \
	-Dglx=disabled \
	-Degl=enabled \
	-Dglvnd=false \
	-Dllvm=disabled \
	-Dshared-llvm=disabled \
	-Dvalgrind=disabled \
	-Dlibunwind=disabled \
	-Dlmsensors=disabled \
	-Dshared-swr=false \
	-Dxlib-lease=disabled \
	-Dzstd=enabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
