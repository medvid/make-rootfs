# https://repology.org/project/fonts:ubuntu
# https://git.alpinelinux.org/aports/tree/main/ttf-ubuntu-font-family/APKBUILD
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/ttf-ubuntu-font-family/template

pkg_ver  := 0.83
pkg_url  := https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-$(pkg_ver).zip

pkg_install := mkdir -p $(OUT_DIR)/usr/share/fonts/TTF && \
	install -m644 $(pkg_srcdir)/Ubuntu-{L,R,B,C}*.ttf $(OUT_DIR)/usr/share/fonts/TTF && \
	install -m644 $(pkg_srcdir)/UbuntuMono-*.ttf $(OUT_DIR)/usr/share/fonts/TTF
