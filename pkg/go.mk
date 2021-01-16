# https://repology.org/project/go
# https://golang.org/doc/install/source
# https://git.alpinelinux.org/aports/tree/community/go/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/go/go.mk
# https://github.com/distr1/distri/blob/master/pkgs/golang/build.textproto
# https://github.com/kisslinux/community/blob/master/community/go/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/go/template

pkg_ver  := 1.15.6
pkg_repo := https://github.com/golang/go
pkg_url  := $(pkg_repo)/archive/go$(pkg_ver).tar.gz
pkg_dir  := go-go$(pkg_ver)
pkg_copy := true
pkg_deps := go-bootstrap

pkg_build := cd src && \
	GOROOT_BOOTSTRAP=$(OUT_DIR)/usr/lib/go14 \
	TMPDIR=/tmp \
	CGO_ENABLED=0 \
	GOROOT_FINAL=/usr/lib/go \
	./make.bash

pkg_install := mkdir -p $(OUT_DIR)/usr/lib/go && \
	cp -r bin src pkg $(OUT_DIR)/usr/lib/go/ && \
	ln -sf ../lib/go/bin/go $(OUT_DIR)/usr/bin/go && \
	ln -sf ../lib/go/bin/gofmt $(OUT_DIR)/usr/bin/gofmt
