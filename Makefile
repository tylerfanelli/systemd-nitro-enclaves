prefix_usr ?= $(PREFIX)/usr

libexecdir ?= $(prefix_usr)/libexec
sysconfdir ?= $(PREFIX)/etc
libdir ?= $(prefix_usr)/lib
unitdir ?= $(libdir)/systemd/system

LIBEXEC_DIR := $(libexecdir)
SYS_CONF_DIR := $(sysconfdir)/nitro_enclaves
UNIT_DIR := $(unitdir)

.PHONY: files dirs sys_conf_install sys_conf_uninstall unitdir_install unitdir_uninstall libexecdir_install libexecdir_uninstall install uninstall clean

$(SYS_CONF_DIR):
	mkdir -p $@

sys_conf_install:
	mkdir -p $(SYS_CONF_DIR)
	cp allocator.yaml $(SYS_CONF_DIR)

sys_conf_uninstall:
	rm -rf $(SYS_CONF_DIR)

unitdir_install:
	mkdir -p $(UNIT_DIR)
	cp -a nitro-enclaves-allocator.service $(UNIT_DIR)

unitdir_uninstall:
	rm -f $(UNIT_DIR)/nitro-enclaves-allocator.service

libexecdir_install:
	mkdir -p $(LIBEXEC_DIR)
	cp nitro-enclaves-allocator $(LIBEXEC_DIR)

libexecdir_uninstall:
	rm -f $(LIBEXEC_DIR)/nitro-enclaves-allocator

install: sys_conf_install unitdir_install libexecdir_install

uninstall: sys_conf_uninstall unitdir_uninstall libexecdir_uninstall

clean: uninstall
