# https://repology.org/project/python:mako
# https://git.alpinelinux.org/aports/tree/main/py3-mako/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/python3-mako/python3-mako.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/python3-Mako/template

pkg_ver  := 1.1.4
pkg_repo := https://github.com/sqlalchemy/mako
pkg_site := https://files.pythonhosted.org/packages/source/M/Mako
pkg_base := Mako
pkg_deps := python setuptools markupsafe
pkg_copy := true

pkg_build := $(PYTHON) setup.py build

pkg_install := $(PYTHON) setup.py install \
	--optimize=1 \
	--skip-build \
	--single-version-externally-managed \
	--prefix=/usr \
	--root=$(OUT_DIR)
