pkg_ver  := 0.56.1
pkg_repo := https://github.com/mesonbuild/meson
pkg_site := $(pkg_repo)/releases/download/$(pkg_ver)
pkg_copy := true
pkg_deps := setuptools

pkg_build := python3 setup.py build

pkg_install := python3 setup.py install \
	--prefix=/usr \
	--root=$(OUT_DIR) \
	--skip-build \
	--optimize=1 && \
	sed -e '1c$(shell echo "\#")!/usr/bin/python3' -i $(OUT_DIR)/usr/bin/meson && \
	install -d -D -v -m 755 $(OUT_DIR)/usr/share/meson/cross && \
	install -v -m 644 $(pkg_files)/*.txt $(OUT_DIR)/usr/share/meson/cross
