# https://repology.org/project/kpty
# https://git.alpinelinux.org/aports/tree/community/kpty/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kpty/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kpty/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kpty
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 kcoreaddons ki18n

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_UTEMPTER:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
