
# helper variables
MYDIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.PHONY: help dist dist-zip dist-tar optimize optimize-png

help:
	@echo "This Makefile is intended to be used by developers only."
	@echo "Therefore it does nothing by default. Available targets:"
	@echo "    optimize"
	@echo "            -png : Recompresses png files with zopfli for smaller file size"
	@echo "    dist"
	@echo "        -zip     : Creates a distribution zip archive (for use under Windows)"
	@echo "        -tar     : Creates a distribution tarball (for other platforms)"
	@echo "The meta targets will execute all their subtargets."

dist: dist-tar dist-zip

dist-zip:
	@rm -f easyrpg-rtp.zip
	@rm -rf dist-zip
	@mkdir dist-zip
	@git archive --prefix=EasyRPG-RTP/ --worktree-attributes master | tar xf - -C dist-zip
	@cd dist-zip/EasyRPG-RTP; mv README.md README.txt; mv AUTHORS.md AUTHORS.txt; mv COPYING COPYING.txt; \
		unix2dos -q COPYING.txt README.txt AUTHORS.txt
	@cd dist-zip; zip -9 -q -r $(MYDIR)/easyrpg-rtp.zip EasyRPG-RTP
	@rm -rf dist-zip

dist-tar:
	@rm -f easyrpg-rtp.tar.gz
	@rm -rf dist-tar
	@mkdir dist-tar
	@git archive --prefix=EasyRPG-RTP/ --worktree-attributes master | tar xf - -C dist-tar
	@cd dist-tar/EasyRPG-RTP; mv README.md README; mv AUTHORS.md AUTHORS
	@tar czf easyrpg-rtp.tar.gz -C dist-tar EasyRPG-RTP
	@rm -rf dist-tar

optimize: optimize-png

optimize-png:
	find $(MYDIR) -iname "*.png" -execdir advpng -z4 {} \+
