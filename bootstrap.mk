# Set the list of packages built at stage1
STAGE1_PKGS := musl linux-headers llvm

# Set the list of packages built at stage2
STAGE2_PKGS := musl linux-headers llvm

# Set the list of packages built at stage3
# Note: the package order matters as the pkg_deps in pkg/*.mk
# do not specify the build-only dependencies (cmake, meson, bison, ..).
# The package binaries are installed to out/stage3 one-by-one, while
# out/stage3/usr/bin is the first entry in PATH - extra care needed
STAGE3_PKGS := musl linux-headers llvm libarchive libressl toybox \
	pkgconf mawk diffutils m4 bash make bc grep xz wget libffi python \
	ninja cmake rsync perl curl git gperf m4 flex bison meson

# Set the list of packages built at stage4
STAGE4_PKGS := musl linux-headers llvm zlib libarchive libressl toybox \
	pkgconf mawk diffutils m4 flex bison bash make bc grep xz wget \
	libffi python ninja cmake rsync perl curl git e2fsprogs gperf strace \
	glib wayland qt flex meson

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

.PHONY: stage1 stage3 stage3 stage4 bootstrap force-bootstrap builtins
