SERVICE := birthdaygram
DESTDIR ?= dist_root
SERVICEDIR ?= /srv/$(SERVICE)

.PHONY: build install

build:
	echo nothing to build

install: build
	mkdir -p $(DESTDIR)$(SERVICEDIR)
	cp -r docker-compose.yml $(DESTDIR)$(SERVICEDIR)
	mkdir -p $(DESTDIR)/srv/birthdaygram/deps
	cp deps/* $(DESTDIR)$(SERVICEDIR)/deps -r
	cp -r webserver/ $(DESTDIR)$(SERVICEDIR)/webserver
	mkdir -p $(DESTDIR)/etc/systemd/system/faustctf.target.wants/
	[ -L $(DESTDIR)/etc/systemd/system/faustctf.target.wants/docker-compose@$(SERVICE).service ] || ln -s /etc/systemd/system/docker-compose@.service $(DESTDIR)/etc/systemd/system/faustctf.target.wants/docker-compose@$(SERVICE).service
