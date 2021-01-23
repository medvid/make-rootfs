# https://repology.org/project/qemu
# https://git.alpinelinux.org/aports/tree/community/qemu/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/qemu/qemu.mk
# https://github.com/distr1/distri/blob/master/pkgs/qemu/build.textproto
# https://github.com/kisslinux/community/blob/master/community/qemu/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/qemu/template

# https://wiki.qemu.org/Hosts/Linux

pkg_ver  := 5.2.0
pkg_repo := https://git.qemu.org/git/qemu.git
pkg_site := https://download.qemu.org
pkg_deps := pixman zlib libxkbcommon libudev-zero libpng libjpeg-turbo zstd liburing libepoxy libusb spice usbredir

pkg_configure := $(pkg_srcdir)/configure \
	--target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu,aarch64-linux-user,arm-linux-user,i386-linux-user,x86_64-linux-user \
	--cc=clang \
	--prefix=/usr \
	--localstatedir=/var \
	--sysconfdir=/etc \
	--static \
	--libexecdir=/usr/lib/qemu \
	--disable-werror \
	--disable-slirp \
	--disable-malloc-trim \
	--disable-plugins \
	--disable-containers \
	--enable-system \
	--enable-user \
	--enable-linux-user \
	--disable-bsd-user \
	--disable-docs \
	--disable-guest-agent \
	--disable-guest-agent-msi \
	--disable-pie \
	--disable-modules \
	--disable-module-upgrades \
	--disable-debug-tcg \
	--disable-debug-info \
	--disable-sparse \
	--disable-safe-stack \
	--disable-gnutls \
	--disable-nettle \
	--disable-gcrypt \
	--disable-auth-pam \
	--disable-sdl \
	--disable-sdl-image \
	--disable-gtk \
	--disable-vte \
	--disable-curses \
	--disable-iconv \
	--enable-vnc \
	--disable-vnc-sasl \
	--enable-vnc-jpeg \
	--enable-vnc-png \
	--disable-cocoa \
	--disable-virtfs \
	--disable-virtiofsd \
	--enable-libudev \
	--disable-mpath \
	--disable-xen \
	--disable-brlapi \
	--disable-curl \
	--enable-membarrier \
	--enable-fdt \
	--enable-kvm \
	--disable-hax \
	--disable-hvf \
	--disable-whpx \
	--disable-rdma \
	--disable-pvrdma \
	--disable-vde \
	--disable-netmap \
	--disable-linux-aio \
	--enable-linux-io-uring \
	--disable-cap-ng \
	--disable-attr \
	--enable-vhost-net \
	--enable-vhost-vsock \
	--enable-vhost-scsi \
	--enable-vhost-crypto \
	--enable-vhost-kernel \
	--enable-vhost-user \
	--enable-vhost-user-blk-server \
	--enable-vhost-vdpa \
	--enable-spice \
	--disable-rbd \
	--disable-libiscsi \
	--disable-libnfs \
	--disable-smartcard \
	--disable-u2f \
	--enable-libusb \
	--disable-live-block-migration \
	--enable-usb-redir \
	--disable-lzo \
	--disable-snappy \
	--disable-bzip2 \
	--disable-lzfse \
	--enable-zstd \
	--enable-seccomp \
	--disable-coroutine-pool \
	--disable-glusterfs \
	--disable-tpm \
	--disable-libssh \
	--disable-numa \
	--disable-libxml2 \
	--disable-tcmalloc \
	--disable-jemalloc \
	--enable-avx2 \
	--enable-avx512f \
	--disable-replication \
	--enable-opengl \
	--disable-virglrenderer \
	--disable-xfsctl \
	--disable-qom-cast-debug \
	--enable-tools \
	--disable-bochs \
	--disable-cloop \
	--disable-dmg \
	--disable-qcow1 \
	--disable-vdi \
	--disable-vvfat \
	--disable-qed \
	--disable-parallels \
	--disable-sheepdog \
	--disable-crypto-afalg \
	--disable-capstone \
	--disable-debug-mutex \
	--disable-libpmem \
	--enable-xkbcommon \
	--disable-rng-none \
	--disable-libdaxctl

pkg_build := make V=1

pkg_check := make check V=1

pkg_install := make install DESTDIR=$(OUT_DIR)
