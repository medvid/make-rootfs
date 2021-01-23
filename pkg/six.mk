# https://repology.org/project/python:six
# https://git.alpinelinux.org/aports/tree/main/py3-six/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/python-six/python-six.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/python-six/template

pkg_ver  := 1.15.0
pkg_repo := https://github.com/benjaminp/six
pkg_site := https://files.pythonhosted.org/packages/source/s/six
pkg_deps := python setuptools
pkg_copy := true

pkg_build := $(PYTHON) setup.py build

pkg_install := $(PYTHON) setup.py install \
	--optimize=1 \
	--skip-build \
	--single-version-externally-managed \
	--prefix=/usr \
	--root=$(OUT_DIR)
