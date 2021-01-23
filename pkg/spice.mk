# https://repology.org/project/spice
# https://git.alpinelinux.org/aports/tree/main/spice/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/spice/spice.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/spice/template

pkg_ver  := 0.14.3
pkg_repo := https://gitlab.freedesktop.org/spice/spice
pkg_site := https://www.spice-space.org/download/releases
pkg_deps := spice-protocol glib pixman openssl libjpeg-turbo zlib six pyparsing

# subprojects/spice-common/meson.build sets -Werror
pkg_configure := CFLAGS="$(CFLAGS) -Wno-unused-function" $(meson_pkg_configure) \
	-Dgstreamer=no \
	-Dlz4=false \
	-Dsasl=false \
	-Dcelt051=disabled \
	-Dopus=disabled \
	-Dsmartcard=disabled \
	-Dalignment-checks=false \
	-Dextra-checks=false \
	-Dstatistics=false \
	-Dmanual=false \
	-Dinstrumentation=no \
	$(pkg_srcdir) $(pkg_objdir)

pkg_build := ninja -v

pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
