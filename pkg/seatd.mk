# https://repology.org/project/seatd
# https://git.alpinelinux.org/aports/tree/testing/seatd/APKBUILD
# https://github.com/kisslinux/community/blob/master/community/seatd/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/seatd/template

pkg_ver  := 0.4.0
pkg_repo := https://git.sr.ht/~kennylevinsen/seatd
pkg_url  := $(pkg_repo)/archive/$(pkg_ver).tar.gz

pkg_configure := CFLAGS="$(CFLAGS) -Wno-error" \
	$(meson_pkg_configure) \
	--prefix=/usr \
	-Dlogind=disabled \
	-Dexamples=disabled \
	-Dman-pages=disabled \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
