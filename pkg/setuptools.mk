pkg_ver  := 50.3.2
pkg_repo := https://github.com/pypa/setuptools
pkg_site := https://files.pythonhosted.org/packages/source/s/setuptools
pkg_copy := true

pkg_configure := python3 bootstrap.py

pkg_build := python3 setup.py build

pkg_install := python3 setup.py install --optimize=1 --skip-build --prefix=/usr --root=$(OUT_DIR)
