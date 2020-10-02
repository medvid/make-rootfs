pkg_ver  := 3.1.6
pkg_repo := https://git.yzena.com/gavin/bc
pkg_site := https://github.com/gavinhoward/bc/releases/download/$(pkg_ver)
pkg_copy := true

pkg_configure := $(pkg_objdir)/configure \
	--prefix=/usr \
	--disable-nls \
	--disable-man-pages

pkg_build := make MAKEFLAGS=

pkg_install := make install DESTDIR=$(OUT_DIR)
