# https://repology.org/project/qt
# https://git.alpinelinux.org/aports/tree/community/qt5-qtbase/APKBUILD
# https://github.com/distr1/distri/blob/master/pkgs/qt/build.textproto
# https://github.com/kisslinux/community/blob/master/community/qt5/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/qt5/template

pkg_ver  := 5.15.2
pkg_site := https://download.qt.io/archive/qt/$(basename $(pkg_ver))/$(pkg_ver)/single
pkg_base := qt-everywhere-src
pkg_deps := dbus libpng libjpeg-turbo openssl pcre2 sqlite zlib zstd freetype harfbuzz libudev-zero libevdev mtdev libinput libxkbcommon mesa wayland

# https://doc.qt.io/qt-5.15/configure-options.html
pkg_configure := $(pkg_srcdir)/configure \
	-prefix /usr/lib/qt5 \
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
	-skip qtlocation \
	-skip qtwebengine \
	-dbus-linked \
	-qt-doubleconversion \
	-no-glib \
	-no-icu \
	-system-pcre \
	-system-zlib \
	-zstd \
	-ssl \
	-openssl-linked \
	-no-cups \
	-fontconfig \
	-system-freetype \
	-system-harfbuzz \
	-no-gtk \
	-opengl es2 \
	-egl \
	-qpa wayland \
	-no-xcb-xlib \
	-no-eglfs \
	-gbm \
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
	-system-libjpeg \
	-system-sqlite \
	-feature-testlib \
	-feature-dlopen \
	-feature-library \
	-no-feature-relocatable \
	-feature-pdf \
	-feature-linuxfb \
	-no-feature-gnu-libiconv

ifeq ($(CROSS),1)
	pkg_configure += -hostprefix /usr/lib/qt5
endif

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR) STRIP="llvm-strip"
