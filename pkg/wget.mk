# https://repology.org/project/wget
# https://git.alpinelinux.org/aports/tree/main/wget/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/wget/wget.mk
# https://github.com/distr1/distri/blob/master/pkgs/wget/build.textproto
# https://github.com/kisslinux/community/blob/master/community/wget/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/wget/template

pkg_ver  := 1.21.1
pkg_repo := https://git.savannah.gnu.org/git/wget
pkg_site := https://ftp.gnu.org/gnu/wget
pkg_deps := zlib openssl

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-opie \
	--disable-digest \
	--disable-ntlm \
	--disable-debug \
	--disable-nls \
	--disable-ipv6 \
	--disable-pcre2 \
	--disable-pcre \
	--disable-xattr \
	--without-libpsl \
	--with-ssl=openssl \
	--with-zlib \
	--without-metalink \
	--without-cares \
	--with-openssl=yes \
	--with-included-libunistring \
	--without-libuuid \
	--without-gpgme-prefix

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
