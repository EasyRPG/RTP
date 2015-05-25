
# helper variable
MYDIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

help:
	@echo "This Makefile is intended to be used by developers only."
	@echo "Therefore it does nothing by default. Available targets:"
	@echo "    optimize     :"
	@echo "            -png : Recompresses png files with zopfli for smaller file size"
	@echo "    dist         : "
	@echo "        -zip     : Creates a distribution zip archive (for use under Windows)"
	@echo "        -tar     : Creates a distribution tarball (for other platforms)"
	@echo "The meta targets will execute all their subtargets."

dist: dist-tar dist-zip

dist-zip:
	@rm -f easyrpg-rtp.zip
	@git archive --prefix=EasyRPG-RTP/ -9 --output=$(MYDIR)/easyrpg-rtp.zip master

dist-tar:
	@rm -f easyrpg-rtp.tar.gz
	@git archive --prefix=EasyRPG-RTP/ --output=$(MYDIR)/easyrpg-rtp.tar.gz master

optimize: optimize-png

optimize-png:
	find $(MYDIR) -iname "*.png" -execdir advpng -z4 {} \+
