all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

GITHUB_URL := https://api.github.com/users/conao3/repos\?per_page=1000
ALLREPOS    := $(shell curl $(GITHUB_URL) | jq -r '.[] | .name')
SOURCEREPOS := $(shell curl $(GITHUB_URL) | jq -r '.[] | select(.fork==false) | .name')

DOTFILES   := jwiegley/dot-emacs

OTHERREPOS_DIRS := dotfiles
OTHERREPOS      := $(addprefix dotfiles/, $(DOTFILES))


DIRS := .make conao3 conao3-all git

.PHONY: all clean
all: $(DIRS) clone

##############################

$(DIRS):
	mkdir -p $@

##############################

clone: $(SOURCEREPOS:%=conao3/%) $(ALLREPOS:%=conao3-all/%) $(OTHERREPOS:%=git/%)
conao3/%: conao3-all/%
	ln -sf ../$< $@

conao3-all/%:
	git clone --depth 1 git@github.com:conao3/$*.git $@

####################

clone_dir  = $(shell echo $@ | cut -d/ -f1,2)
clone_repo = $(shell echo $@ | cut -d/ -f3-)
clone_name = $(shell echo $@ | rev | cut -d/ -f1 | rev)

git/%:
	mkdir -p $(clone_dir)
	git clone --depth 1 https://github.com/$(clone_repo).git $(clone_dir)/$(clone_name)

##############################

unshallow: $(ALLREPOS:%=.make/unshallow-%)
.make/unshallow-%:
	-cd conao3-all/$* && git fetch --unshallow
	touch $@

##############################

clean:
	rm -rf $(DIRS)
