prefix ?= $(PREFIX)/usr

bindir ?= $(prefix)/bin
sysconfdir ?= $(prefix)/etc
libdir ?= $(prefix)/lib
unitdir ?= $(libdir)/systemd/system

BIN_DIR := $(DESTDIR)$(bindir)
SYS_CONF_DIR := $(DESTDIR)$(sysconfdir)/nitro_enclaves
UNIT_DIR := $(DESTDIR)$(unitdir)

.PHONY: files dirs sys_conf_install sys_conf_uninstall unitdir_install unitdir_uninstall bindir_install bindir_uninstall install uninstall clean

$(SYS_CONF_DIR):
	mkdir -p $@

sys_conf_install:
	mkdir -p $(SYS_CONF_DIR)
	cp allocator.yaml $(SYS_CONF_DIR)

sys_conf_uninstall:
	rm -rf $(SYS_CONF_DIR)

unitdir_install:
	cp -a nitro-enclaves-allocator.service $(UNIT_DIR)

unitdir_uninstall:
	rm -f $(UNIT_DIR)/nitro-enclaves-allocator.service

bindir_install:
	cp nitro-cli-config $(BIN_DIR)
	cp nitro-enclaves-allocator $(BIN_DIR)

bindir_uninstall:
	rm -f $(BIN_DIR)/nitro-cli-config
	rm -f $(BIN_DIR)/nitro-enclaves-allocator

install: sys_conf_install unitdir_install bindir_install

uninstall: sys_conf_uninstall unitdir_uninstall bindir_uninstall

clean: uninstall
