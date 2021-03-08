# https://repology.org/project/zstd
# https://git.alpinelinux.org/aports/tree/main/zstd/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/zstd/zstd.mk
# https://github.com/kisslinux/repo/blob/master/extra/zstd/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/zstd/template

pkg_ver  := 1.4.9
pkg_repo := https://github.com/facebook/zstd
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)

pkg_configure := $(meson_pkg_configure) \
	-Dlegacy_level=0 \
	-Dbin_programs=false \
	-Dbin_tests=false \
	-Dzlib=disabled \
	-Dlzma=disabled \
	-Dlz4=disabled \
	$(pkg_srcdir)/build/meson $(pkg_objdir)

pkg_build := ninja -v

# TODO: testsuite depends on valgrind
pkg_check := ninja test

pkg_install := DESTDIR=$(OUT_DIR) ninja install
