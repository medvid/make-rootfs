# https://repology.org/project/xkeyboard-config
# https://git.alpinelinux.org/aports/tree/main/xkeyboard-config/APKBUILD
# https://github.com/distr1/distri/blob/master/pkgs/xkeyboard-config/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/xkeyboard-config/template

pkg_ver  := 2.31
pkg_repo := https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config
pkg_site := http://www.x.org/releases/individual/data/xkeyboard-config

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-runtime-deps \
	--disable-nls \
	--without-xsltproc

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
