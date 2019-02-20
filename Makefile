UNITDIR		= $(DESTDIR)/lib/systemd/system
SERVICES	= docker-compose@

DESTDIR		=
INSTALL_OWNER	= root
INSTALL_GROUP	= root

all:; @echo "No target specified."

#//
install remove:
	@$(MAKE) --no-print-directory docker-compose@.service.$@

$(addsuffix .service.install,$(SERVICES)): %.install: $(UNITDIR)/% FORCE
	systemctl daemon-reload

$(addsuffix .service.remove,$(SERVICES)): %.remove: FORCE
	rm -f $(UNITDIR)/$*
	systemctl daemon-reload

$(UNITDIR)/%: % FORCE
	test -d $(@D) || mkdir -p $(@D)
	install -o $(INSTALL_OWNER) -g $(INSTALL_GROUP) -m 644 $< $@

FORCE:
