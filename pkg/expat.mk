# https://repology.org/project/expat
# https://git.alpinelinux.org/aports/tree/main/expat/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/expat/expat.mk
# https://github.com/distr1/distri/blob/master/pkgs/expat/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/expat/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/expat/template

pkg_ver  := 2.2.10
pkg_repo := https://github.com/libexpat/libexpat
pkg_site := $(pkg_repo)/releases/download/R_$(subst .,_,$(pkg_ver))

pkg_configure := $(cmake_pkg_configure) \
	-DEXPAT_BUILD_EXAMPLES:BOOL=OFF \
	-DEXPAT_BUILD_TESTS:BOOL=ON \
	-DEXPAT_SHARED_LIBS:BOOL=OFF \
	-DEXPAT_BUILD_DOCS:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
