# https://repology.org/project/slang
# https://git.alpinelinux.org/aports/tree/main/slang/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/slang/slang.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/slang/template

pkg_ver  := 2.3.2
pkg_site := https://www.jedsoft.org/releases/slang
pkg_deps := zlib pcre
pkg_copy := true

pkg_configure := $(pkg_objdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--without-readline \
	--without-x \
	--with-pcre \
	--without-onig \
	--without-png \
	--with-z

pkg_build := make static AR_CR="llvm-ar cr"

pkg_install := make install-static DESTDIR=$(OUT_DIR)
