# https://repology.org/project/kxmlgui
# https://git.alpinelinux.org/aports/tree/community/kxmlgui/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kxmlgui/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kxmlgui/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kxmlgui
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 kcoreaddons kitemviews kconfig kconfigwidgets \
	kguiaddons ki18n kiconthemes kwidgetsaddons attica

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DFORCE_DISABLE_KGLOBALACCEL:BOOL=ON \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_DESIGNERPLUGIN:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
