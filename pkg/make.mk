pkg_ver  := 4.3
pkg_repo := https://git.savannah.gnu.org/git/make
pkg_site := https://ftp.gnu.org/gnu/make

# TODO: why musl glob_t is picked?
pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-nls \
	--without-guile \
	make_cv_sys_gnu_glob=no

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
