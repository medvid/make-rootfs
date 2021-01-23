# https://repology.org/project/libseccomp
# https://git.alpinelinux.org/aports/tree/main/libseccomp/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libseccomp/libseccomp.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libseccomp/template

pkg_ver  := 2.5.1
pkg_repo := https://github.com/seccomp/libseccomp
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--localstatedir=/var \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-shared

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
