# https://repology.org/project/meson
# https://git.alpinelinux.org/aports/tree/main/meson/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/meson/meson.mk
# https://github.com/distr1/distri/blob/master/pkgs/meson/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/meson/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/meson/template

pkg_ver  := 0.56.2
pkg_repo := https://github.com/mesonbuild/meson
pkg_site := $(pkg_repo)/releases/download/$(pkg_ver)
pkg_copy := true
pkg_deps := setuptools

pkg_build := $(PYTHON) setup.py build

pkg_install := $(PYTHON) setup.py install \
	--prefix=/usr \
	--root=$(OUT_DIR) \
	--skip-build \
	--optimize=1 && \
	sed -e '1c$(shell echo "\#")!/usr/bin/python3' -i $(OUT_DIR)/usr/bin/meson && \
	install -d -D -v -m 755 $(OUT_DIR)/usr/share/meson/cross && \
	install -v -m 644 $(pkg_files)/*.txt $(OUT_DIR)/usr/share/meson/cross
