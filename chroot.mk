# Set command for priviledged operations
SUDO_CMD ?= sudo

# Set command to enter chroot
CHROOT_CMD ?= $(shell which chroot)

# Set command executed in chroot
CHROOT_PROG ?= /usr/bin/bash -l

mount:
	@mkdir -p dev proc sys
	@mountpoint dev  >/dev/null 2>&1 || $(SUDO_CMD) mount --rbind /dev dev
	@mountpoint proc >/dev/null 2>&1 || $(SUDO_CMD) mount -t proc none proc
	@mountpoint sys  >/dev/null 2>&1 || $(SUDO_CMD) mount -t sysfs none sys

tmp:
	install -d -m 0777 tmp

# Enter chroot
chroot: mount
	$(SUDO_CMD) env -i PATH=/usr/bin TERM=$(TERM) SHELL=/usr/bin/bash HOME=/root $(CHROOT_CMD) $(CURDIR) $(CHROOT_PROG)

.PHONY: mount chroot
