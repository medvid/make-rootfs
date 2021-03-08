# https://repology.org/project/karchive
# https://git.alpinelinux.org/aports/tree/community/karchive/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/karchive/template
# https://code.foxkit.us/adelie/packages/blob/master/user/karchive/APKBUILD

pkg_ver  := 5.79.0
pkg_repo := https://invent.kde.org/frameworks/karchive
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5 zlib bzip2 xz

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
