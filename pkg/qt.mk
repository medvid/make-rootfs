pkg_ver  := 5.15.0
pkg_site  := https://download.qt.io/archive/qt/$(basename $(pkg_ver))/$(pkg_ver)/single
pkg_dir  := qt-everywhere-src
pkg_deps := zlib libpng freetype pcre harfbuzz

# https://doc.qt.io/qt-5.15/configure-options.html
pkg_configure := $(pkg_srcdir)/configure \
	-prefix /usr \
	-sysconfdir /etc \
	-verbose \
	-opensource \
	-confirm-license \
	-gc-binaries \
	-no-shared \
	-static \
	-platform linux-clang-libc++ \
	-no-rpath \
	-linker lld \
	-sysroot $(OUT_DIR) \
	-make-base \
	-no-gui \
	-no-widgets \
	-no-dbus \
	-no-accessibility \
	-qt-doubleconversion \
	-no-glib \
	-no-icu \
	-system-pcre \
	-system-zlib \
	-ssl \
	-openssl-linked \
	-no-cups \
	-fontconfig \
	-system-freetype \
	-system-harfbuzz \
	-no-gtk \
	-no-opengl \
	-no-egl \
	-qpa wayland \
	-no-xcb-xlib \
	-no-eglfs \
	-no-gbm \
	-no-kms \
	-no-linuxfb \
	-no-xcb \
	-no-libudev \
	-no-libevdev \
	-no-libinput \
	-no-mtdev \
	-no-tslib \
	-no-bundled-xcb-xinput \
	-no-xkbcommon \
	-no-gif \
	-no-ico \
	-system-libpng \
	-no-libjpeg \
	-qt-sqlite

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
