# https://repology.org/project/konsole
# https://git.alpinelinux.org/aports/tree/community/konsole/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/konsole/template
# https://code.foxkit.us/adelie/packages/blob/master/user/konsole/APKBUILD

pkg_ver  := 20.12.3
pkg_repo := https://invent.kde.org/utilities/konsole
pkg_site := https://download.kde.org/stable/release-service/$(pkg_ver)/src
pkg_deps := extra-cmake-modules qt5 kbookmarks kcompletion kconfig kconfigwidgets \
	kcoreaddons kcrash kguiaddons kdbusaddons ki18n kiconthemes kinit kio \
	knewstuff knotifications knotifyconfig kparts kpty kservice ktextwidgets \
	kwidgetsaddons kwindowsystem kxmlgui kglobalaccel

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5DocTools:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
