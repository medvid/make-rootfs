# Set download command
DL_CMD := $(HOST_CURL) -s -S -L -f -o

# Delete all downloaded sources and tarballs
unfetch:
	find $(SRC_DIR) -mindepth 1 -maxdepth 1 -not -name "*.sha256sum" -print -exec rm -rf {} \;

# Download tarball to the source directory, verify checksum
# Each package sets either DL_URL or DL_SITE
$(SRC_DIR)/%: $(SRC_DIR)/%.sha256sum
	mkdir -p $@.tmp
	cd $@.tmp && $(DL_CMD) $* $(if $(DL_URL),$(DL_URL),$(DL_SITE)/$*)
	cd $@.tmp && touch $*
ifdef MAINT
	cd $@.tmp && sha256sum $(notdir $@) > $(ROOT_DIR)/$<
endif
	cd $@.tmp && sha256sum -c $(ROOT_DIR)/$<
	mv -v $@.tmp/$* $@
	rm -rf $@.tmp

$(SRC_DIR)/%: $(SRC_DIR)/%.orig
	rm -rf $@.tmp
	mv $< $@.tmp
	test ! -d $(PKG_DIR)/patches/$* || cat $(PKG_DIR)/patches/$*/* | ( cd $@.tmp && patch -p1 )
	rm -rf $@
	mv $@.tmp $@

# Extract downloaded tarball to the source directory, apply all patches
define add_extract_rule =
$(SRC_DIR)/%.orig: $(SRC_DIR)/%.$(1)
	rm -rf $$@.tmp
	mkdir $$@.tmp
	( cd $$@.tmp && bsdtar xf - ) < $$<
	rm -rf $$@
	touch $$@.tmp/$$*
	mv $$@.tmp/$$* $$@
	rm -rf $$@.tmp
endef

# Define extraction rules for known package types
$(eval $(call add_extract_rule,tgz))
$(eval $(call add_extract_rule,tar.bz2))
$(eval $(call add_extract_rule,tar.gz))
$(eval $(call add_extract_rule,tar.xz))
$(eval $(call add_extract_rule,tar.zst))
$(eval $(call add_extract_rule,zip))

.PHONY: fetch unfetch
