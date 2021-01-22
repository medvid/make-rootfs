# https://repology.org/project/check
# https://git.alpinelinux.org/aports/tree/main/check/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/check/check.mk
# https://github.com/distr1/distri/blob/master/pkgs/check/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/check/template

pkg_ver  := 0.15.2
pkg_repo := https://github.com/libcheck/check
pkg_site := $(pkg_repo)/releases/download/$(pkg_ver)

pkg_configure := $(cmake_pkg_configure) \
	-DBUILD_TESTING:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja install
