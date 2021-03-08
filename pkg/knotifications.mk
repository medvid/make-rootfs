# https://repology.org/project/knotifications
# https://git.alpinelinux.org/aports/tree/community/knotifications/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/knotifications/template
# https://code.foxkit.us/adelie/packages/blob/master/user/knotifications/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/knotifications
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 kwindowsystem kconfig kcoreaddons phonon

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_Qt5TextToSpeech:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Canberra:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
