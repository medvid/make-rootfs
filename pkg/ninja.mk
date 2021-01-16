# https://repology.org/project/ninja
# https://git.alpinelinux.org/aports/tree/unmaintained/ninja/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/ninja/ninja.mk
# https://github.com/distr1/distri/blob/master/pkgs/ninja/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/ninja/template

pkg_ver  := 1.10.2
pkg_repo := https://github.com/ninja-build/ninja
pkg_url  := $(pkg_repo)/archive/v$(pkg_ver).tar.gz

pkg_configure := python3 $(pkg_srcdir)/configure.py --bootstrap

pkg_build := ninja -v

pkg_install := install -m 755 ninja $(OUT_DIR)/usr/bin/ninja
