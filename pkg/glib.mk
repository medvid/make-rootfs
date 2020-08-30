pkg_ver  := 2.64.5
pkg_repo := https://gitlab.gnome.org/GNOME/glib
pkg_site := https://download.gnome.org/sources/glib/$(basename $(pkg_ver))
pkg_deps := zlib pcre libffi

# Disable tests (gio/tests/meson.build defines shared modules)
pkg_prepare := sed -e '/^build_tests = /a build_tests = false' -i $(pkg_srcdir)/meson.build

pkg_configure := meson \
	--cross-file $(TARGET).txt \
	--prefix=/usr \
	--sysconfdir=/etc \
	--mandir=/usr/share/man \
	--localstatedir=/var \
	-Ddefault_library=static \
	-Dselinux=disabled \
	-Dxattr=false \
	-Dlibmount=disabled \
	-Dman=false \
	-Dnls=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
