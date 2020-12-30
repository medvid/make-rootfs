pkg_ver  := 1.1.1i
pkg_repo := https://github.com/openssl/openssl
pkg_site := https://www.openssl.org/source

ifneq (,$(findstring aarch64,$(TARGET)))
openssl_target_arch := linux-aarch64
else ifneq (,$(findstring arm,$(TARGET)))
openssl_target_arch := linux-armv4
else ifneq (,$(findstring x86_64,$(TARGET)))
openssl_target_arch := linux-x86_64
openssl_optflags    := enable-ec_nistp_64_gcc_128
else ifneq (,$(findstring 86,$(TARGET)))
openssl_target_arch := linux-elf
else
$(error Unsupported TARGET: $(TARGET))
endif

pkg_configure := $(pkg_srcdir)/Configure \
	$(openssl_target_arch) \
	--prefix=/usr --libdir=lib \
	--openssldir=/etc/ssl \
	no-shared \
	no-zlib \
	$(openssl_optflags) \
	no-async \
	no-comp \
	no-idea \
	no-mdc2 \
	no-rc5 \
	no-ec2m \
	no-sm2 \
	no-sm4 \
	no-ssl2 \
	no-ssl3 \
	no-seed \
	no-weak-ssl-ciphers \
	$(subst -target $(TARGET),,$(CFLAGS)) \
	$(subst -target $(TARGET),,$(LDFLAGS)) \
	-Wa,--noexecstack

pkg_build := make PROGRAMS=apps/openssl

pkg_install := make install_sw PROGRAMS=apps/openssl DESTDIR=$(OUT_DIR)
