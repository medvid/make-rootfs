# https://repology.org/project/git
# https://git.alpinelinux.org/aports/tree/main/git/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/git/git.mk
# https://github.com/distr1/distri/blob/master/pkgs/git/build.textproto
# https://github.com/kisslinux/repo/blob/master/core/git/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/git/template

pkg_ver  := 2.30.0
pkg_repo := https://github.com/git/git
pkg_site := https://mirrors.edge.kernel.org/pub/software/scm/git
pkg_deps := zlib curl openssl
pkg_copy := true

# TODO: figure out proper way to set CURL_LDFLAGS
# TODO: investigate why toybox tar xof - is broken
pkg_vars := V=1 \
	TAR=/bin/tar \
	NO_PERL=YesPlease \
	NO_GETTEXT=YesPlease \
	NO_REGEX=NeedsStartEnd \
	LDFLAGS="$(LDFLAGS) -lcurl -lssl -lcrypto -lz"

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--with-openssl \
	--with-curl \
	--without-expat \
	--without-iconv \
	--without-tcltk \
	ac_cv_fread_reads_directories=no \
	ac_cv_snprintf_returns_bogus=no

pkg_build := make $(pkg_vars)

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR) $(pkg_vars)
