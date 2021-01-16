# https://repology.org/project/pigz
# https://git.alpinelinux.org/aports/tree/main/pigz/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/pigz/pigz.mk
# https://github.com/distr1/distri/blob/master/pkgs/pigz/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/pigz/template

pkg_ver  := 2.4
pkg_repo := https://github.com/madler/pigz
pkg_site := https://zlib.net/pigz
pkg_deps := zlib
pkg_copy := true

pkg_build := make pigz CC="$(CC)" CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"

pkg_install := install -m 755 pigz $(OUT_DIR)/usr/bin/pigz && \
	ln -sf pigz $(OUT_DIR)/usr/bin/gzip && \
	ln -sf pigz $(OUT_DIR)/usr/bin/gunzip
