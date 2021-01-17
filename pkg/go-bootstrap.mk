# https://repology.org/project/go-bootstrap
# https://git.alpinelinux.org/aports/tree/community/go-bootstrap/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/go-bootstrap/go-bootstrap.mk
# https://github.com/distr1/distri/blob/master/pkgs/golang14/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/go1.12-bootstrap/template

pkg_ver  := 1.4.3
pkg_repo := https://github.com/golang/go
pkg_url  := $(pkg_repo)/archive/go$(pkg_ver).tar.gz
pkg_dir  := go-go$(pkg_ver)
pkg_copy := true

pkg_prepare := ln -sf $(shell which llvm-ar) ar

pkg_build := cd src && \
	PATH=$(pkg_objdir):$(PATH) \
	TMPDIR=/tmp \
	CGO_ENABLED=0 \
	GOROOT_FINAL=/usr/lib/go14 \
	./make.bash

pkg_install := mkdir -p $(OUT_DIR)/usr/lib/go14 && \
	cp -rL bin src pkg $(OUT_DIR)/usr/lib/go14/
