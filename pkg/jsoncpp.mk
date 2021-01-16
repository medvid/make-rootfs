# https://repology.org/project/jsoncpp
# https://git.alpinelinux.org/aports/tree/community/jsoncpp/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/jsoncpp/jsoncpp.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/jsoncpp/template

pkg_ver  := 1.9.4
pkg_repo := https://github.com/open-source-parsers/jsoncpp
pkg_site := $(pkg_repo)/archive/$(pkg_ver)

pkg_configure := $(cmake_pkg_configure) \
	-DJSONCPP_WITH_TESTS:BOOL=ON \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_STATIC_LIBS:BOOL=ON \
	-DBUILD_OBJECT_LIBS:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
