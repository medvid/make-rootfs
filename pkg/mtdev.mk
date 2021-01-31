# https://repology.org/project/mtdev
# https://git.alpinelinux.org/aports/tree/community/mtdev/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/mtdev/mtdev.mk
# https://github.com/distr1/distri/blob/master/pkgs/mtdev/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/mtdev/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/mtdev/template

pkg_ver  := 1.1.6
pkg_site := http://bitmath.org/code/mtdev

pkg_prepare := cp -v $(ROOT_DIR)/$(PKG_DIR)/files/config.sub \
	$(pkg_srcdir)/config-aux/config.sub

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	rm -f $(OUT_DIR)/usr/bin/mtdev-test
