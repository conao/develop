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

repos/%:; git clone git@github.com:conao3/$*.git repos/$*
forks/%:; git clone git@github.com:conao3/$*.git forks/$*

pull: repos forks
	$(MAKE) .make-pull TARGET="$(shell find repos forks -depth 1)"

.make-pull: $(TARGET:%=.make-pull-worker-%)
.make-pull-worker-repos/%:; cd repos/$* && git pull origin `git symbolic-ref --short HEAD`
.make-pull-worker-forks/%:; cd forks/$* && git pull origin `git symbolic-ref --short HEAD`

push: repos forks
	$(MAKE) .make-push TARGET="$(shell find repos forks -depth 1)"

.make-push: $(TARGET:%=.make-push-worker-%)
.make-push-worker-repos/%:; cd repos/$* && git push origin `git symbolic-ref --short HEAD`
.make-push-worker-forks/%:; cd forks/$* && git push origin `git symbolic-ref --short HEAD`

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
