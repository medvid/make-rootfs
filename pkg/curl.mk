pkg_ver  := 7.71.1
pkg_repo := https://github.com/curl/curl
pkg_site := https://curl.haxx.se/download
pkg_deps := zlib libressl

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-debug \
	--enable-optimize \
	--disable-curldebug \
	--disable-ares \
	--disable-esni \
	--disable-shared \
	--enable-http \
	--enable-ftp \
	--enable-file \
	--disable-ldap \
	--disable-ldaps \
	--disable-rtsp \
	--disable-proxy \
	--disable-dict \
	--disable-telnet \
	--disable-tftp \
	--disable-pop3 \
	--disable-imap \
	--disable-smb \
	--disable-smtp \
	--disable-gopher \
	--disable-manual \
	--disable-libcurl-option \
	--disable-verbose \
	--disable-sspi \
	--disable-crypto-auth \
	--disable-ntlm-wb \
	--disable-tls-srp \
	--enable-unix-sockets \
	--disable-cookies \
	--enable-http-auth \
	--disable-doh \
	--disable-mime \
	--disable-dateparse \
	--disable-netrc \
	--disable-dnsshuffle \
	--disable-alt-svc \
	--without-pic \
	--with-zlib \
	--without-brotli \
	--with-default-ssl-backend=openssl \
	--without-gnutls \
	--without-mbedtls \
	--without-wolfssl \
	--without-mesalink \
	--without-bearssl \
	--without-nss \
	--with-ca-bundle=/etc/ssl/cert.pem \
	--without-ca-fallback \
	--without-libpsl \
	--without-libmetalink \
	--without-libssh \
	--without-libssh2 \
	--without-librtmp \
	--without-winidn \
	--without-libidn2 \
	--without-nghttp2 \
	--without-ngtcp2 \
	--without-nghttp3 \
	--without-quiche \
	--without-zsh-functions-dir \
	--without-fish-functions-dir

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)