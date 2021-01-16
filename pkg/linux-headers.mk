# https://repology.org/project/linux
# https://git.alpinelinux.org/aports/tree/main/linux-headers/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/linux-headers/linux-headers.mk
# https://github.com/kisslinux/repo/blob/master/core/linux-headers/build

pkg_ver  := 5.7.12
pkg_repo := https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
pkg_site := https://cdn.kernel.org/pub/linux/kernel/v5.x
pkg_base := linux
pkg_deps := musl

# Set the kernel target arch
ifneq (,$(findstring aarch64,$(TARGET)))
linux_arch := arm64
else ifneq (,$(findstring arm,$(TARGET)))
linux_arch := arm
else ifneq (,$(findstring mips,$(TARGET)))
linux_arch := mips
else ifneq (,$(findstring ppc,$(TARGET)))
linux_arch := powerpc
else ifneq (,$(findstring riscv,$(TARGET)))
linux_arch := riscv
else ifneq (,$(findstring 86,$(TARGET)))
linux_arch := x86
else
$(error Unsupported TARGET: $(TARGET))
endif

pkg_build := make -C $(pkg_srcdir) \
	O=$(pkg_objdir) \
	LLVM=1 \
	LLVM_IAS=1 \
	ARCH=$(linux_arch) \
	CROSS_COMPILE=$(TARGET)- \
	HOST_LFS_CFLAGS="$(HOST_CFLAGS)" \
	INSTALL_HDR_PATH=$(pkg_objdir)/staged \
	headers_install && \
	find $(pkg_objdir)/staged/include '(' -name .install -o -name ..install.cmd ')' -exec rm {} +

pkg_install := mkdir -p $(OUT_DIR)/usr/include && \
	cp -R $(pkg_objdir)/staged/include/* $(OUT_DIR)/usr/include
