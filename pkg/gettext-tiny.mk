# https://repology.org/project/less
# https://git.alpinelinux.org/aports/tree/community/gettext-tiny/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/gettext-tiny/gettext-tiny.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/gettext-tiny/template

pkg_ver  := 0.3.2
pkg_repo := https://github.com/sabotage-linux/gettext-tiny
pkg_site := https://ftp.barfooze.de/pub/sabotage/tarballs
pkg_copy := true

pkg_build := make prefix=/usr libintl=musl

pkg_install := make prefix=/usr libintl=musl install DESTDIR=$(OUT_DIR)
