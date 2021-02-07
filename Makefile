# Disable built-in rules
.SUFFIXES:

# Define common variables
space := $(subst ,, )
comma := ,

# Customize ?= variables
-include config.mk

# Ensure the '| tee' logging recipes return failures
SHELL := bash -o pipefail

# Set the host toolchain triple
HOST := $(shell uname -m)-linux-musl

# Set the target toolchain triple
TARGET ?= $(HOST)

# https://cmake.org/cmake/help/latest/variable/CMAKE_BUILD_TYPE.html
CONFIG ?= Release

# Set the list of packages built during stage1 bootstrap
STAGE1_PKGS := musl linux-headers llvm

# Set the list of packages built during stage2 bootstrap
STAGE2_PKGS := $(STAGE1_PKGS)

# Set the list of packages built during stage3 bootstrap
STAGE3_PKGS := $(STAGE2_PKGS) bash bison cmake curl diffutils \
	flex glib gperf grep libarchive libedit m4 make mako mawk \
	meson ncurses ninja perl pkgconf python mako rsync toybox xz

# Set the list of packages built during stage4 bootstrap
STAGE4_PKGS := $(STAGE3_PKGS) bc dash git go less pigz qemu \
	qt5 qt6 tmux wget

# Set the default list of packages built to the target rootfs
TARGET_PKGS ?= bash toybox finit

# Check if we are currently bootstrapping
ifneq ($(STAGE),)
# Disable cross-compilation build recipes
CROSS := 0
# During bootstrap, TARGET always equals HOST
TARGET := $(HOST)
# Set stage-specific OBJ_DIR, LOG_DIR and OUT_DIR
TARGET_DIR := $(STAGE)
else
# Enable cross-compilation build recipes
CROSS := 1
# Set target-specific OBJ_DIR, LOG_DIR and OUT_DIR
TARGET_DIR := $(TARGET)
endif

# Root directory prefix
ifeq ($(CURDIR),/)
ROOT_DIR :=
else
ROOT_DIR := $(CURDIR)
endif

# Directory with the package build recipes
PKG_DIR := pkg

# Directory with the downloaded tarballs and checksums
SRC_DIR := src

# Directory with the intermediate build output
OBJ_DIR := obj/$(TARGET_DIR)

# Directory with the build logs
LOG_DIR := $(ROOT_DIR)/log/$(TARGET_DIR)

# Directory with the installed packages
OUT_DIR := $(ROOT_DIR)/out/$(TARGET_DIR)

# List of the file/directory patterns to purge from OUT_DIR after package install
RMRF_PATHS := /usr/lib/*.la \
	/usr/lib/charset.alias \
	/usr/man \
	/usr/share/aclocal \
	/usr/share/bash-completion \
	/usr/share/emacs \
	/usr/share/doc \
	/usr/share/gdb \
	/usr/share/gettext \
	/usr/share/gtk-doc \
	/usr/share/info \
	/usr/share/man \
	/usr/share/polkit-1 \
	/usr/share/vim \
	/usr/share/xml

# Set sysroot and base path to the LLVM binaries
ifeq ($(STAGE),stage1)
# Link against host system libraries
SYSROOT :=
# Use LLVM binaries from host PATH
HOST_LLVM_DIR :=

else ifeq ($(STAGE),stage2)
# Link against stage2 libraries
SYSROOT := $(ROOT_DIR)/out/stage2
# Use LLVM binaries from stage1
HOST_LLVM_DIR := $(ROOT_DIR)/out/stage1/usr/bin/

else ifeq ($(STAGE),stage3)
# Link against stage3 libraries
SYSROOT := $(ROOT_DIR)/out/stage3
# Use LLVM binaries from stage2
HOST_LLVM_DIR := $(ROOT_DIR)/out/stage2/usr/bin/

else ifeq ($(STAGE),stage4)
# Link against stage4 libraries
SYSROOT := $(ROOT_DIR)/out/stage4
# Use LLVM binaries from stage3 chroot
HOST_LLVM_DIR :=

else
# Link against target cross-compiled libraries
SYSROOT := $(OUT_DIR)
# Use LLVM binaries from chroot PATH
HOST_LLVM_DIR :=
endif

# Configure LLVM/Clang build environment
export AR := $(HOST_LLVM_DIR)llvm-ar
export CC := $(HOST_LLVM_DIR)clang
export CPP := $(HOST_LLVM_DIR)clang-cpp
export CXX := $(HOST_LLVM_DIR)clang++
export LD := $(HOST_LLVM_DIR)lld
export NM := $(HOST_LLVM_DIR)llvm-nm
export OBJCOPY := $(HOST_LLVM_DIR)llvm-objcopy
export OBJDUMP := $(HOST_LLVM_DIR)llvm-objdump
export RANLIB := $(HOST_LLVM_DIR)llvm-ranlib
export READELF := $(HOST_LLVM_DIR)llvm-readelf
export STRIP := $(HOST_LLVM_DIR)llvm-strip
export CFLAGS := -pipe -static -fno-pic -fno-pie
export CXXFLAGS := -pipe -static -fno-pic -fno-pie
export LDFLAGS := -static -static-libgcc -Wl,-no-pie -Wl,-no-dynamic-linker -Wl,-no-export-dynamic -Wl,--gc-sections

ifeq ($(CONFIG),Debug)
export CFLAGS += -O0 -g
export CXXFLAGS += -O0 -g
else ifeq ($(CONFIG),Release)
export CFLAGS += -O3
export CXXFLAGS += -O3
export LDFLAGS += -s
else ifeq ($(CONFIG),RelWithDebInfo)
export CFLAGS += -O3 -g
export CXXFLAGS += -O3 -g
else ifeq ($(CONFIG),MinSizeRel)
export CFLAGS += -Os
export CXXFLAGS += -Os
export LDFLAGS += -s
endif

# Use default CFLAGS/CXXFLAGS/LDFLAGS when building stage1 with host toolchain
# -U_FORTIFY_SOURCE prevents libc++abi from pulling glibc __fprintf_chk
ifeq ($(STAGE),stage1)
export CFLAGS     := -U_FORTIFY_SOURCE
export CXXFLAGS   := -U_FORTIFY_SOURCE
export LDFLAGS    :=
endif

# Print compiler diagnostic output: make V=2
ifeq ($(V),2)
export CFLAGS += -v
export CXXFLAGS += -v
export LDFLAGS += -v
endif

# Capture the current CFLAGS/CXXFLAGS/LDFLAGS (without --sysroot/-target ) for HOST-targeting tools
HOST_CFLAGS := $(CFLAGS)
HOST_CXXFLAGS := $(CXXFLAGS)
HOST_LDFLAGS := $(LDFLAGS)

# Set sysroot directory
ifneq ($(SYSROOT),)
export CFLAGS += --sysroot=$(SYSROOT)
export CXXFLAGS += --sysroot=$(SYSROOT)
export LDFLAGS += --sysroot=$(SYSROOT)
export PKG_CONFIG_LIBDIR := $(SYSROOT)/usr/lib/pkgconfig:$(SYSROOT)/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR := $(SYSROOT)
export PYTHONPATH := $(SYSROOT)/usr/lib/python3.9/site-packages
endif

# Set target ABI for clang cross-compiler
ifeq ($(CROSS),1)
export CFLAGS += -target $(TARGET)
export CXXFLAGS += -target $(TARGET)
export LDFLAGS += -target $(TARGET)
endif

# Enable LTO when not bootstrapping
# Note: LLVM linker emits error when LTO is enabled for riscv64:
#  Hard-float 'd' ABI can't be used for a target that doesn't support the D instruction set extension (ignoring target-abi)
ifneq (,$(findstring riscv,$(TARGET)))
ifeq ($(CROSS),1)
ifneq ($(CONFIG),Debug)
export CFLAGS += -flto
export CXXFLAGS += -flto
endif
endif
endif

ifneq (,$(findstring aarch64,$(TARGET)))
# Target Cortex-A53
export CFLAGS += -march=armv8-a+crc -mtune=cortex-a53
export CXXFLAGS += -march=armv8-a+crc -mtune=cortex-a53
export LDFLAGS += -march=armv8-a+crc -mtune=cortex-a53
else ifneq (,$(findstring arm,$(TARGET)))
# Target ARMv7 with neon FPU
export CFLAGS += -march=armv7-a -mfpu=neon-vfpv4
export CXXFLAGS += -march=armv7-a -mfpu=neon-vfpv4
export LDFLAGS += -march=armv7-a -mfpu=neon-vfpv4
else ifneq (,$(findstring x86_64,$(TARGET)))
# Do not leak host CPU features onto the target
export CFLAGS += -mtune=generic
export CXXFLAGS += -mtune=generic
export LDFLAGS += -mtune=generic
else ifneq (,$(findstring 86,$(TARGET)))
# Target i686 Pentium M
export CFLAGS += -march=pentium-m -mtune=generic -fomit-frame-pointer
export CXXFLAGS += -march=pentium-m -mtune=generic -fomit-frame-pointer
export LDFLAGS += -march=pentium-m -mtune=generic
else ifneq (,$(findstring riscv64,$(TARGET)))
# Target RV64GC
export CFLAGS += -march=rv64gc -mabi=lp64d -mno-relax
export CXXFLAGS += -march=rv64gc -mabi=lp64d -mno-relax
export LDFLAGS += -march=rv64gc -mabi=lp64d -mno-relax
endif

# Print diagnostic output: make V=1
ifneq ($(V),)
ifneq ($(STAGE),)
$(info export STAGE=$(STAGE))
endif
$(info export CFLAGS="$(CFLAGS)")
$(info export CXXFLAGS="$(CXXFLAGS)")
$(info export LDFLAGS="$(LDFLAGS)")
endif

# Define path to the host Python interpreter
ifeq ($(STAGE),stage3)
PYTHON := $(ROOT_DIR)/out/stage3/usr/bin/python3
else ifeq ($(STAGE),stage4)
PYTHON := $(ROOT_DIR)/out/stage4/usr/bin/python3
else
PYTHON := $(shell which python)
endif

# Define standard configure args for Meson build system
meson_pkg_configure := meson \
	--prefix=/usr \
	--libdir=/usr/lib \
	--sysconfdir=/etc \
	--mandir=/usr/share/man \
	--localstatedir=/var \
	-Ddefault_library=static

ifeq ($(CONFIG),Debug)
meson_pkg_configure += --buildtype=debug
else ifeq ($(CONFIG),Release)
meson_pkg_configure += --buildtype=release
else ifeq ($(CONFIG),RelWithDebInfo)
meson_pkg_configure += --buildtype=debugoptimized
else ifeq ($(CONFIG),MinSizeRel)
meson_pkg_configure += --buildtype=minsize
else
meson_pkg_configure += --buildtype=custom
endif

# Use cross-compilation definitions from /usr/share/meson/cross
ifeq ($(CROSS),1)
meson_pkg_configure += --cross-file $(TARGET).txt
endif

# Define standard configure args for CMake build system
cmake_pkg_configure := cmake \
	-G Ninja \
	-DCMAKE_C_COMPILER=$(CC) \
	-DCMAKE_CXX_COMPILER=$(CXX) \
	-DCMAKE_LINKER=$(LD) \
	-DCMAKE_BUILD_TYPE:STRING=$(CONFIG) \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DCMAKE_INSTALL_LIBDIR:STRING=lib \
	-DINSTALL_SYSCONFDIR:PATH=/etc \
	-DCMAKE_SKIP_RPATH:BOOL=ON \
	$(if $(SYSROOT),-DCMAKE_SYSROOT=$(SYSROOT),)

# Define custom args for cross-compilation
ifeq ($(CROSS),1)
ifneq (,$(findstring aarch64,$(TARGET)))
cmake_target_arch := aarch64
else ifneq (,$(findstring arm,$(TARGET)))
cmake_target_arch := arm
else ifneq (,$(findstring x86_64,$(TARGET)))
cmake_target_arch := x86_64
else ifneq (,$(findstring 86,$(TARGET)))
cmake_target_arch := x86
else ifneq (,$(findstring riscv,$(TARGET)))
cmake_target_arch := riscv
else
$(error Unsupported TARGET: $(TARGET))
endif

cmake_pkg_configure += \
	-DCMAKE_SYSTEM_NAME=Linux \
	-DCMAKE_SYSTEM_PROCESSOR=$(cmake_target_arch) \
	-DCMAKE_C_COMPILER_TARGET=$(TARGET) \
	-DCMAKE_CXX_COMPILER_TARGET=$(TARGET) \
	-DCMAKE_ASM_COMPILER_TARGET=$(TARGET) \
	-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
	-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
	-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
	-DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY
endif

# Default target: build all TARGET_PKGS to OBJ_DIR
all: $(TARGET_PKGS)

# Install target: install all TARGET_PKGS to OUT_DIR
install: $(addprefix install-,$(TARGET_PKGS))

# Clean all build/$(TARGET)/obj_*
clean:
	rm -rf $(OBJ_DIR)

# Load recipes for source downloading
include fetch.mk

# Load recipes for chroot preparation
include chroot.mk

# Load recipes for stage bootstrapping
include bootstrap.mk

# Define standard packaging recipes for $(1)
define pkg_add =

# Define variables that can be used by $(1).mk
# Note: pkg_srcdir is relative to pkg_objdir
# pkg_files and pkj_objdir are absolute paths
pkg_srcdir := ../src_$(1)
pkg_objdir := $(ROOT_DIR)/$(OBJ_DIR)/obj_$(1)
pkg_files  := $(ROOT_DIR)/$(PKG_DIR)/files/$(1)

# Load packaging variables and functions
include $(PKG_DIR)/$(1).mk

# Save global variables as package-specific variables
$(1)_ver := $$(pkg_ver)
$(1)_site := $$(pkg_site)
$(1)_repo := $$(pkg_repo)
$(1)_url := $$(pkg_url)
$(1)_base := $$(pkg_base)
$(1)_dir := $$(pkg_dir)
$(1)_deps := $$(pkg_deps)
$(1)_copy := $$(pkg_copy)
$(1)_vars := $$(pkg_vars)
$(1)_prepare := $$(pkg_prepare)
$(1)_configure := $$(pkg_configure)
$(1)_build := $$(pkg_build)
$(1)_check := $$(pkg_check)
$(1)_install := $$(pkg_install)

# Replace empty phases with 'true' command
ifeq ($$($(1)_prepare),)
$(1)_prepare := true
endif
ifeq ($$($(1)_configure),)
$(1)_configure := true
endif
ifeq ($$($(1)_build),)
$(1)_build := true
endif
ifeq ($$($(1)_check),)
$(1)_check := true
endif
ifeq ($$($(1)_install),)
$(1)_install := true
endif

# Check if the pkg_base variable was not set in .mk
ifeq ($$($(1)_base),)
$(1)_base := $(1)
endif

# Check if the pkg_dir variable was not set in .mk
ifeq ($$($(1)_dir),)
$(1)_dir := $$($(1)_base)-$$($(1)_ver)
endif

# Add standard build dependencies (STAGE1_PKGS)
ifneq ($(filter-out $(STAGE1_PKGS),$(1)),)
	$(1)_deps += llvm
endif

# Check if the obj_$(1) directory needs to contain the source
ifeq ($$($(1)_copy),)
$(1)_mkobjdir := mkdir -p $(OBJ_DIR)/obj_$(1)
else
$(1)_mkobjdir := rm -rf $(OBJ_DIR)/obj_$(1) && cp -rvsL $(ROOT_DIR)/$(SRC_DIR)/$$($(1)_dir) $(OBJ_DIR)/obj_$(1)
endif

# Check if the package defines explicit download URL
ifeq ($$($(1)_url),)
$$(patsubst %.sha256sum,%,$$(wildcard $(SRC_DIR)/$$($(1)_dir).*)): DL_SITE = $$($(1)_site)
else
$$(patsubst %.sha256sum,%,$$(wildcard $(SRC_DIR)/$$($(1)_dir).*)): DL_URL = $$($(1)_url)
endif

# Include the package source directory in the 'fetch' target
fetch: | $(SRC_DIR)/$$($(1)_dir)

# Create symbolic link to source directory
$(OBJ_DIR)/src_$(1): $(SRC_DIR)/$$($(1)_dir) | $(OBJ_DIR) $(LOG_DIR)
	ln -sfvT ../../$$< $$@

# Create the package build directory
$(OBJ_DIR)/obj_$(1): | $(OBJ_DIR)/src_$(1)
	$$($(1)_mkobjdir)

# Prepare package
$(OBJ_DIR)/obj_$(1)/.prepare.stamp: $(PKG_DIR)/$(1).mk | $(OBJ_DIR)/obj_$(1) \
	$$(addprefix install-,$$($(1)_deps))
	cd $(OBJ_DIR)/obj_$(1) && $$($(1)_vars) $$($(1)_prepare)
	touch $$@

# Configure package
$(OBJ_DIR)/obj_$(1)/.configure.stamp: $(OBJ_DIR)/obj_$(1)/.prepare.stamp
	cd $(OBJ_DIR)/obj_$(1) && $$($(1)_vars) $$($(1)_configure) 2>&1 | \
		tee $(LOG_DIR)/`date '+%Y%m%d-%H%M%S'`-$(1)-configure.log
	touch $$@

# Build package
$(OBJ_DIR)/obj_$(1)/.build.stamp: $(OBJ_DIR)/obj_$(1)/.configure.stamp
	cd $(OBJ_DIR)/obj_$(1) && $$($(1)_vars) $$($(1)_build) 2>&1 | \
		tee $(LOG_DIR)/`date '+%Y%m%d-%H%M%S'`-$(1)-build.log
	touch $$@

# Install package
$(OBJ_DIR)/obj_$(1)/.install.stamp: $(OBJ_DIR)/obj_$(1)/.build.stamp | $(OUT_DIR)
	cd $(OBJ_DIR)/obj_$(1) && $$($(1)_vars) $$($(1)_install) 2>&1 | \
		tee $(LOG_DIR)/`date '+%Y%m%d-%H%M%S'`-$(1)-install.log
	@rm -rvf $(addprefix $(OUT_DIR), $(RMRF_PATHS))
	pkg/maint/list.sh $(1) $(TARGET) $(OUT_DIR)
	touch $$@

# Define alias for the build rule
$(1): $(OBJ_DIR)/obj_$(1)/.build.stamp

# Define alias for the install rule
install-$(1): $(OBJ_DIR)/obj_$(1)/.install.stamp

# Define custom rule to run the test suite
check-$(1): $(1)
	cd $(OBJ_DIR)/obj_$(1) && $$($(1)_vars) $$($(1)_check) 2>&1 | \
		tee $(LOG_DIR)/`date '+%Y%m%d-%H%M%S'`-$(1)-check.log

# Define custom rule to cleanup package build directory
clean-$(1):
	rm -rf $(OBJ_DIR)/obj_$(1)

.PHONY: $(1) install-$(1) clean-$(1)

# Cleanup the global packaging variables
pkg_srcdir :=
pkg_objdir :=
pkg_files :=
pkg_ver :=
pkg_site :=
pkg_repo :=
pkg_url :=
pkg_base :=
pkg_dir :=
pkg_deps :=
pkg_copy :=
pkg_vars :=
pkg_prepare :=
pkg_configure :=
pkg_build :=
pkg_check :=
pkg_install :=

endef # pkg_add

# To debug this macro, uncomment the below line:
#$(error $(call pkg_add,make))

# Note: package recipes can be loaded in arbitrary order
# sorting ensures deterministic behavior
pkgs := $(patsubst pkg/%.mk,%,$(sort $(wildcard $(PKG_DIR)/*.mk)))

# Load package recipes from pkg/*.mk
$(foreach pkg,$(pkgs),$(eval $(call pkg_add,$(pkg))))

# Create the top-level build directory
$(OBJ_DIR):
	mkdir -p $@

# Create the log directory
$(LOG_DIR):
	mkdir -p $@

# Create the install directory and the necessary symlinks
$(OUT_DIR):
	mkdir -p $(OUT_DIR)/etc $(OUT_DIR)/usr/bin $(OUT_DIR)/usr/lib
	cp -rv $(PKG_DIR)/etc/* $(OUT_DIR)/etc
	ln -sfvT usr/bin $(OUT_DIR)/bin
	ln -sfvT usr/lib $(OUT_DIR)/lib
	ln -sfvT usr/bin $(OUT_DIR)/sbin
	pkg/maint/list.sh baselayout $(TARGET) $(OUT_DIR)

# Load recipes for rootfs creation
include rootfs.mk

# Load maintainer scripts
include maint.mk

.PHONY: all install clean
