all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# GITHUB_URL := https://api.github.com/users/conao3/repos\?per_page=1000
# REPOS       := $(shell curl $(GITHUB_URL) | jq -r '.[] | .name')
# SOURCEREPOS := $(shell curl $(GITHUB_URL) | jq -r '.[] | select(.fork==false) | .name')

# xargs option
XARGS := xargs -t $(shell if xargs -r > /dev/null 2>&1; then echo "-r"; else echo ""; fi)
P ?= 12

TARGET =
DIRS := .make repos forks git conao3

##################################################

.PHONY: all unshallow pull push clean 
all: $(DIRS) clone link

##############################

$(DIRS):
	mkdir -p $@

##############################

debug:
	echo 'debug-done'

clone: .make/github-cache
	$(MAKE) .make-clone-repos TARGET="$(shell cat $< | jq -r '.[] | select(.fork==false).name')"
	$(MAKE) .make-clone-forks TARGET="$(shell cat $< | jq -r '.[] | select(.fork==true).name')"

.make-clone-repos: $(TARGET:%=repos/%)
.make-clone-forks: $(TARGET:%=forks/%)

repos/%: repos
	git clone git@github.com:conao3/$*.git repos/$*
forks/%: forks
	git clone git@github.com:conao3/$*.git forks/$*

shallow-clone:
	curl https://api.github.com/users/conao3/repos\?per_page=1000 | \
	  jq -r '.[] | .name' | \
	  $(XARGS) -n1 -P$(P) -t -I %% bash -c \
	    "cd repos && if [ ! -d %% ]; then git clone --max-depth 1 git@github.com:conao3/%%.git; fi"

unshallow:
	-find repos -maxdepth 1 -type d | \
	  $(XARGS) -n1 -P$(P) -t -I%% bash -c \
	    "cd %% && git fetch --unshallow"

pull:
	-find repos git -maxdepth 1 -type d | \
	  $(XARGS) -n1 -P$(P) -t -I%% bash -c \
	    "cd %% && git pull origin \$$(git symbolic-ref --short HEAD)"

push:
	-find repos -maxdepth 1 -type d | \
	  $(XARGS) -n1 -P$(P) -t -I%% bash -c \
	    "cd %% && git push origin \$$(git symbolic-ref --short HEAD)"

link: conao3 clone
	curl https://api.github.com/users/conao3/repos\?per_page=1000 | \
	  jq -r '.[] | select(.fork==false) | .name' | \
	  $(XARGS) -n1 -P$(P) -t -I %% bash -c \
	    "cd $< && ln -s ../repos/%%"

##############################

clean:
	date +%Y-%m-%d:%H-%M-%S | \
	  $(XARGS) -I%% bash -c "mkdir trash-%% && mv -f $(DIRS) trash-%%"

.make/github-cache: .make
	curl https://api.github.com/users/conao3/repos\?per_page=1000 > $@
