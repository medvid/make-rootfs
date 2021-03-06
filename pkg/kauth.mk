# https://repology.org/project/kauth
# https://git.alpinelinux.org/aports/tree/community/kauth/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/kauth/template
# https://code.foxkit.us/adelie/packages/blob/master/user/kauth/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/kauth
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 dbus kcoreaddons

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DKAUTH_BACKEND_NAME:STRING="FAKE" \
	-DKAUTH_HELPER_BACKEND_NAME:STRING="FAKE" \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
