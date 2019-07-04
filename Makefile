all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

TARGET =
DIRS := .make repos forks git conao3

##################################################

.PHONY: all unshallow pull push clean 
all: $(DIRS) clone link

##############################

$(DIRS):
	mkdir -p $@

##############################

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

##############################

clean-all: clean
	date +%Y-%m-%d:%H-%M-%S | \
	  $(XARGS) -I%% bash -c "mkdir trash-%% && mv -f $(DIRS) trash-%%"

clean:
	rm -rf .make

.make/github-cache: .make
	curl https://api.github.com/users/conao3/repos\?per_page=1000 > $@
