update-all:
	./pkg/maint/update-all.sh

update-config:
	curl -sSf https://git.savannah.gnu.org/cgit/automake.git/plain/lib/config.guess -o pkg/files/config.guess
	curl -sSf https://git.savannah.gnu.org/cgit/automake.git/plain/lib/config.sub   -o pkg/files/config.sub

update-cacert:
	curl -sSf https://curl.haxx.se/ca/cacert.pem -o pkg/etc/ssl/cert.pem

.PHONY: update-all update-config update-cacert
