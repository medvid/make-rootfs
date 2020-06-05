pkg_ver  := 49.2.0
pkg_repo := https://github.com/pypa/setuptools
pkg_site := https://files.pythonhosted.org/packages/source/s/setuptools
pkg_intree := true

pkg_build := python3 setup.py build

pkg_install := python3 setup.py install --optimize=1 --skip-build --root=$(OUT_DIR)
