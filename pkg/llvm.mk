pkg_ver  := 11.0.0rc2
pkg_repo := https://github.com/llvm/llvm-project
pkg_site := $(pkg_repo)/releases/download/llvmorg-$(subst rc,-rc,$(pkg_ver))
pkg_base := llvm-project
pkg_deps := linux-headers

# Set the LLVM target arch
# See LLVM_ALL_TARGETS in llvm/CMakeLists.txt
ifneq (,$(findstring aarch64,$(TARGET)))
llvm_target_arch := AArch64
else ifneq (,$(findstring arm,$(TARGET)))
llvm_target_arch := ARM
else ifneq (,$(findstring mips,$(TARGET)))
llvm_target_arch := Mips
else ifneq (,$(findstring ppc,$(TARGET)))
llvm_target_arch := PowerPC
else ifneq (,$(findstring riscv,$(TARGET)))
llvm_target_arch := RISCV
else ifneq (,$(findstring 86,$(TARGET)))
llvm_target_arch := X86
else
$(error Unsupported TARGET: $(TARGET))
endif

# Include all supported LLVM targets in the final cross-compiling toolchain
# produced by bootstrap stage4. stage1/stage2/stage3 toolchains are host-only.
ifeq ($(STAGE),stage4)
llvm_target_arch := all
endif

pkg_configure := cmake -G Ninja $(pkg_srcdir)/llvm \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DLLVM_ENABLE_PROJECTS:STRING="clang;libcxx;libcxxabi;libunwind;compiler-rt;lld" \
	-DLLVM_DEFAULT_TARGET_TRIPLE:STRING="$(TARGET)" \
	-DLLVM_TARGETS_TO_BUILD:STRING="$(llvm_target_arch)" \
	-DLLVM_ENABLE_BINDINGS:BOOL=OFF \
	-DLLVM_ENABLE_LIBCXX:BOOL=ON \
	-DLLVM_ENABLE_LIBEDIT:BOOL=OFF \
	-DLLVM_ENABLE_LIBPFM:BOOL=OFF \
	-DLLVM_ENABLE_LIBXML2:BOOL=OFF \
	-DLLVM_ENABLE_LTO:BOOL=OFF \
	-DLLVM_ENABLE_PIC:BOOL=OFF \
	-DLLVM_ENABLE_PLUGINS:BOOL=OFF \
	-DLLVM_ENABLE_TERMINFO:BOOL=OFF \
	-DLLVM_ENABLE_Z3_SOLVER:BOOL=OFF \
	-DCLANG_DEFAULT_LINKER:STRING="lld" \
	-DCLANG_DEFAULT_OBJCOPY:STRING="llvm-objcopy" \
	-DCLANG_DEFAULT_CXX_STDLIB:STRING="libc++" \
	-DCLANG_DEFAULT_RTLIB:STRING="compiler-rt" \
	-DCLANG_DEFAULT_UNWINDLIB:STRING="libunwind" \
	-DCLANG_ENABLE_ARCMT:BOOL=OFF \
	-DCLANG_ENABLE_STATIC_ANALYZER:BOOL=OFF \
	-DCLANG_PLUGIN_SUPPORT:BOOL=OFF \
	-DCLANG_TOOL_DRIVER_BUILD:BOOL=ON \
	-DCOMPILER_RT_BUILD_BUILTINS:BOOL=ON \
	-DCOMPILER_RT_BUILD_CRT:BOOL=ON \
	-DCOMPILER_RT_BUILD_LIBFUZZER:BOOL=OFF \
	-DCOMPILER_RT_BUILD_PROFILE:BOOL=OFF \
	-DCOMPILER_RT_BUILD_SANITIZERS:BOOL=OFF \
	-DCOMPILER_RT_BUILD_XRAY:BOOL=OFF \
	-DCOMPILER_RT_INCLUDE_TESTS:BOOL=OFF \
	-DCOMPILER_RT_USE_BUILTINS_LIBRARY:BOOL=ON \
	-DCOMPILER_RT_USE_LIBCXX:BOOL=ON \
	-DLIBCXXABI_ENABLE_ASSERTIONS:BOOL=OFF \
	-DLIBCXXABI_ENABLE_PIC:BOOL=OFF \
	-DLIBCXXABI_ENABLE_SHARED:BOOL=OFF \
	-DLIBCXXABI_ENABLE_STATIC_UNWINDER:BOOL=ON \
	-DLIBCXXABI_INSTALL_LIBRARY:BOOL=OFF \
	-DLIBCXXABI_USE_COMPILER_RT:BOOL=ON \
	-DLIBCXXABI_USE_LLVM_UNWINDER:BOOL=ON \
	-DLIBCXX_ENABLE_SHARED:BOOL=OFF \
	-DLIBCXX_ENABLE_STATIC_ABI_LIBRARY:BOOL=ON \
	-DLIBCXX_STATICALLY_LINK_ABI_IN_STATIC_LIBRARY:BOOL=ON \
	-DLIBCXX_USE_COMPILER_RT:BOOL=ON \
	-DLIBUNWIND_ENABLE_ASSERTIONS:BOOL=OFF \
	-DLIBUNWIND_ENABLE_SHARED:BOOL=OFF \
	-DLIBUNWIND_USE_COMPILER_RT:BOOL=ON

# Enable stage1 bootstrapping from glibc system
ifneq ($(STAGE),stage1)
pkg_configure += \
	-DLIBCXX_HAS_MUSL_LIBC:BOOL=ON
endif

# Use generic CFLAGS/CXXFLAGS/LDFLAGS without --sysroot/-target options
# During bootstrap, sysroot flags are added via CMAKE_SYSROOT
LLVM_CFLAGS     := $(HOST_CFLAGS)
LLVM_CXXFLAGS   := $(HOST_CXXFLAGS)
LLVM_LDFLAGS    := $(HOST_LDFLAGS)

ifeq ($(STAGE),stage1)
# Build stage1 llvm with system clang
# Resulting toolchain is dynamically linked against libgcc_s.so/libstdc++.so
# Ignore global CFLAGS/CXXFLAGS/LDFLAGS by setting custom CMAKE_*_FLAGS
# -U_FORTIFY_SOURCE prevents libc++abi from pulling glibc __fprintf_chk
LLVM_CFLAGS     := -U_FORTIFY_SOURCE
LLVM_CXXFLAGS   := -U_FORTIFY_SOURCE
LLVM_LDFLAGS    := -s
else ifeq ($(STAGE),stage2)
# Build stage2 llvm with stage1 toolchain
pkg_configure += \
	-DCMAKE_SYSROOT=$(ROOT_DIR)/out/stage1 \
	-DCMAKE_C_COMPILER=$(ROOT_DIR)/out/stage1/usr/bin/clang \
	-DCMAKE_CXX_COMPILER=$(ROOT_DIR)/out/stage1/usr/bin/clang++ \
	-DCMAKE_LINKER=$(ROOT_DIR)/out/stage1/usr/bin/lld
else ifeq ($(STAGE),stage3)
# Build stage3 llvm with stage2 toolchain
pkg_configure += \
	-DCMAKE_SYSROOT=$(ROOT_DIR)/out/stage2 \
	-DCMAKE_C_COMPILER=$(ROOT_DIR)/out/stage2/usr/bin/clang \
	-DCMAKE_CXX_COMPILER=$(ROOT_DIR)/out/stage2/usr/bin/clang++ \
	-DCMAKE_LINKER=$(ROOT_DIR)/out/stage2/usr/bin/lld
# Set custom sysroot/target when not bootstrapping
else ifneq ($(STAGE),stage4)
pkg_configure += \
	-DCMAKE_SYSROOT=$(OUT_DIR) \
	-DCMAKE_C_COMPILER_TARGET=$(TARGET) \
	-DCMAKE_CXX_COMPILER_TARGET=$(TARGET) \
	-DCMAKE_ASM_COMPILER_TARGET=$(TARGET) \
	-DLLVM_TABLEGEN=$(ROOT_DIR)/usr/bin/llvm-tblgen \
	-DCLANG_TABLEGEN=$(ROOT_DIR)/usr/bin/clang-tblgen \
	-DCOMPILER_RT_DEFAULT_TARGET_ONLY:BOOL=ON
endif

# Set the customized compilation flags (without --sysroot)
pkg_configure += \
	-DCMAKE_C_FLAGS="$(LLVM_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(LLVM_CXXFLAGS)" \
	-DCMAKE_EXE_LINKER_FLAGS="$(LLVM_LDFLAGS)"

# Unconditionally build standard C/C++ runtimes
llvm_build_targets := compiler-rt cxx unwind

# Build/install toolchain binaries only during bootstrapping stages
ifneq ($(STAGE),)
llvm_build_toolchain := true
endif

ifeq ($(llvm_build_toolchain),true)
llvm_tools := ar as config lto lto2 mt nm objcopy objdump ranlib readelf readobj split strings strip tblgen
llvm_build_targets += clang clang-resource-headers lld $(addprefix llvm-,$(llvm_tools))
pkg_configure += -DCMAKE_TRY_COMPILE_TARGET_TYPE=EXECUTABLE
else
# The CMake test application cannot be linked during initial execution of
# 'builtins' target as crtbeginT.o is not yet built for the target arch.
# Tweak CMake try_compile behavior to resolve chicken-and-egg problem.
# STATIC_LIBRARY test cannot be enabled universally due to CMake bug:
# https://gitlab.kitware.com/cmake/cmake/-/issues/18121
pkg_configure += -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY
endif

ifeq ($(llvm_builtins_only),true)
llvm_build_targets := compiler-rt
endif

llvm_install_targets := $(patsubst %,install-%-stripped,$(llvm_build_targets))

pkg_build := ninja -v $(llvm_build_targets)

pkg_install := DESTDIR=$(OUT_DIR) ninja $(llvm_install_targets)

# Install clang_rt.crtbegin-$(arch).o clang_rt.crtend-$(arch).o libclang_rt.builtins-$(arch).a
# to the location expected by usr/lib/clang: /usr/lib/clang/<version>/lib/linux
# Avoid overwriting the host builtins
ifneq ($(HOST),$(TARGET))
ifeq ($(llvm_builtins_only),true)
pkg_install += && cp -v lib/clang/11.0.0/lib/linux/* $(ROOT_DIR)/usr/lib/clang/11.0.0/lib/linux
endif
endif

# There is no standard CMake rule to install clang-tblgen tool (required by cross build)
ifeq ($(STAGE),stage4)
pkg_install += && cp -v bin/clang-tblgen $(OUT_DIR)/bin/clang-tblgen
endif

# Define custom target for toolchain installation
$(pkg_objdir)/.toolchain.stamp:
	$(MAKE) llvm_build_toolchain=true install-llvm
	touch $@

install-toolchain: $(pkg_objdir)/.toolchain.stamp

# Define custom target for compiler-rt builtins installation
install-builtins:
	$(MAKE) llvm_builtins_only=true install-llvm
	rm -f $(OBJ_DIR)/obj_llvm/.install.stamp

.PHONY: install-toolchain install-builtins
