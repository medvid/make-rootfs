# https://repology.org/project/kwindowsystem
# https://git.alpinelinux.org/aports/tree/community/kwindowsystem/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kwindowsystem/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kwindowsystem/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kcodecs
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DKWINDOWSYSTEM_NO_WIDGETS:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
