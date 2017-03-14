#
# Autoconfig makefile
# Copyright by Piotr Styczyński (2017)
# MIT License
#

ifeq (,$(filter clean distclean help build watch all,$(MAKECMDGOALS)))
ifneq (,$(MAKECMDGOALS))
$(info <error>Unknown build command was used.</error>)
$(error )
endif
endif

ECHO := @
CC_SEL:=

include ./bin/config.make

.PHONY: help watch clean cleandist

help:
	$(info )
	$(info )
	$(info  <b>$(PROJECT_DESCR)</b>)
	$(info )
	$(info  <b>Autoconf makefile by Piotr Styczynski <MIT></b>)
	$(info )
	$(info |  <warn>'make all'</warn> - Alias for 'make build')
	$(info |  <warn>'make build'</warn> - Builds application )
	$(info |  <warn>'make clean'</warn> - Cleans compilation cache )
	$(info |  <warn>'make distclean'</warn> - Cleans all directories - that is compilation cache and dist folder )
	$(info |  <warn>'make help'</warn> - Displays this help )
	$(info |  <warn>'make watch'</warn> - Starts smart autobuilds )
	$(info )
	$(info )

rebuild: clean-all

clean: clean-temp
	$(info <b>Project cleaned. Done</b>)

distclean: clean-all
	$(info <b>Project cleaned. Done</b>)

clean-temp: clean-obj

clean-all: clean-dist

build: sources

all: sources

rebuildauto: sources_noecho
	@true

sources_base: $(TEMP_DIR) $(DIST_DIR) $(SOURCES_OBJ_FILES) $(SOURCES_EXE_FILES)
	@true

sources: $(TEMP_DIR) $(DIST_DIR) $(SOURCES_OBJ_FILES) $(SOURCES_EXE_FILES)
	$(info <b>Sources build. Done</b>)

sources_noecho: sources_base
	@true

clean-obj:
	$(info <debug>Cleaning build</debug>)
	$(ECHO)rm -f $(SOURCES_BUILT_FILES)

clean-dist:
	$(info <debug>Cleaning dist</debug>)
	$(ECHO)rm -f -d -r $(TEMP_DIR)
	$(ECHO)rm -f -d -r $(DIST_DIR)

$(TEMP_DIR):
	@mkdir $(TEMP_DIR)

$(DIST_DIR):
	@mkdir $(DIST_DIR)

$(TEMP_DIR)/%$(OBJ): $(SRC_DIR)/%.c
	$(info <debug>Compiling file $< </debug>)
	$(CC) $@ $<

$(DIST_DIR)/target$(EXE): $(SOURCES_OBJ_FILES)
	$(CC_LINK) $@ $^

watch:
	$(info <b>Starting autobuilds... watching files</b>)
	$(info )
	@ while true; do make rebuildauto; sleep 1; done