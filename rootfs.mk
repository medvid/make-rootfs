IMG_SIZE := 1GB
IMG_FILE := $(OUT_DIR).img
LOOP_DEV := /dev/loop0
#$(eval LOOP_DEV := $(shell losetup -fs $(IMG_FILE)))

rootfs:
	rm -f $(IMG_FILE)
	fallocate -l $(IMG_SIZE) $(IMG_FILE)
	losetup -D
	losetup -fs $(IMG_FILE)
	#losetup --find --partscan --show $(IMG_FILE)
	# ignore BLKRRPART ioctl error reported by fdisk
	printf "o\nn\np\n1\n\n\nw\n" | fdisk $(LOOP_DEV) || true
	partprobe $(LOOP_DEV) || true
	losetup -d $(LOOP_DEV)
	losetup -fs $(IMG_FILE)
	#losetup --find --partscan --show $(IMG_FILE)
	fdisk -l $(LOOP_DEV)
	mkfs.ext4 $(LOOP_DEV)
	mkdir -p /mnt/$(TARGET)
	mount -t ext4 $(LOOP_DEV)p1 /mnt/$(TARGET)
	rsync -apv --chmod=ugo+rwx $(OUT_DIR)/ /mnt/$(TARGET)/
	mkdir -p /mnt/$(TARGET)/dev
	mkdir -p /mnt/$(TARGET)/proc
	mkdir -p /mnt/$(TARGET)/root
	mkdir -p /mnt/$(TARGET)/run
	mkdir -p /mnt/$(TARGET)/sys
	mkdir -p /mnt/$(TARGET)/tmp
	mkdir -p /mnt/$(TARGET)/var
	ln -s /run /mnt/$(TARGET)/var/run
	touch /mnt/$(TARGET)/etc/fstab
	umount /mnt/$(TARGET)
	losetup -d $(LOOP_DEV)

.PHONY: rootfs
