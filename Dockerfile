# Step#1: build stage1, stage2, stage3
FROM ubuntu:20.04 AS base

# https://askubuntu.com/a/1013396
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt update -y \
 && apt install -y apt-transport-https ca-certificates gnupg software-properties-common \
 && curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
 && apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ focal main' \
 && apt update -y \
 && apt install -y bison clang cmake curl flex gperf libarchive-tools lld llvm m4 make meson ninja-build patch pkg-config python-is-python3 python3-distutils python3-pip rsync sudo \
 && apt clean

# Copy build recipes
COPY . /opt/make-rootfs

# Bootstrap stage1, stage2, stage3
RUN make -C /opt/make-rootfs stage1
RUN make -C /opt/make-rootfs stage2
RUN make -C /opt/make-rootfs stage3

# Step#2: copy output/stage3 to root
FROM scratch as stage4
SHELL ["/out/stage3/usr/bin/bash", "-c"]
COPY . /
# Copy stage3 from base image
COPY --from=base /opt/make-rootfs/out/stage3/etc /etc
COPY --from=base /opt/make-rootfs/out/stage3/usr /out/stage3/usr
RUN /out/stage3/usr/bin/ln -sv out/stage3/usr /usr \
 && /out/stage3/usr/bin/ln -sv usr/bin /bin \
 && /out/stage3/usr/bin/ln -sv usr/lib /lib
# Bootstrap stage4
RUN /out/stage3/usr/bin/make -C / stage4
# Switch to stage4 in-place
RUN /out/stage3/usr/bin/ln -sfvT out/stage4/usr /usr
# Generate compiler-rt builtins
RUN /usr/bin/make -C / install-builtins TARGET=x86_64-linux-musl
RUN /usr/bin/make -C / install-builtins TARGET=i386-linux-musl
RUN /usr/bin/make -C / install-builtins TARGET=armv7-linux-musleabihf
RUN /usr/bin/make -C / install-builtins TARGET=aarch64-linux-musl

# Step#3: copy output/stage4 to root
FROM scratch
SHELL ["/usr/bin/bash", "-c"]
COPY --from=stage4 /out/stage4/etc /etc
COPY --from=stage4 /out/stage4/usr /usr
RUN ln -sv usr/bin /bin && ln -sv usr/lib /lib
