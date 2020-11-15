pkg_ver  := 3.1c
pkg_repo := https://github.com/tmux/tmux
pkg_site := $(pkg_repo)/releases/download/$(pkg_ver)
pkg_deps := ncurses libevent

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--enable-static

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
