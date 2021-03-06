obj/stage1/.install.stamp:
	$(MAKE) STAGE=stage1 TARGET_PKGS="$(STAGE1_PKGS)" install
	touch $@

stage1: obj/stage1/.install.stamp

obj/stage2/.install.stamp: | stage1
	$(MAKE) STAGE=stage2 TARGET_PKGS="$(STAGE2_PKGS)" install
	touch $@

stage2: obj/stage2/.install.stamp

obj/stage3/.install.stamp: | stage2
	$(MAKE) STAGE=stage3 TARGET_PKGS="$(STAGE3_PKGS)" install
	mkdir -p etc
	cp -rv $(PKG_DIR)/etc/* etc
	cp -rv out/stage3/etc/* etc
	ln -sfvT out/stage3/usr usr
	ln -sfvT usr/bin bin
	ln -sfvT usr/lib lib
	ln -sfvT usr/bin sbin
	touch $@

stage3: obj/stage3/.install.stamp

ifeq ($(CURDIR),/)
# Note: stage3 timestamps are not present inside the multi-stage docker build
obj/stage4/.install.stamp: | tmp
	$(MAKE) STAGE=stage4 TARGET_PKGS="$(STAGE4_PKGS)" install
	mkdir -p etc
	cp -rv $(PKG_DIR)/etc/* etc
	cp -rv out/stage4/etc/* etc
	ln -sfvT out/stage4/usr usr
	ln -sfvT usr/bin bin
	ln -sfvT usr/lib lib
	ln -sfvT usr/bin sbin
	touch $@
else
obj/stage4/.install.stamp: | tmp stage3
	mkdir -p obj/stage4
	$(MAKE) chroot CHROOT_PROG="$(MAKE) STAGE=stage4 TARGET_PKGS=\"$(STAGE4_PKGS)\" install"
	mkdir -p etc
	cp -rv $(PKG_DIR)/etc/* etc
	cp -rv out/stage4/etc/* etc
	ln -sfvT out/stage4/usr usr
	ln -sfvT usr/bin bin
	ln -sfvT usr/lib lib
	ln -sfvT usr/bin sbin
	touch $@
endif

stage4: obj/stage4/.install.stamp

# This assumes usr is symlink to out/stage4/usr
# To re-bootstrap, usr needs to be manually removed
obj/stage4/.bootstrap.stamp: | stage4
	rm usr
	cp -r out/stage4/usr usr
	touch $@

bootstrap: obj/stage4/.bootstrap.stamp

# Define custom target to re-create /usr
# Useful to apply HOST_PKGS modification
force-bootstrap:
	rm -f obj/stage4/.install.stamp obj/stage4/.bootstrap.stamp
	rm -rf usr etc
	ln -sfvT out/stage3/usr usr
	ln -sfvT usr/bin bin
	ln -sfvT usr/lib lib
	ln -sfvT usr/bin sbin
	mkdir -p etc
	cp -rv $(PKG_DIR)/etc/* etc
	cp -rv out/stage3/etc/* etc
	$(MAKE) bootstrap builtins

# Install compiler-rt builtins for all supported targets
builtins:
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=x86_64-linux-musl"
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=i386-linux-musl"
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=armv7-linux-musleabihf"
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=aarch64-linux-musl"
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=riscv64-linux-musl"

.PHONY: stage1 stage3 stage3 stage4 bootstrap force-bootstrap builtins
