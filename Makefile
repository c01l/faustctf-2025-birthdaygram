SERVICE := birthdaygram
DESTDIR ?= dist_root
SERVICEDIR ?= /srv/$(SERVICE)

.PHONY: build install

build:
	echo nothing to build

install: build
	mkdir -p $(DESTDIR)$(SERVICEDIR)
	cp -r docker-compose.yml $(DESTDIR)$(SERVICEDIR)
	yq -y 'del(.services."birthdaygram-deps")' docker-compose.yml > $(DESTDIR)$(SERVICEDIR)/docker-compose.yml	
	mkdir -p dist_root/srv/birthdaygram/deps
	cp deps/* $(DESTDIR)$(SERVICEDIR)/deps -r
	cp -r webserver/ $(DESTDIR)$(SERVICEDIR)/webserver
	mkdir -p $(DESTDIR)/etc/systemd/system/faustctf.target.wants/
	ln -s /etc/systemd/system/docker-compose@.service $(DESTDIR)/etc/systemd/system/faustctf.target.wants/docker-compose@$(SERVICE).service
