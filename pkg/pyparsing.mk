# https://repology.org/project/python:pyparsing
# https://git.buildroot.net/buildroot/tree/package/python-pyparsing/python-pyparsing.mk

pkg_ver  := 2.4.7
pkg_repo := https://github.com/pyparsing/pyparsing
pkg_site := https://files.pythonhosted.org/packages/source/p/pyparsing
pkg_deps := python setuptools
pkg_copy := true

pkg_build := $(PYTHON) setup.py build

pkg_install := $(PYTHON) setup.py install \
	--optimize=1 \
	--skip-build \
	--single-version-externally-managed \
	--prefix=/usr \
	--root=$(OUT_DIR)
