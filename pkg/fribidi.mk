pkg_ver  := 1.0.10
pkg_repo := https://github.com/fribidi/fribidi
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := meson \
	--cross-file $(TARGET).txt \
	--prefix=/usr \
	--sysconfdir=/etc \
	-Ddefault_library=static \
	-Ddeprecated=false \
	-Ddocs=false \
	-Dtests=false \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
