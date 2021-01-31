# https://repology.org/project/wayland
# https://git.alpinelinux.org/aports/tree/main/wayland/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/wayland/wayland.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/wayland/template

pkg_ver  := 1.19.0
pkg_repo := https://gitlab.freedesktop.org/wayland/wayland
pkg_site := https://wayland.freedesktop.org/releases
pkg_deps := libffi expat

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--enable-static \
	--disable-shared \
	--disable-documentation \
	--disable-dtd-validation \
	--without-pic

# Avoid dependency on host libwayland-bin during bootstrap
ifeq ($(CROSS),1)
pkg_configure += --with-host-scanner
endif

# Do not build test programs
pkg_build := make am__EXEEXT_2=

pkg_check := make test

pkg_install := make install DESTDIR=$(OUT_DIR) am__EXEEXT_2=
