# make-rootfs

Set of make recipes to bootstrap static musl / llvm based filesystem image.

* `make` - all build recipes are defined as incremental makefile targets

* `rootfs` - produced images can be booted as a standalone Linux root filesystem

Example:

    make rootfs TARGET=armv7-linux-musleabihf

## Software

* musl C library

* LLVM toolchain: clang, lld, libc++, compiler-rt, libunwind

* Toybox set of command line utilities

* Basic GNU toolchain: bash, bc, bison, diffutils, gperf, grep, m4, make, wget

* System tools and libraries: curl, perl, python, rsync, xz, zlib

* Development tools and libraries: cmake, git, flex, libffi, libressl, mawk, ninja, pkgconf

* Finit init system

## Features

* 4-stage bootstrapping of LLVM cross-compiling toolchain

* Deterministically built base system is available as a Docker image

* Easy cross-compilation of the complete filesystem image (rootfs)

* Package build recipes are defined as simple makefile rules

* Fully static executable binaries with LTO enabled

## Goals

* No dynamic loader

* No shared libraries

* No "package management", all build dependencies are tracked by make recipes

* No dependency on GCC, binutils, glibc, libstdc++

## Getting started

This guide is tested on Ubuntu 20.04.
Should work on any Linux distribution with Clang/LLVM >= 6, CMake >= 3.18, Meson >= 0.54.0.

Install the prerequisites:

    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates gnupg software-properties-common
    curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
    sudo apt update
    sudo apt install -y bison clang cmake curl flex gperf libarchive-tools lld llvm m4 make meson ninja-build patch pkg-config python-is-python3 python3-distutils python3-pip rsync sudo

Execute the bootstrap target:

    make bootstrap

The bootstrapping takes significant time (it builds LLVM toolchain 4 times).
Note: the build process requests sudo password during stage4 bootstrapping.
It doesn't modify the filesystem outside of the project root directory.
Root permissions are required only to chroot to the image produced by stage3.

Execute builtins target to install compiler-rt builtin libraries
for all supported target architectures:

    make builtins

Once the bootstrapping completes, chroot to the project directory by executing `make chroot` target:

    make chroot

Inside the chroot, bootstrap the cross-compilation base system by specifying the TARGET variable.
Example for armv7-linux-musleabihf cross-compilation target:

    make TARGET=armv7-linux-musleabihf install

Cross-compile the packages by providing the custom build targets that match the package names inside pkg/\*.mk.
The below example installs out/armv7-linux-musleabihf/usr/bin/bash and out/armv7-linux-musleabihf/usr/bin/toybox:

    make TARGET=armv7-linux-musleabihf install-bash install-toybox

It is also possible to cross-compile packages without interactively entering chroot,
by providing the custom CHROOT_PROG command and overriding TARGET_PKGS makefile variable:

    make chroot CHROOT_PROG="make TARGET=armv7-linux-musleabihf TARGET_PKGS='bash toybox' install"

## Supported targets

Supported target triples:

* x86_64-linux-musl
* i386-linux-musl
* armv7-linux-musleabihf
* aarch64-linux-musl

References:

* https://clang.llvm.org/docs/CrossCompilation.html#target-triple
* https://github.com/llvm/llvm-project/blob/master/llvm/lib/Support/Triple.cpp
* https://github.com/rust-lang/rust/blob/master/src/tools/build-manifest/src/main.rs

## Bootstrapping process

The host toolchain bootstrapping consists of 4 stages:

* stage1: use host LLVM toolchain to compile musl libc, Linux kernel headers and LLVM toolchain (dynamically linked).

* stage2: use LLVM toolchain and sysroot produced by stage1 to compile full-static LLVM toolchain.

* stage3: use LLVM toolchain and sysroot produced by stage2 to compile another LLVM build and base build utilities (bash, make, ...).

* stage4: chroot into sysroot produced by stage3 and rebuild it again.

The 4 stages are required to get rid of any host dependencies like compiler builtins, C and C++ runtimes, and to prove the base system is capable to reproduce itself.

Below section describes the bootstrapping process in details.

### stage1

1. The musl C library is compiled using /usr/bin/clang in obj/stage1/obj_musl, and installed into out/stage1.

2. Linux kernel headers are built in obj/stage1/obj_linux-headers, and installed into out/stage1/usr/include.

3. LLVM toolchain is compiled in obj/stage1/obj_llvm, and installed into out/stage1.

   Note: the toolchain binaries are not portable: dynamically linked against
       the host libc.so / libstdc++.so / libgcc_s.so.
   But, such toolchain is already configured to produce full static binaries
   linked against LLVM libc++, libunwind and compiler-rt builtins as long
   as correct CFLAGS / CXXFLAGS / LDFLAGS are passed to the compiler / linker.

### stage2

1. The musl C library is compiled using out/stage1/usr/bin/clang in obj/stage2/obj_musl, and installed into out/stage2.

2. Linux kernel headers are built in obj/stage2/obj_linux-headers, and installed into out/stage2/usr/include.

3. LLVM toolchain is compiled in obj/stage2/obj_llvm, using obj/stage1 sysroot, and installed into out/stage2.

### stage3

1. The musl C library is compiled using out/stage2/usr/bin/clang in obj/stage3/obj_musl and installed into out/stage3/usr.

2. Linux kernel headers are processed in obj/stage3/obj_linux-headers and installed into out/stage3/usr/include.

3. LLVM toolchain is compiled in obj/stage3/obj_llvm using obj/stage2 sysroot, and installed into out/stage3.

4. Base system utilities are compiled in obj/stage3 using obj/stage2 sysroot, and installed into out/stage3: see HOST_PKGS variable in the top-level Makefile.

5. pkg/etc and out/stage3/etc are copied to the project top-level directory:

        pkg/etc/*: copied to etc
        out/stage3/etc/*: copied to etc

6. stage3 sysroot is linked into the project top-level directory:

        usr: links to out/stage3/usr
        bin: links to usr/bin
        lib: links to usr/lib
        sbin: links to usr/bin

### stage4

1. The makefile executes 'chroot' target that mounts /dev, /sys, /proc virtual
   filesystems and enters the chroot environment at the project top-level directory.

2. Starting from this point, all makefile targets are always executed from the chroot environment.

3. The musl C library is compiled in obj/stage4/obj_musl using /usr/bin/clang (which is actually out/stage3/usr/bin/clang), and installed into out/stage4/usr.

4. Linux kernel headers are built in obj/stage4/obj_linux-headers, and installed into out/stage4/usr/include.

5. LLVM toolchain and base system utilities are compiled in obj/stage4, and installed into out/stage4

6. pkg/etc and out/stage4/etc are copied to the project top-level directory:

        pkg/etc/*: copied to etc
        out/stage4/etc/*: copied to etc

7. The system is bootstrapped and ready to cross-compile target packages inside the interactive shell entered by "make chroot".

## Similar projects

Borrowed many ideas and snippets from these projects:

* https://github.com/richfelker/musl-cross-make

* https://github.com/landley/mkroot

* https://skarnet.org/software/lh-bootstrap/

Buildroot implements a similar concept of makefile-driven package management:

* https://buildroot.org/

This project is basically a primitive re-implementation of some Buildroot ideas,
without any configurability-related complexity (Kconfig).

Other statically linked Linux systems:

* https://sta.li/

* https://github.com/oasislinux/oasis
