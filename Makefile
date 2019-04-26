all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# GITHUB_URL := https://api.github.com/users/conao3/repos\?per_page=1000
# REPOS       := $(shell curl $(GITHUB_URL) | jq -r '.[] | .name')
# SOURCEREPOS := $(shell curl $(GITHUB_URL) | jq -r '.[] | select(.fork==false) | .name')

# xargs parallel option
P ?= 12

DIRS := .make repos git

##################################################

.PHONY: all unshallow pull push clean 
all: $(DIRS) clone

##############################

$(DIRS):
	mkdir -p $@

##############################

clone:
	curl https://api.github.com/users/conao3/repos\?per_page=1000 | \
	  jq -r '.[] | .name' | \
	  xargs -n1 -P$(P) -t -I %% bash -c \
	    "cd repos && git clone --depth 1 git@github.com:conao3/%%.git"

unshallow:
	-find repos -depth 1 -type d | \
	  xargs -n1 -P$(P) -t -I%% bash -c \
	    "cd %% && git fetch --unshallow"

pull:
	-find repos git -depth 1 -type d | \
	  xargs -n1 -P$(P) -t -I%% bash -c \
	    "cd %% && git pull origin \$$(git symbolic-ref --short HEAD)"

push:
	-find repos -depth 1 -type d | \
	  xargs -n1 -P$(P) -t -I%% bash -c \
	    "cd %% && git push origin \$$(git symbolic-ref --short HEAD)"

##############################

clean:
	date +%Y-%m-%d:%H-%M-%S | \
	  xargs -I%% bash -c "mkdir trash-%% && mv -f $(DIRS) trash-%%"
