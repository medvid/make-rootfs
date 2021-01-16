# https://repology.org/project/make
# https://git.alpinelinux.org/aports/tree/main/make/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/make/make.mk
# https://github.com/distr1/distri/blob/master/pkgs/make/build.textproto
# https://github.com/kisslinux/repo/blob/master/core/make/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/make/template

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

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
