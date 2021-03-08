# https://repology.org/project/kate
# https://git.alpinelinux.org/aports/tree/community/kate/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kate/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kate/APKBUILD

pkg_ver  := 20.12.3
pkg_repo := https://invent.kde.org/utilities/kate
pkg_site := https://download.kde.org/stable/release-service/$(pkg_ver)/src
pkg_deps := extra-cmake-modules qt5 ki18n ktexteditor kwindowsystem kdbusaddons \
	kcrash knewstuff syntax-highlighting kitemviews kcoreaddons kguiaddons

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5DocTools:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5Activities:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5ItemModels:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5ThreadWeaver:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5Plasma:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_KUserFeedback:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
