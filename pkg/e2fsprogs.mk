pkg_ver  := 1.45.6
pkg_repo := https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
pkg_site := http://prdownloads.sourceforge.net/e2fsprogs

# Note: AC_PROG_MKDIR_P doesn't like relative paths
pkg_configure := $(pkg_objdir)/$(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sbindir=/usr/bin \
	--sysconfdir=/etc \
	--enable-symlink-install \
	--enable-relative-symlinks \
	--disable-debugfs \
	--disable-imager \
	--enable-fsck \
	--disable-uuidd \
	--disable-nls \
	--disable-fuse2fs

pkg_build := make

# TODO: figure out why installdirs target doesn't execute in e2fsck/Makefile
pkg_install := make install-progs-recursive DESTDIR=$(OUT_DIR)
