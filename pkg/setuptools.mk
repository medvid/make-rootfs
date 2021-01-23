# https://repology.org/project/python:setuptools
# https://git.alpinelinux.org/aports/tree/main/py3-setuptools/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/python3-setuptools/python3-setuptools.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/python3-setuptools/template

pkg_ver  := 51.3.3
pkg_repo := https://github.com/pypa/setuptools
pkg_site := https://files.pythonhosted.org/packages/source/s/setuptools
pkg_deps := python
pkg_copy := true

pkg_configure := $(PYTHON) bootstrap.py

pkg_build := $(PYTHON) setup.py build

pkg_install := $(PYTHON) setup.py install \
	--optimize=1 \
	--skip-build \
	--single-version-externally-managed \
	--prefix=/usr \
	--root=$(OUT_DIR)
