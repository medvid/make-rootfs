# https://repology.org/project/syntax-highlighting
# https://git.alpinelinux.org/aports/tree/community/syntax-highlighting/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/syntax-highlighting/template
# https://code.foxkit.us/adelie/packages/blob/master/user/syntax-highlighting/APKBUILD

pkg_ver  := 5.79.1
pkg_repo := https://invent.kde.org/frameworks/syntax-highlighting
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt5

pkg_configure := $(kde_pkg_configure) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DQRC_SYNTAX:BOOL=OFF \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
