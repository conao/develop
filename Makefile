all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

GITHUB_URL := https://api.github.com/users/conao3/repos\?per_page=1000
ALLREPOS    := $(shell curl $(GITHUB_URL) | jq -r '.[] | .name')
SOURCEREPOS := $(shell curl $(GITHUB_URL) | jq -r '.[] | select(.fork==false) | .name')


DIRS := .make conao3 conao3-all git

.PHONY: all clean
all: $(DIRS) clone

##############################

$(DIRS):
	mkdir -p $@

##############################

clone: $(SOURCEREPOS:%=conao3/%) $(ALLREPOS:%=conao3-all/%)
conao3/%: conao3-all/%
	ln -sf ../$< $@

conao3-all/%:
	git clone --depth 1 git@github.com:conao3/$*.git $@

##############################

unshallow: $(ALLREPOS:%=.make/unshallow-%)
.make/unshallow-%:
	-cd conao3-all/$* && git fetch --unshallow
	touch $@

##############################

clean:
	rm -rf $(DIRS)
