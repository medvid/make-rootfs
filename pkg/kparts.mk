# https://repology.org/project/kparts
# https://git.alpinelinux.org/aports/tree/community/kparts/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kparts/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kparts/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kparts
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 kconfig kcoreaddons ki18n kiconthemes kio \
	kjobwidgets kservice ktextwidgets kwidgetsaddons kxmlgui

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
