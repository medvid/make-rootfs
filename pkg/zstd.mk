pkg_ver  := 1.4.5
pkg_repo := https://github.com/facebook/zstd
pkg_site := $(pkg_repo)/releases/download/v$(pkg_ver)
pkg_copy := true

pkg_build := make -C lib libzstd.a libzstd.pc HAVE_PTHREAD=1 HAVE_ZLIB=0 HAVE_LZMA=0 HAVE_LZ4=0 PREFIX=/usr

pkg_install := make -C lib install-pc install-static install-includes PREFIX=/usr DESTDIR=$(OUT_DIR)
