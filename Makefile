all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

GITHUB_URL := https://api.github.com/users/conao3/repos\?per_page=1000
CONAO3_ALLREPO := $(shell curl $(GITHUB_URL) | jq -r '.[] | .name')
CONAO3_SOURCEREPO := $(shell curl $(GITHUB_URL) | jq -r '.[] | select(.fork==false) | .name')

DIRS := conao3 git

.PHONY: all install clean
all:

##############################

install: $(DIRS)
$(DIRS):
	mkdir -p $@

##############################

clean:
	rm -rf $(DIRS)
