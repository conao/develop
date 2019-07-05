## Makefile

# This program is free software: you can redistribute it and/or modify
# it under the terms of the Affero GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
# GNU General Public License for more details.

# You should have received a copy of the Affero GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

DIRS := .make repos forks git conao3

TARGET =

##################################################

.PHONY: all clone pull push status clean-all clean

all: clone

##############################

clone: .make/github-cache
	$(MAKE) .make-clone-repos TARGET="$(shell cat $< | jq -r '.[] | select(.fork==false).name')"
	$(MAKE) .make-clone-forks TARGET="$(shell cat $< | jq -r '.[] | select(.fork==true).name')"

.make-clone-repos: repos $(TARGET:%=repos/%)
.make-clone-forks: forks $(TARGET:%=forks/%)

repos/%:; git clone git@github.com:conao3/$*.git $@
forks/%:
	git clone https://github.com/`curl https://api.github.com/repos/conao3/$* | jq -r '.parent.full_name'`.git $@
	cd $@; git remote add conao3 git@github.com:conao3/$*.git
	cd $@; git fetch --all

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
.make-push-worker-forks/%:; cd forks/$* && git push conao3 `git symbolic-ref --short HEAD`

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

clean:
	rm -rf .make

clean-all: clean $(shell date +"trash/%Y-%m-%d_%H-%M-%S")

trash/%: trash
	mkdir $@
	mv repos $@/
	mv forks $@/
	mv git $@/
