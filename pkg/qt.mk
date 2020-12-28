pkg_ver  := 6.0.0
pkg_site := https://download.qt.io/archive/qt/$(basename $(pkg_ver))/$(pkg_ver)/single
pkg_base := qt-everywhere-src
pkg_deps := openssl pcre2 zlib zstd libpng freetype harfbuzz libudev-zero libevdev mtdev libinput libxkbcommon sqlite

pkg_configure := $(cmake_pkg_configure) \
	$(if $(STAGE),,-DQT_HOST_PATH=/usr) \
	-DBUILD_CMAKE_TESTING:BOOL=ON \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_WITH_PCH:BOOL=OFF \
	-DCMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE:BOOL=ON \
	-DQT_BUILD_EXAMPLES:BOOL=OFF \
	-DQT_BUILD_TESTS:BOOL=OFF \
	-DQT_BUILD_TOOLS_WHEN_CROSSCOMPILING:BOOL=OFF \
	-DQT_QMAKE_TARGET_MKSPEC:STRING=linux-clang-libc++ \
	-DQT_QPA_DEFAULT_PLATFORM:STRING=input \
	-DBUILD_qt3d:BOOL=OFF \
	-DBUILD_qt5compat:BOOL=ON \
	-DBUILD_qtbase:BOOL=ON \
	-DBUILD_qtconnectivity:BOOL=OFF \
	-DBUILD_qtdeclarative:BOOL=ON \
	-DBUILD_qtdoc:BOOL=OFF \
	-DBUILD_qtgamepad:BOOL=OFF \
	-DBUILD_qtgraphicaleffects:BOOL=OFF \
	-DBUILD_qtlocation:BOOL=OFF \
	-DBUILD_qtlottie:BOOL=OFF \
	-DBUILD_qtmacextras:BOOL=OFF \
	-DBUILD_qtmultimedia:BOOL=OFF \
	-DBUILD_qtnetworkauth:BOOL=OFF \
	-DBUILD_qtpurchasing:BOOL=OFF \
	-DBUILD_qtquick3d:BOOL=OFF \
	-DBUILD_qtquickcontrols:BOOL=OFF \
	-DBUILD_qtquickcontrols2:BOOL=OFF \
	-DBUILD_qtquicktimeline:BOOL=OFF \
	-DBUILD_qtremoteobjects:BOOL=OFF \
	-DBUILD_qtscript:BOOL=OFF \
	-DBUILD_qtscxml:BOOL=OFF \
	-DBUILD_qtsensors:BOOL=OFF \
	-DBUILD_qtserialbus:BOOL=OFF \
	-DBUILD_qtserialport:BOOL=OFF \
	-DBUILD_qtspeech:BOOL=OFF \
	-DBUILD_qtsvg:BOOL=ON \
	-DBUILD_qttools:BOOL=OFF \
	-DBUILD_qttranslations:BOOL=OFF \
	-DBUILD_qtvirtualkeyboard:BOOL=OFF \
	-DBUILD_qtwebchannel:BOOL=OFF \
	-DBUILD_qtwebengine:BOOL=OFF \
	-DBUILD_qtwebglplugin:BOOL=OFF \
	-DBUILD_qtwebsockets:BOOL=OFF \
	-DBUILD_qtwebview:BOOL=OFF \
	-DBUILD_qtwinextras:BOOL=OFF \
	-DBUILD_qtx11extras:BOOL=OFF \
	-DFEATURE_cups:BOOL=OFF \
	-DFEATURE_dbus:BOOL=OFF \
	-DFEATURE_directfb:BOOL=OFF \
	-DFEATURE_eglfs:BOOL=OFF \
	-DFEATURE_evdev:BOOL=ON \
	-DFEATURE_fontconfig:BOOL=ON \
	-DFEATURE_freetype:BOOL=ON \
	-DFEATURE_gbm:BOOL=OFF \
	-DFEATURE_gifBOOL=OFF \
	-DFEATURE_glib:BOOL=OFF \
	-DFEATURE_gtk3:BOOL=OFF \
	-DFEATURE_harfbuzz:BOOL=ON \
	-DFEATURE_ico:BOOL=OFF \
	-DFEATURE_icu:BOOL=OFF \
	-DFEATURE_kms:BOOL=OFF \
	-DFEATURE_libinput:BOOL=ON \
	-DFEATURE_libjpeg:BOOL=OFF \
	-DFEATURE_libpng:BOOL=ON \
	-DFEATURE_libproxy:BOOL=OFF \
	-DFEATURE_libudev:BOOL=ON \
	-DFEATURE_linuxfb:BOOL=ON \
	-DFEATURE_mtdev:BOOL=ON \
	-DFEATURE_pcre2:BOOL=ON \
	-DFEATURE_sql:BOOL=ON \
	-DFEATURE_sql_db2:BOOL=OFF \
	-DFEATURE_sql_db2:BOOL=OFF \
	-DFEATURE_sql_ibase:BOOL=OFF \
	-DFEATURE_sql_mysql:BOOL=OFF \
	-DFEATURE_sql_oci:BOOL=OFF \
	-DFEATURE_sql_odbc:BOOL=OFF \
	-DFEATURE_sql_psql:BOOL=OFF \
	-DFEATURE_sql_sqlite:BOOL=ON \
	-DFEATURE_sqlmodel:BOOL=ON \
	-DFEATURE_ssl:BOOL=ON \
	-DFEATURE_system_doubleconversion:BOOL=OFF \
	-DFEATURE_system_freetype:BOOL=ON \
	-DFEATURE_system_harfbuzz:BOOL=ON \
	-DFEATURE_system_pcre2:BOOL=ON \
	-DFEATURE_system_sqlite:BOOL=ON \
	-DFEATURE_system_zlib:BOOL=ON \
	-DFEATURE_tslib:BOOL=OFF \
	-DFEATURE_xcb:BOOL=OFF \
	-DFEATURE_xcb_xlib:BOOL=OFF \
	-DFEATURE_xkbcommon:BOOL=ON \
	-DINPUT_cups:BOOL=OFF \
	-DINPUT_dbus:BOOL=OFF \
	-DINPUT_dlopen:BOOL=ON \
	-DINPUT_doubleconversion:STRING=qt \
	-DINPUT_egl:BOOL=OFF \
	-DINPUT_eglfs:BOOL=OFF \
	-DINPUT_evdev:BOOL=ON \
	-DINPUT_fontconfig:BOOL=ON \
	-DINPUT_freetype:STRING=system \
	-DINPUT_gbm:BOOL=OFF \
	-DINPUT_gc_binaries:BOOL=ON \
	-DINPUT_gif:BOOL=OFF \
	-DINPUT_glib:BOOL=OFF \
	-DINPUT_gtk3:BOOL=OFF \
	-DINPUT_harfbuzz:STRING=system \
	-DINPUT_ico:BOOL=OFF \
	-DINPUT_icu:BOOL=OFF \
	-DINPUT_kms:BOOL=OFF \
	-DINPUT_libinput:BOOL=ON \
	-DINPUT_libjpeg:BOOL=no \
	-DINPUT_libpng:STRING=system \
	-DINPUT_library:BOOL=ON \
	-DINPUT_libudev:BOOL=ON \
	-DINPUT_linker:STRING=lld \
	-DINPUT_linuxfb:BOOL=ON \
	-DINPUT_mtdev:BOOL=ON \
	-DINPUT_opengl:STRING=no \
	-DINPUT_openssl:STRING=linked \
	-DINPUT_pcre:STRING=system \
	-DINPUT_pdf:BOOL=OFF \
	-DINPUT_reduce_exports:BOOL=OFF \
	-DINPUT_reduce_relocations:BOOL=OFF \
	-DINPUT_relocatable:BOOL=OFF \
	-DINPUT_rpath:BOOL=OFF \
	-DINPUT_ssl:BOOL=ON \
	-DINPUT_sysroot:PATH=$(OUT_DIR) \
	-DINPUT_system_sqlite:BOOL=ON \
	-DINPUT_system_zlib:BOOL=ON \
	-DINPUT_testlib:BOOL=OFF \
	-DINPUT_tslib:BOOL=OFF \
	-DINPUT_xcb:BOOL=OFF \
	-DINPUT_xcb_xlib:BOOL=OFF \
	-DINPUT_xkbcommon:BOOL=ON \
	-DINPUT_zstd:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ATSPI2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Cups:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_DB2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_DBus1:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_DirectFB:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_EGL:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GLESv2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GLESv2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GLIB2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GSSAPI:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GTK3:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ICU:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_JPEG:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LTTngUST:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libb2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libdrm:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libproxy:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Libsystemd:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_MySQL:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ODBC:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_OpenGL:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Oracle:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_PostgreSQL:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Qt6ODBus:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Qt6OpenGL:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Qt6OpenGLWidgets:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Slog2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Tslib:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Vulkan:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Waylandkms:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_WrapBrotli:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_WrapDBus1:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_WrapDoubleConversion:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_WrapOpenGL:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11_XCB:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_XCB:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_XComposite:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_XKB_COMMON_X11:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_XRender:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_double-conversion:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_gbm:BOOL=ON \
	$(pkg_srcdir)

pkg_build := ninja -v

pkg_install := DESTDIR=$(OUT_DIR) ninja -v install
