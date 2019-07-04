all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

TARGET =
DIRS := .make repos forks git conao3

##################################################

.PHONY: all unshallow pull push clean

all: clone

##############################

clone: .make/github-cache
	$(MAKE) .make-clone-repos TARGET="$(shell cat $< | jq -r '.[] | select(.fork==false).name')"
	$(MAKE) .make-clone-forks TARGET="$(shell cat $< | jq -r '.[] | select(.fork==true).name')"

.make-clone-repos: repos $(TARGET:%=repos/%)
.make-clone-forks: forks $(TARGET:%=forks/%)

repos/%:; git clone git@github.com:conao3/$*.git repos/$*
forks/%:; git clone git@github.com:conao3/$*.git forks/$*

##############################

pull:
	$(MAKE) .make-pull TARGET="$(shell find repos forks -depth 1)"

.make-pull: repos forks $(TARGET:%=.make-pull-worker-%)
.make-pull-worker-repos/%:; cd repos/$* && git pull origin `git symbolic-ref --short HEAD`
.make-pull-worker-forks/%:; cd forks/$* && git pull origin `git symbolic-ref --short HEAD`

##############################

push:
	$(MAKE) .make-push TARGET="$(shell find repos forks -depth 1)"

.make-push: repos forks $(TARGET:%=.make-push-worker-%)
.make-push-worker-repos/%:; cd repos/$* && git push origin `git symbolic-ref --short HEAD`
.make-push-worker-forks/%:; cd forks/$* && git push origin `git symbolic-ref --short HEAD`

##############################

status:
	$(MAKE) .make-status TARGET="$(shell find repos forks -depth 1)"

.make-status: repos forks $(TARGET:%=.make-status-worker-%)
.make-status-worker-repos/%:; cd repos/$* && git status
.make-status-worker-forks/%:; cd forks/$* && git status

##############################

$(DIRS):
	mkdir -p $@

.make/github-cache: .make
	curl https://api.github.com/users/conao3/repos\?per_page=1000 > $@

##############################

clean-all: clean
	date +%Y-%m-%d:%H-%M-%S | \
	  $(XARGS) -I%% bash -c "mkdir trash-%% && mv -f $(DIRS) trash-%%"

clean:
	rm -rf .make
