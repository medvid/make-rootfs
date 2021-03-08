# https://repology.org/project/ksystemlog
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/ksystemlog/template
# https://code.foxkit.us/adelie/packages/blob/master/user/ksystemlog/APKBUILD

pkg_ver  := 20.12.2
pkg_repo := https://invent.kde.org/system/ksystemlog
pkg_site := https://download.kde.org/stable/release-service/$(pkg_ver)/src
pkg_deps := extra-cmake-modules qt5 kxmlgui kcoreaddons kwidgetsaddons \
	kitemviews kio kconfig karchive ki18n kcompletion ktextwidgets

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_DESIGNERPLUGIN:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_KF5DocTools:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Journald:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Audit:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
