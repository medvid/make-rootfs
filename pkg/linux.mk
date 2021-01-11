pkg_ver  := 5.10.6
pkg_repo := https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
pkg_site := https://cdn.kernel.org/pub/linux/kernel/v5.x

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

pkg_prepare := cp -v $(pkg_files)/$(TARGET).config $(pkg_objdir)/.config

pkg_build := make -C $(pkg_srcdir) \
	O=$(pkg_objdir) \
	LLVM=1 \
	LLVM_IAS=1 \
	ARCH=$(linux_arch) \
	CROSS_COMPILE=$(TARGET)- \
	HOST_LFS_CFLAGS="$(HOST_CFLAGS)" \
	olddefconfig all

pkg_install := false
