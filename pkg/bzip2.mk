pkg_ver  := 1.0.8
pkg_repo := https://sourceware.org/git/bzip2.git
pkg_site := https://sourceware.org/pub/bzip2
pkg_copy := true

pkg_build := make bzip2 \
	CC=$(CC) \
	AR=$(AR) \
	CFLAGS="$(CFLAGS) -D_FILE_OFFSET_BITS=64" \
	LDFLAGS="$(LDFLAGS)"

pkg_install := install -m 644 libbz2.a $(OUT_DIR)/usr/lib/libbz2.a && \
	install -m 644 bzlib.h $(OUT_DIR)/usr/include/bzlib.h && \
	install -m 755 bzip2 $(OUT_DIR)/usr/bin/bzip2 && \
	ln -sf bzip2 $(OUT_DIR)/usr/bin/bunzip2 && \
	ln -sf bzip2 $(OUT_DIR)/usr/bin/bzcat
