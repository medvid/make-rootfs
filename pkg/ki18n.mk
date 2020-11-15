pkg_ver  := 5.75.0
pkg_repo := https://invent.kde.org/frameworks/ki18n
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))
pkg_deps := extra-cmake-modules qt

pkg_configure := cmake -G Ninja $(pkg_srcdir) \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DCMAKE_INSTALL_LIBDIR:STRING=lib \
	-DCMAKE_SYSROOT=$(OUT_DIR) \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_QCH:BOOL=OFF \
	-DENABLE_INOTIFY:BOOL=OFF \
	-DENABLE_PROCSTAT:BOOL=OFF

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
