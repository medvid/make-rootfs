# https://repology.org/project/knewstuff
# https://git.alpinelinux.org/aports/tree/community/knewstuff/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/knewstuff/template
# https://code.foxkit.us/adelie/packages/blob/master/user/knewstuff/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/knewstuff
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 karchive kcompletion kconfig kcoreaddons ki18n \
	kiconthemes kio kitemviews kpackage kservice ktextwidgets kwidgetsaddons kxmlgui \
	attica kirigami2

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
