# https://repology.org/project/kinit
# https://git.alpinelinux.org/aports/tree/community/kinit/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kinit/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kinit/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kinit
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 kservice kio ki18n kwindowsystem kcrash kconfig \
	kdbusaddons

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5DocTools:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_XCB:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libcap:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
