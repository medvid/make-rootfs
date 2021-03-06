# https://repology.org/project/linux
# https://git.alpinelinux.org/aports/tree/main/linux-lts/APKBUILD
# https://github.com/distr1/distri/blob/master/pkgs/linux/build.textproto
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/linux/template

pkg_ver  := 5.10.6
pkg_repo := https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
pkg_site := https://cdn.kernel.org/pub/linux/kernel/v5.x

# Set the kernel target arch
ifneq (,$(findstring aarch64,$(TARGET)))
linux_arch := arm64
linux_image := Image.gz
else ifneq (,$(findstring arm,$(TARGET)))
linux_arch := arm
linux_image := zImage
else ifneq (,$(findstring mips,$(TARGET)))
linux_arch := mips
linux_image := vmlinuz
else ifneq (,$(findstring ppc,$(TARGET)))
linux_arch := powerpc
linux_image := zImage
else ifneq (,$(findstring riscv,$(TARGET)))
linux_arch := riscv
linux_image := Image.gz
else ifneq (,$(findstring 86,$(TARGET)))
linux_arch := x86
linux_image := bzImage
else
$(error Unsupported TARGET: $(TARGET))
endif

pkg_prepare := cp -v $(pkg_files)/$(TARGET).config $(pkg_objdir)/.config

pkg_build := make -C $(pkg_srcdir) \
	O=$(pkg_objdir) \
	V=1 \
	LLVM=1 \
	LLVM_IAS=1 \
	ARCH=$(linux_arch) \
	CROSS_COMPILE=$(TARGET)- \
	HOST_LFS_CFLAGS="$(HOST_CFLAGS)" \
	olddefconfig $(linux_image)

pkg_install := install -v -d $(OUT_DIR)/boot && \
	cp -v $(pkg_objdir)/arch/$(linux_arch)/boot/$(linux_image) $(OUT_DIR)/boot/vmlinuz-$(pkg_ver) && \
	cp -v $(pkg_objdir)/System.map $(OUT_DIR)/boot/System.map-$(pkg_ver)
