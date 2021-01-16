# https://repology.org/project/wayland-protocols
# https://git.alpinelinux.org/aports/tree/main/wayland-protocols/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/wayland-protocols/wayland-protocols.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/wayland-protocols/template

pkg_ver  := 1.20
pkg_repo := https://gitlab.freedesktop.org/wayland/wayland-protocols
pkg_site := https://wayland.freedesktop.org/releases

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--with-noarch-pkgconfigdir=/usr/lib/pkgconfig

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
