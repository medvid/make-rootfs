pkg_ver  := 0.4.4
pkg_repo := https://github.com/illiliti/libudev-zero
pkg_url  := $(pkg_repo)/archive/$(pkg_ver).tar.gz
pkg_copy := true

pkg_build := make libudev.a libudev.pc PREFIX=/usr

pkg_install := install -m 644 libudev.a $(OUT_DIR)/usr/lib/libudev.a && \
	install -m 644 udev.h $(OUT_DIR)/usr/include/libudev.h && \
	install -m 644 libudev.pc $(OUT_DIR)/usr/lib/pkgconfig/libudev.pc
