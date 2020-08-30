pkg_ver  := 1.9.1
pkg_repo := https://gitlab.freedesktop.org/libevdev/libevdev
pkg_site := https://www.freedesktop.org/software/libevdev

pkg_configure := meson \
	--cross-file $(TARGET).txt \
	--prefix=/usr \
	--sysconfdir=/etc \
	--mandir=/usr/share/man \
	--localstatedir=/var \
	-Ddefault_library=static \
	-Dtests=disabled \
	-Ddocumentation=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
