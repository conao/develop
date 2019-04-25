all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

GITHUB_URL := https://api.github.com/users/conao3/repos\?per_page=1000
ALLREPO    := $(shell curl $(GITHUB_URL) | jq -r '.[] | .name')
SOURCEREPO := $(shell curl $(GITHUB_URL) | jq -r '.[] | select(.fork==false) | .name')

DIRS := conao3 conao3-all git

.PHONY: all clean
all: $(DIRS) clone

##############################

$(DIRS):
	mkdir -p $@

##############################

clone: $(SOURCEREPO:%=conao3/%) $(ALLREPO:%=conao3-all/%)
conao3/%: conao3-all/%
	ln -sf ../$< $@

conao3-all/%:
	git clone --depth 1 git@github.com:conao3/$*.git $@

##############################

clean:
	rm -rf $(DIRS)
