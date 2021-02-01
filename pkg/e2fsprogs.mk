# https://repology.org/project/e2fsprogs
# https://git.alpinelinux.org/aports/tree/main/e2fsprogs/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/e2fsprogs/e2fsprogs.mk
# https://github.com/distr1/distri/blob/master/pkgs/e2fsprogs/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/e2fsprogs/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/e2fsprogs/template

pkg_ver  := 1.45.7
pkg_repo := https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
pkg_site := https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$(pkg_ver)

# Note: AC_PROG_MKDIR_P doesn't like relative paths
pkg_configure := $(pkg_objdir)/$(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sbindir=/usr/bin \
	--sysconfdir=/etc \
	--disable-debugfs \
	--disable-imager \
	--enable-fsck \
	--disable-uuidd \
	--disable-nls \
	--disable-fuse2fs

pkg_build := make

pkg_check := make check

pkg_install := install -m 755 e2fsck/e2fsck misc/mke2fs \
	misc/tune2fs resize/resize2fs $(OUT_DIR)/usr/bin/ && \
	install -m644 misc/mke2fs.conf $(OUT_DIR)/etc/ && \
	ln -sf e2fsck $(OUT_DIR)/usr/bin/fsck.ext4 && \
	ln -sf mke2fs $(OUT_DIR)/usr/bin/mkfs.ext4
