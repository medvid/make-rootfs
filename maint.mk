update-all:
	./pkg/maint/update-all.sh

update-config:
	curl -sSf https://git.savannah.gnu.org/cgit/automake.git/plain/lib/config.guess -o pkg/config.guess
	curl -sSf https://git.savannah.gnu.org/cgit/automake.git/plain/lib/config.sub   -o pkg/config.sub

.PHONY: update-all update-config
