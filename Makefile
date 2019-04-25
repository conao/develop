all:

include Makefunc.mk

TOPDIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: all install clean
all:

##############################

install:
$(DIRS):
	mkdir -p $@

##############################

clean:
