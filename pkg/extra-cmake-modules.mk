pkg_ver  := 5.77.0
pkg_repo := https://invent.kde.org/frameworks/extra-cmake-modules
pkg_site := https://download.kde.org/stable/frameworks/$(basename $(pkg_ver))

pkg_configure := cmake -G Ninja $(pkg_srcdir) \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DBUILD_TESTING:BOOL=FALSE \
	-DCMAKE_DISABLE_FIND_PACKAGE_Sphinx:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_QCollectionGenerator:BOOL=ON \
	-DBUILD_HTML_DOCS:BOOL=OFF \
	-DBUILD_MAN_DOCS:BOOL=OFF \
	-DBUILD_QTHELP_DOCS:BOOL=OFF

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
