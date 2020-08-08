pkg_ver  := 5.15.0
pkg_site := https://download.qt.io/archive/qt/$(basename $(pkg_ver))/$(pkg_ver)/single
pkg_base := qt-everywhere-src
pkg_deps := pcre2 zlib zstd libpng freetype harfbuzz libudev-zero libevdev mtdev libinput libxkbcommon sqlite

# https://doc.qt.io/qt-5.15/configure-options.html
pkg_configure := $(pkg_srcdir)/configure \
	-prefix /usr \
	-sysconfdir /etc \
	-verbose \
	-opensource \
	-confirm-license \
	-release \
	-gc-binaries \
	-static \
	-platform linux-clang-libc++ \
	-no-rpath \
	-no-reduce-exports \
	-no-reduce-relocations \
	-no-pch \
	-linker lld \
	-sysroot $(OUT_DIR) \
	-no-compile-examples \
	-nomake examples \
	-skip qt3d \
	-skip qtmultimedia \
	-skip qtwebchannel \
	-skip qtwebengine \
	-skip qtwebglplugin \
	-skip qtwebsockets \
	-skip qtwebview \
	-no-dbus \
	-qt-doubleconversion \
	-no-glib \
	-no-icu \
	-system-pcre \
	-system-zlib \
	-zstd \
	-no-ssl \
	-no-openssl \
	-no-cups \
	-fontconfig \
	-system-freetype \
	-system-harfbuzz \
	-no-gtk \
	-no-opengl \
	-no-egl \
	-qpa input \
	-no-xcb-xlib \
	-no-eglfs \
	-no-gbm \
	-no-kms \
	-no-xcb \
	-libudev \
	-evdev \
	-libinput \
	-mtdev \
	-no-tslib \
	-xkbcommon \
	-no-gif \
	-no-ico \
	-system-libpng \
	-no-libjpeg \
	-system-sqlite \
	-no-feature-testlib \
	-no-feature-dlopen \
	-no-feature-relocatable \
	-no-feature-pdf \
	-no-feature-qdbus \
	-feature-linuxfb \
	no-feature-gnu-libiconv

pkg_build := make AR="llvm-ar cqs"

pkg_install := make install DESTDIR=$(OUT_DIR)
