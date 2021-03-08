# https://repology.org/project/ki18n
# https://git.alpinelinux.org/aports/tree/community/ki18n/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/ki18n/template
# https://code.foxkit.us/adelie/packages/blob/master/user/ki18n/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/ki18n
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 gettext-tiny

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_WITH_QML:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DENABLE_INOTIFY:BOOL=OFF \
	-DENABLE_PROCSTAT:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
