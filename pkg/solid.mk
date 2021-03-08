# https://repology.org/project/solid-hardware-abstraction
# https://git.alpinelinux.org/aports/tree/community/solid/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/ksolid/template
# https://code.foxkit.us/adelie/packages/blob/master/user/solid/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/solid
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 libudev-zero

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_IMobileDevice:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_PList:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_MediaPlayerInfo:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
