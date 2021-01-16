# https://repology.org/project/bc-gh
# https://git.alpinelinux.org/aports/tree/testing/howard-bc/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/bc-gh/template
# https://code.foxkit.us/adelie/packages/-/blob/master/system/bc/APKBUILD

pkg_ver  := 3.2.4
pkg_repo := https://git.yzena.com/gavin/bc
pkg_site := https://github.com/gavinhoward/bc/releases/download/$(pkg_ver)
pkg_copy := true

pkg_configure := $(pkg_objdir)/configure \
	--prefix=/usr \
	--disable-nls \
	--disable-man-pages

pkg_build := make MAKEFLAGS=

pkg_check := make test

pkg_install := make install DESTDIR=$(OUT_DIR)
