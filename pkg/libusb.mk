# https://repology.org/project/libusb
# https://git.alpinelinux.org/aports/tree/main/libusb/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/libusb/libusb.mk
# https://github.com/distr1/distri/blob/master/pkgs/libusb/build.textproto
# https://github.com/kisslinux/community/blob/master/community/libusb/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/libusb/template

pkg_ver  := 1.0.24
pkg_repo := https://github.com/libusb/libusb
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_deps := libudev-zero

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-shared \
	--enable-udev \
	--without-pic

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
