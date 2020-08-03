# Customize ?= variables
-include config.mk

# Ensure the '| tee' logging recipes return failures
SHELL := $(shell which bash) -o pipefail

# Set the host toolchain triple
HOST ?= x86_64-linux-musl

# Set the list of packages built during bootstrapping stages
HOST_PKGS := musl linux-headers llvm zlib libarchive libressl toybox \
	pkgconf mawk diffutils m4 bash make flex bison bc grep xz wget \
	libffi python ninja cmake rsync perl curl git e2fsprogs gperf \
	meson

# Set the target toolchain triple
TARGET ?= x86_64-linux-musl

# Set the list of target packages
TARGET_PKGS ?= bash toybox finit

# Root directory prefix
ifeq ($(CURDIR),/)
ROOT_DIR :=
else
ROOT_DIR := $(CURDIR)
endif

# Directory with the downloaded tarballs and checksums
SRC_DIR := src

# Directory with the intermediate build output
OBJ_DIR := obj/$(TARGET)

# Directory with the build logs
LOG_DIR := $(ROOT_DIR)/log/$(TARGET)

# Directory with the installed packages
OUT_DIR := $(ROOT_DIR)/out/$(TARGET)

# List of the file/directory patterns to purge from OUT_DIR after package install
RMRF_PATHS := /usr/lib/*.la \
	/usr/lib/charset.alias \
	/usr/share/aclocal \
	/usr/share/bash-completion \
	/usr/share/emacs \
	/usr/share/doc \
	/usr/share/gtk-doc \
	/usr/share/info \
	/usr/share/man \
	/usr/share/vim

# Configure LLVM/Clang build environment
export AR := llvm-ar
export CC := clang
export CPP := clang-cpp
export CXX := clang++
export LD := lld
export NM := llvm-nm
export OBJCOPY := llvm-objcopy
export OBJDUMP := llvm-objdump
export RANLIB := llvm-ranlib
export READELF := llvm-readelf
export STRIP := llvm-strip
export CFLAGS := -O3 -pipe -static -fno-pic -fno-pie
export CXXFLAGS := -O3 -pipe -static -fno-pic -fno-pie
export LDFLAGS := -s -static -static-libgcc -Wl,-no-pie -Wl,-no-dynamic-linker -Wl,-no-export-dynamic -Wl,--gc-sections

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

# Set sysroot directory and target ABI
ifneq ($(STAGE),stage1)
export CFLAGS += --sysroot=$(OUT_DIR) -target $(TARGET)
export CXXFLAGS += --sysroot=$(OUT_DIR) -target $(TARGET)
export LDFLAGS += --sysroot=$(OUT_DIR) -target $(TARGET)
export PKG_CONFIG_LIBDIR = $(OUT_DIR)/usr/lib/pkgconfig:$(OUT_DIR)/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR = $(OUT_DIR)
endif

# Enable LTO when not bootstrapping
ifeq ($(STAGE),)
export CFLAGS += -flto
export CXXFLAGS += -flto
endif

# Print diagnostic output: make V=1
ifneq ($(V),)
ifneq ($(STAGE),)
$(info export STAGE=$(STAGE))
endif
$(info export PATH=$(PATH))
$(info export CFLAGS="$(CFLAGS)")
$(info export CXXFLAGS="$(CXXFLAGS)")
$(info export LDFLAGS="$(LDFLAGS)")
endif

# Define standard packaging recipes for $(1)
define pkg_add =

# Define variables that can be used by $(1).mk
# Note: pkg_srcdir is relative to pkg_objdir
# pkg_files and pkj_objdir are absolute paths
pkg_srcdir := ../src_$(1)
pkg_objdir := $(ROOT_DIR)/$(OBJ_DIR)/obj_$(1)
pkg_files  := $(ROOT_DIR)/pkg/files/$(1)

# Load packaging variables and functions
include pkg/$(1).mk

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

# Add standard build dependencies (BASE_PKGS)
ifneq ($(filter-out $(BASE_PKGS),$(1)),)
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
$(OBJ_DIR)/obj_$(1)/.prepare.stamp: pkg/$(1).mk | $(OBJ_DIR)/obj_$(1) \
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
	touch $$@

# Define alias for the build rule
$(1): $(OBJ_DIR)/obj_$(1)/.build.stamp

# Define alias for the install rule
install-$(1): $(OBJ_DIR)/obj_$(1)/.install.stamp

.PHONY: $(1) install-$(1)

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
pkg_install :=

endef # pkg_add

# To debug this macro, uncomment the below line:
#$(error $(call pkg_add,make))

# Note: package recipes can be loaded in arbitrary order
# sorting ensures deterministic behavior
pkgs := $(patsubst pkg/%.mk,%,$(sort $(wildcard pkg/*.mk)))

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
	cp -rv pkg/etc/* $(OUT_DIR)/etc
	ln -sfvT usr/bin $(OUT_DIR)/bin
	ln -sfvT usr/lib $(OUT_DIR)/lib
	ln -sfvT usr/bin $(OUT_DIR)/sbin

# Load recipes for rootfs creation
include rootfs.mk

.PHONY: all install clean
