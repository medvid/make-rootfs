# https://repology.org/project/extra-cmake-modules
# https://git.alpinelinux.org/aports/tree/community/extra-cmake-modules/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/extra-cmake-modules/template
# https://code.foxkit.us/adelie/packages/blob/master/user/extra-cmake-modules/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/extra-cmake-modules
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_TESTING:BOOL=FALSE \
	-DCMAKE_DISABLE_FIND_PACKAGE_Sphinx:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_QCollectionGenerator:BOOL=ON \
	-DBUILD_HTML_DOCS:BOOL=OFF \
	-DBUILD_MAN_DOCS:BOOL=OFF \
	-DBUILD_QTHELP_DOCS:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
