pkg_ver  := 51.1.1
pkg_repo := https://github.com/pypa/setuptools
pkg_site := https://files.pythonhosted.org/packages/source/s/setuptools
pkg_deps := python
pkg_copy := true

pkg_configure := $(PYTHON) bootstrap.py

pkg_build := $(PYTHON) setup.py build

pkg_install := $(PYTHON) setup.py install \
	--optimize=1 \
	--skip-build \
	--prefix=/usr \
	--root=$(OUT_DIR)
