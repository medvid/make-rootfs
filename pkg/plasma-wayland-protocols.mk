# https://repology.org/project/plasma-wayland-protocols
# https://git.alpinelinux.org/aports/tree/community/plasma-wayland-protocols/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/plasma-wayland-protocols/template
# https://code.foxkit.us/adelie/packages/blob/master/user/plasma-wayland-protocols/APKBUILD

pkg_ver  := 1.1.1
pkg_repo := https://invent.kde.org/libraries/plasma-wayland-protocols
pkg_site := https://download.kde.org/stable/plasma-wayland-protocols/$(pkg_ver)
pkg_deps := extra-cmake-modules

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
