pkg_ver  := 1.10.2
pkg_repo := https://github.com/ninja-build/ninja
pkg_url  := $(pkg_repo)/archive/v$(pkg_ver).tar.gz

pkg_configure := python3 $(pkg_srcdir)/configure.py --bootstrap

pkg_build := ninja -v

pkg_install := cp ninja $(OUT_DIR)/usr/bin/ninja
