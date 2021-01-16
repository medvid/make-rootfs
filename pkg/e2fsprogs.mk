# https://repology.org/project/e2fsprogs
# https://git.alpinelinux.org/aports/tree/main/e2fsprogs/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/e2fsprogs/e2fsprogs.mk
# https://github.com/distr1/distri/blob/master/pkgs/e2fsprogs/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/e2fsprogs/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/e2fsprogs/template

pkg_ver  := 1.45.6
pkg_repo := https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
pkg_site := https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$(pkg_ver)

# Note: AC_PROG_MKDIR_P doesn't like relative paths
pkg_configure := $(pkg_objdir)/$(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sbindir=/usr/bin \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--enable-symlink-install \
	--enable-relative-symlinks \
	--disable-debugfs \
	--disable-imager \
	--enable-fsck \
	--disable-uuidd \
	--disable-nls \
	--disable-fuse2fs

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
