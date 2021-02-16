# https://repology.org/project/dbus
# https://git.alpinelinux.org/aports/tree/main/dbus/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/dbus/dbus.mk
# https://github.com/distr1/distri/blob/master/pkgs/dbus/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/dbus/template

pkg_ver  := 1.12.20
pkg_repo := https://gitlab.freedesktop.org/dbus/dbus
pkg_site := http://dbus.freedesktop.org/releases/dbus
pkg_deps := expat

pkg_configure := $(cmake_pkg_configure) \
	-DDBUS_BUILD_TESTS:BOOL=ON \
	-DDBUS_RELOCATABLE:BOOL=OFF \
	-DDBUS_DISABLE_ASSERT:BOOL=ON \
	-DDBUS_DISABLE_CHECKS:BOOL=ON \
	-DDBUS_ENABLE_VERBOSE_MODE:BOOL=ON \
	-DDBUS_ENABLE_STATS:BOOL=OFF \
	-DDBUS_BUS_ENABLE_INOTIFY:BOOL=ON \
	-DDBUS_ENABLE_DOXYGEN_DOCS:BOOL=OFF \
	-DDBUS_ENABLE_XML_DOCS:BOOL=OFF \
	-DDBUS_INSTALL_SYSTEM_LIBS:BOOL=ON \
	-DENABLE_TRADITIONAL_ACTIVATION:BOOL=ON \
	-DENABLE_SYSTEMD:BOOL=OFF \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GLib2:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GObject:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_xmlto:BOOL=ON \
	$(pkg_srcdir)/cmake

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install && \
	mkdir -p $(OUT_DIR)/etc/dbus-1 && \
	mv $(OUT_DIR)/usr/etc/dbus-1/* $(OUT_DIR)/etc/dbus-1/ && \
	rm -r $(OUT_DIR)/usr/etc
