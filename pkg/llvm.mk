# https://repology.org/project/llvm
# https://git.alpinelinux.org/aports/tree/main/llvm10/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/llvm/llvm.mk
# https://github.com/kisslinux/repo/blob/master/extra/llvm/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/llvm11/template

pkg_ver  := 11.0.0
pkg_repo := https://github.com/llvm/llvm-project
pkg_site := $(pkg_repo)/releases/download/llvmorg-$(pkg_ver)
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

# Set CMAKE_SIZEOF_VOID_P for builtins-only build
ifneq (,$(findstring 64,$(TARGET)))
llvm_sizeof_void := 8
else ifneq (,$(findstring 32,$(TARGET)))
llvm_sizeof_void := 4
else ifneq (,$(findstring 86,$(TARGET)))
llvm_sizeof_void := 4
else ifneq (,$(findstring arm,$(TARGET)))
llvm_sizeof_void := 4
else
$(error Unsupported TARGET: $(TARGET))
endif

# Include all supported LLVM targets in the final cross-compiling toolchain
# produced by bootstrap stage4. stage1/stage2/stage3 toolchains are host-only.
ifeq ($(STAGE),stage4)
llvm_target_arch := all
endif

pkg_configure := $(cmake_pkg_configure) \
	$(pkg_srcdir)/llvm \
	-DCMAKE_DISABLE_FIND_PACKAGE_Backtrace:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Git:BOOL=ON \
	-DLLVM_ENABLE_PROJECTS:STRING="clang;libcxx;libcxxabi;libunwind;compiler-rt;lld;lldb" \
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
pkg_configure += -DLIBCXX_HAS_MUSL_LIBC:BOOL=ON
endif

# Link LLVM tools against musl/libc++ from the previuos stage
ifeq ($(STAGE),stage2)
pkg_configure += -DCMAKE_SYSROOT:PATH=$(ROOT_DIR)/out/stage1
else ifeq ($(STAGE),stage3)
pkg_configure += -DCMAKE_SYSROOT:PATH=$(ROOT_DIR)/out/stage2
else ifeq ($(STAGE),stage4)
pkg_configure += -DCMAKE_SYSROOT:PATH=$(ROOT_DIR)/out/stage3
endif

# Ignore --sysroot argument from CFLAGS/CXXFLAGS/LDFLAGS
ifeq ($(CROSS),0)
pkg_configure += \
	-DCMAKE_C_FLAGS="$(HOST_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(HOST_CXXFLAGS)" \
	-DCMAKE_EXE_LINKER_FLAGS="$(HOST_LDFLAGS)"
endif

# Do not build llvm-tblgen and clang-tblgen when cross-compiling
ifeq ($(CROSS),1)
pkg_configure += \
	-DLLVM_TABLEGEN=$(ROOT_DIR)/usr/bin/llvm-tblgen \
	-DCLANG_TABLEGEN=$(ROOT_DIR)/usr/bin/clang-tblgen \
	-DCOMPILER_RT_DEFAULT_TARGET_ONLY:BOOL=ON
endif

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
pkg_configure += -DCMAKE_SIZEOF_VOID_P=$(llvm_sizeof_void)
endif

ifeq ($(STAGE),stage4)
llvm_build_lldb := true
endif

ifeq ($(llvm_build_lldb),true)
llvm_build_targets += lldb lldb-server
pkg_configure += \
	-DLLVM_TOOL_LLDB_BUILD:BOOL=ON \
	-DLLDB_ENABLE_LIBEDIT:BOOL=ON \
	-DLLDB_ENABLE_CURSES:BOOL=ON \
	-DLLDB_ENABLE_LZMA:BOOL=ON \
	-DLLDB_ENABLE_LUA:BOOL=OFF \
	-DLLDB_ENABLE_PYTHON:BOOL=OFF \
	-DLLDB_ENABLE_LIBXML2:BOOL=OFF \
	-DLLDB_USE_SYSTEM_SIX:BOOL=OFF \
	-DLLDB_INCLUDE_TESTS:BOOL=OFF
else
pkg_configure += \
	-DCMAKE_DISABLE_FIND_PACKAGE_Git:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LibEdit:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_CursesAndPanel:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LibLZMA:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LuaAndSwig:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_PythonInterpAndLibs:BOOL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LibXml2:BOOL=ON
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
pkg_install += && cp -v lib/clang/$(pkg_ver)/lib/linux/* $(ROOT_DIR)/usr/lib/clang/$(pkg_ver)/lib/linux
endif
endif

# There is no standard CMake rule to install clang-tblgen tool (required by cross build)
ifeq ($(STAGE),stage4)
pkg_install += && cp -v bin/clang-tblgen $(OUT_DIR)/usr/bin/clang-tblgen
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
