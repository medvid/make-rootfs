# https://repology.org/project/python:markupsafe
# https://git.alpinelinux.org/aports/tree/main/py3-markupsafe/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/python-markupsafe/python-markupsafe.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/python-MarkupSafe/template

pkg_ver  := 1.1.1
pkg_repo := https://github.com/mitsuhiko/markupsafe
pkg_site := https://files.pythonhosted.org/packages/source/M/MarkupSafe
pkg_base := MarkupSafe
pkg_deps := python setuptools
pkg_copy := true

pkg_build := $(PYTHON) setup.py build --compiler=none

pkg_install := $(PYTHON) setup.py install \
	--optimize=1 \
	--skip-build \
	--single-version-externally-managed \
	--prefix=/usr \
	--root=$(OUT_DIR)
