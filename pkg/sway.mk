# https://repology.org/project/sway
# https://git.alpinelinux.org/aports/tree/community/sway/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/sway/template

pkg_ver  := 1.5.1
pkg_repo := https://github.com/swaywm/sway
pkg_url  := $(pkg_repo)/archive/$(pkg_ver).tar.gz
pkg_deps := json-c pcre wayland wayland-protocols libxkbcommon cairo pango pixman mesa libevdev libinput wlroots

pkg_configure := $(meson_pkg_configure) \
	--prefix=/usr \
	-Ddefault-wallpaper=false \
	-Dzsh-completions=false \
	-Dbash-completions=false \
	-Dfish-completions=false \
	-Dxwayland=disabled \
	-Dtray=disabled \
	-Dgdk-pixbuf=disabled \
	-Dman-pages=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install && \
	chmod a+x $(OUT_DIR)/usr/bin/sway
