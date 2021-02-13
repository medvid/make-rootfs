# https://repology.org/project/e2fsprogs
# https://git.alpinelinux.org/aports/tree/main/e2fsprogs/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/e2fsprogs/e2fsprogs.mk
# https://github.com/distr1/distri/blob/master/pkgs/e2fsprogs/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/e2fsprogs/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/e2fsprogs/template

pkg_ver  := 1.46.1
pkg_repo := https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
pkg_site := https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$(pkg_ver)
pkg_deps := libuuid

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sbindir=/usr/bin \
	--sysconfdir=/etc \
	--disable-libuidd \
	--disable-debugfs \
	--disable-imager \
	--enable-fsck \
	--disable-uuidd \
	--disable-nls \
	--disable-fuse2fs

pkg_build := make static-progs V=1

pkg_install := install -m 755 e2fsck/e2fsck.static $(OUT_DIR)/usr/bin/e2fsck && \
	install -m 755 misc/blkid.static $(OUT_DIR)/usr/bin/blkid && \
	install -m 755 misc/dumpe2fs.static $(OUT_DIR)/usr/bin/dumpe2fs && \
	install -m 755 misc/mke2fs.static $(OUT_DIR)/usr/bin/mke2fs && \
	install -m 755 misc/tune2fs.static $(OUT_DIR)/usr/bin/tune2fs && \
	install -m 755 resize/resize2fs.static $(OUT_DIR)/usr/bin/resize2fs && \
	install -m644 misc/mke2fs.conf $(OUT_DIR)/etc/ && \
	ln -sf e2fsck $(OUT_DIR)/usr/bin/fsck.ext4 && \
 	ln -sf mke2fs $(OUT_DIR)/usr/bin/mkfs.ext4
