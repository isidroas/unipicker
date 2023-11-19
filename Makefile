DESTDIR = 
PREFIX = $(DESTDIR)/usr/local
UNICODE_VERSION = 15.1.0


Blocks.txt:
	wget -O$@ "http://ftp.unicode.org/Public/$(UNICODE_VERSION)/ucd/Blocks.txt"

BlocksReduced.txt: Blocks.txt Blocks.patch
	cp Blocks.txt $@
	patch $@ -p1 < Blocks.patch

symbols: BlocksReduced.txt
	./generate-symbols.py > "$@"

install: symbols
	install -d -m755 $(PREFIX)/bin
	install -m755 unipicker $(PREFIX)/bin/unipicker
	install -d -m755 $(PREFIX)/share/unipicker
	install -m644 symbols $(PREFIX)/share/unipicker/symbols
	install -d -m755 $(DESTDIR)/etc
	install -b -m644 unipickerrc $(DESTDIR)/etc/unipickerrc
