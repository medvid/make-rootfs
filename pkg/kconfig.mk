# https://repology.org/project/kconfig
# https://git.alpinelinux.org/aports/tree/community/kconfig/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kconfig/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kconfig/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kconfig
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DKCONFIG_USE_GUI:BOOL=ON \
	-DKCONFIG_USE_DBUS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
