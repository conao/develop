all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# GITHUB_URL := https://api.github.com/users/conao3/repos\?per_page=1000
# REPOS       := $(shell curl $(GITHUB_URL) | jq -r '.[] | .name')
# SOURCEREPOS := $(shell curl $(GITHUB_URL) | jq -r '.[] | select(.fork==false) | .name')

# xargs option
XARGS := xargs -t $(shell if xargs -r > /dev/null 2>&1; then echo "-r"; else echo ""; fi)
P ?= 12

DIRS := .make repos git conao3

##################################################

.PHONY: all unshallow pull push clean 
all: $(DIRS) clone link

##############################

$(DIRS):
	mkdir -p $@

##############################

clone:
	curl https://api.github.com/users/conao3/repos\?per_page=1000 | \
	  jq -r '.[] | .name' | \
	  $(XARGS) -n1 -P$(P) -t -I %% bash -c \
	    "cd repos && if [ ! -d %% ]; then git clone git@github.com:conao3/%%.git; fi"

shallow-clone:
	curl https://api.github.com/users/conao3/repos\?per_page=1000 | \
	  jq -r '.[] | .name' | \
	  $(XARGS) -n1 -P$(P) -t -I %% bash -c \
	    "cd repos && [ ! -d %% ] && git clone --max-depth 1 git@github.com:conao3/%%.git"

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
