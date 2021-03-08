# https://repology.org/project/kio
# https://git.alpinelinux.org/aports/tree/community/kio/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kio/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kio/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kio
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 karchive kconfig kcrash kdbusaddons ki18n \
	kservice solid kbookmarks kcompletion kconfigwidgets kiconthemes kitemviews \
	kjobwidgets kwidgetsaddons kwindowsystem kded kauth kwallet ktextwidgets

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_DESIGNERPLUGIN:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5DocTools:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5Notifications:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GSSAPI:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ACL:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
