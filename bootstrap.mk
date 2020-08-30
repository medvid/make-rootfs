# Set the list of packages built at stage1 and stage2
BASE_PKGS := musl linux-headers llvm

# Check if we are currently bootstrapping
ifneq ($(STAGE),)
# During bootstrap, TARGET always equals HOST
TARGET := $(HOST)
# Override OBJ_DIR, LOG_DIR and OUT_DIR to point to the bootstrapped stage
OBJ_DIR := obj/$(STAGE)
LOG_DIR := $(ROOT_DIR)/log/$(STAGE)
OUT_DIR := $(ROOT_DIR)/out/$(STAGE)
# Add current stage output to PATH
export PATH := $(OUT_DIR)/usr/bin:$(PATH)
endif

# Set sysroot directory and target ABI
ifneq ($(STAGE),stage1)
export CFLAGS += --sysroot=$(OUT_DIR) -target $(TARGET)
export CXXFLAGS += --sysroot=$(OUT_DIR) -target $(TARGET)
export LDFLAGS += --sysroot=$(OUT_DIR) -target $(TARGET)
export PKG_CONFIG_LIBDIR = $(OUT_DIR)/usr/lib/pkgconfig:$(OUT_DIR)/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR = $(OUT_DIR)
endif

obj/stage1/.install.stamp:
	$(MAKE) STAGE=stage1 TARGET_PKGS="$(BASE_PKGS)" install
	touch $@

stage1: obj/stage1/.install.stamp

obj/stage2/.install.stamp: | stage1
	$(MAKE) STAGE=stage2 TARGET_PKGS="$(BASE_PKGS)" install
	touch $@

stage2: obj/stage2/.install.stamp

obj/stage3/.install.stamp: | stage2
	$(MAKE) STAGE=stage3 TARGET_PKGS="$(HOST_PKGS)" install
	mkdir -p etc
	cp -rv pkg/etc/* etc
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
	$(MAKE) STAGE=stage4 TARGET_PKGS="$(HOST_PKGS)" install
	mkdir -p etc
	cp -rv pkg/etc/* etc
	cp -rv out/stage4/etc/* etc
	ln -sfvT out/stage4/usr usr
	ln -sfvT usr/bin bin
	ln -sfvT usr/lib lib
	ln -sfvT usr/bin sbin
	touch $@
else
obj/stage4/.install.stamp: | tmp stage3
	mkdir -p obj/stage4
	$(MAKE) chroot CHROOT_PROG="$(MAKE) STAGE=stage4 TARGET_PKGS=\"$(HOST_PKGS)\" install"
	mkdir -p etc
	cp -rv pkg/etc/* etc
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
	cp -rv pkg/etc/* etc
	cp -rv out/stage3/etc/* etc
	$(MAKE) bootstrap builtins

# Install compiler-rt builtins for all supported targets
builtins:
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=x86_64-linux-musl"
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=i386-linux-musl"
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=armv7-linux-musleabihf"
	$(MAKE) chroot CHROOT_PROG="$(MAKE) install-builtins TARGET=aarch64-linux-musl"

.PHONY: stage1 stage3 stage3 stage4 bootstrap force-bootstrap builtins
