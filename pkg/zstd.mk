pkg_ver  := 1.4.5
pkg_repo := https://github.com/facebook/zstd
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := meson \
	--prefix=/usr \
	--sysconfdir=/etc \
	-Ddefault_library=static \
	-Dbin_programs=false \
	-Dzlib=disabled \
	-Dlzma=disabled \
	-Dlz4=disabled \
	$(pkg_srcdir)/build/meson $(pkg_objdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
