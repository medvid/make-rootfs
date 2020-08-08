# Set path to curl binary
# Need to evaluate absolute path before PATH is modified by bootstrap.mk
CURL := $(shell which curl)

# Set download command
DL_CMD := $(CURL) -s -S -L -f -o

# Delete all downloaded sources and tarballs
unfetch:
	find $(SRC_DIR) -mindepth 1 -maxdepth 1 -not -name "*.sha256sum" -print -exec rm -rf {} \;

# Create top-level source directory
$(SRC_DIR):
	mkdir -p $@

# Download tarball to the source directory, verify checksum
# Each package sets either DL_URL or DL_SITE
$(SRC_DIR)/%: $(SRC_DIR)/%.sha256sum | $(SRC_DIR)
	mkdir -p $@.tmp
	cd $@.tmp && $(DL_CMD) $* $(if $(DL_URL),$(DL_URL),$(DL_SITE)/$*)
	cd $@.tmp && touch $*
ifdef MAINT
	cd $@.tmp && sha256sum $(notdir $@) > $(ROOT_DIR)/$<
endif
	cd $@.tmp && sha256sum -c $(ROOT_DIR)/$<
	mv -v $@.tmp/$* $@
	rm -rf $@.tmp

# Extract downloaded tarball to the source directory, apply all patches
define add_extract_rule =
$(SRC_DIR)/%: $(SRC_DIR)/%.$(1)
	rm -rf $$@.orig
	mkdir $$@.orig
	( cd $$@.orig && bsdtar xf - ) < $$<
	rm -rf $$@
	touch $$@.orig/$$*
	mv -v $$@.orig/$$* $$@
	test ! -d pkg/patches/$$* || cat pkg/patches/$$*/* | ( cd $$@ && patch -p1 )
	rm -rf $$@.orig
endef

# Define extraction rules for known package types
$(eval $(call add_extract_rule,tgz))
$(eval $(call add_extract_rule,tar.bz2))
$(eval $(call add_extract_rule,tar.gz))
$(eval $(call add_extract_rule,tar.xz))
$(eval $(call add_extract_rule,zip))

.PHONY: fetch unfetch
