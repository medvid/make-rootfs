# https://repology.org/project/phonon
# https://git.alpinelinux.org/aports/tree/community/phonon/APKBUILD
# https://code.foxkit.us/adelie/packages/blob/master/user/phonon/APKBUILD

pkg_ver  := 4.11.1
pkg_repo := https://invent.kde.org/libraries/phonon
pkg_site := http://download.kde.org/stable/phonon/$(pkg_ver)
pkg_deps := extra-cmake-modules qt5

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DPHONON_BUILD_EXPERIMENTAL:BOOL=OFF \
	-DPHONON_BUILD_DEMOS:BOOL=OFF \
	-DPHONON_BUILD_DESIGNER_PLUGIN:BOOL=OFF \
	-DPHONON_BUILD_DOC:BOOL=OFF \
	-DPHONON_BUILD_SETTINGS:BOOL=OFF \
	-DPHONON_NO_PLATFORMPLUGIN:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Designer:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_PulseAudio:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GLIB2:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
