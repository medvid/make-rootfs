pkg_ver  := 0.55.0
pkg_repo := https://github.com/mesonbuild/meson
pkg_site := $(pkg_repo)/releases/download/$(pkg_ver)
pkg_copy := true
pkg_deps := setuptools

pkg_build := python3 setup.py build

pkg_install := python3 setup.py install --optimize=1 --skip-build --prefix=/usr --root=$(OUT_DIR)
