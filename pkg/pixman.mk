pkg_ver  := 0.40.0
pkg_repo := https://gitlab.freedesktop.org/pixman/pixman
pkg_site := https://www.cairographics.org/releases

pkg_configure := LDFLAGS="$(LDFLAGS) -Wl,-z,stack-size=2097152" meson \
	--cross-file $(TARGET).txt \
	--prefix=/usr \
	--sysconfdir=/etc \
	--mandir=/usr/share/man \
	--localstatedir=/var \
	--buildtype=plain \
	-Ddefault_library=static \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
