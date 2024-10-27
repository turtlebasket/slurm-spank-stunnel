PLUGIN_NAME = stunnel

CC = gcc
CFLAGS = -fPIC -shared

PREFIX = /usr
LIBDIR = $(PREFIX)/lib64/slurm
SYSCONFDIR = $(PREFIX)/etc/slurm
PLUGCONF_DIR = $(SYSCONFDIR)/plugstack.conf.d

.PHONY: all clean install

all: $(PLUGIN_NAME).so

$(PLUGIN_NAME).so: slurm-spank-$(PLUGIN_NAME).c
	$(CC) $(CFLAGS) -o $(PLUGIN_NAME).so slurm-spank-$(PLUGIN_NAME).c -lslurm

install: $(PLUGIN_NAME).so
	mkdir -p $(DESTDIR)$(LIBDIR) $(DESTDIR)$(PLUGCONF_DIR)
	install -m 755 $(PLUGIN_NAME).so $(DESTDIR)$(LIBDIR)
	install -m 644 plugstack.conf $(DESTDIR)$(PLUGCONF_DIR)/$(PLUGIN_NAME).conf.example
	install -m 644 plugstack.conf /etc/slurm/plugstack.conf.d/$(PLUGIN_NAME).conf

clean:
	rm -f $(PLUGIN_NAME).so

