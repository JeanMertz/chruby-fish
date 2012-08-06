NAME=chruby
VERSION=0.0.2

FILES=$(shell git ls-files)
PKG=$(NAME)-$(VERSION).tar.bz2
SIG=$(PKG).asc

PREFIX=/usr/local
DOC_DIR=$(PREFIX)/share/doc/$(NAME)-$(VERSION)/
INSTALL_DIRS={etc,lib,bin,sbin,share}
DOC_FILES=doc/*
EXTRA_DOC_FILES=*.{md,tt,txt}

$(PKG): $(FILES)
	tar -cjvf $(PKG) $(FILES)

pkg: $(PKG)

$(SIG): $(PKG)
	gpg --sign --detach-sign --armor $(PKG)

sign: $(SIG)

all: $(PKG) $(SIG)

clean:
	rm -f $(PKG) $(SIG)

install:
	for file in `find $(INSTALL_DIRS) -type f 2>/dev/null`; do install -D $$file $(PREFIX)/$$file; done
	install -d $(PREFIX)/share/doc/$(NAME)-$(VERSION)/
	cp -r $(DOC_FILES) $(DOC_DIR) 2>/dev/null || true
	cp -r $(EXTRA_DOC_FILES) $(DOC_DIR) 2>/dev/null || true

uninstall:
	for file in `find $(INSTALL_DIRS) -type f 2>/dev/null`; do rm -f $(PREFIX)/$$file; done
	rm -rf $(PREFIX)/share/doc/$(NAME)-$(VERSION)/
