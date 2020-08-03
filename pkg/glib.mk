pkg_ver  := 2.64.4
pkg_repo := https://gitlab.gnome.org/GNOME/glib
pkg_site := https://download.gnome.org/sources/glib/$(basename $(pkg_ver))
pkg_deps := zlib pcre libffi

pkg_configure := meson \
	-Ddefault_library=static \
	-Dselinux=disabled \
	-Dxattr=false \
	-Dlibmount=disabled \
	-Dman=false \
	-Dnls=disabled \
	--prefix=/usr \
	--sysconfdir=/etc \
	--mandir=/usr/share/man \
	--localstatedir=/var \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
