# https://repology.org/project/perl
# https://git.alpinelinux.org/aports/tree/main/perl/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/perl/perl.mk
# https://github.com/distr1/distri/blob/master/pkgs/perl/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/perl/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/perl/template

pkg_ver  := 5.32.0
pkg_repo := https://github.com/Perl/perl5
pkg_site := https://www.cpan.org/src/5.0
pkg_copy := true

pkg_configure := $(pkg_srcdir)/Configure \
	-des \
	-Dprefix=/usr \
	-Dprivlib=/usr/share/perl5/core_perl \
	-Darchlib=/usr/lib/perl5/core_perl \
	-Dvendorprefix=/usr \
	-Dvendorlib=/usr/share/perl5/vendor_perl \
	-Dvendorarch=/usr/lib/perl5/vendor_perl \
	-Dsiteprefix=/usr \
	-Dsitelib=/usr/share/perl5/site_perl \
	-Dsitearch=/usr/lib/perl5/site_perl \
	-Dlocincpth=' ' \
	-Dsysroot=$(OUT_DIR) \
	-Dcc=$(CC) \
	-Dld=$(LD) \
	-Dar=$(AR) \
	-Dnm=$(NM) \
	-Dranlib=$(RANLIB) \
	-Doptimize="$(CFLAGS)" \
	-Dldflags="$(LDFLAGS)" \
	-Dlibc=/usr/lib/libc.a \
	-Dlibs=none \
	-Duselargefiles \
	-Dusethreads \
	-Dd_semctl_semun \
	-Dman1dir=/usr/share/man/man1 \
	-Dman3dir=/usr/share/man/man3 \
	-Dinstallman1dir=/usr/share/man/man1 \
	-Dinstallman3dir=/usr/share/man/man3 \
	-Dman1ext='1' \
	-Dman3ext='3pm' \
	-Dusenm \
	-Dinstallusrbinperl \
	-Ud_csh \
	-Uuseshrplib \
	-Ui_ndbm \
	-Ui_gdbm \
	-Ui_db \
	-Uusedl

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
