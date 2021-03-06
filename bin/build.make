#
# Autoconfig makefile
# Copyright by Piotr Styczyński (2017)
# MIT License
#

ECHO := @

include ./bin/default.config
include ./build.config
include ./bin/paths.make

REBUILD_AUTO_MODE=false
ifneq (,$(filter rebuildauto,$(MAKECMDGOALS)))
REBUILD_AUTO_MODE=true
endif

ifeq (true,$(DEBUG))
ECHO=(echo __DEBUG_NOTIFICATOR__ > /dev/null) &
endif

PRM_FLAG_INPUT_SYM=%
PRM_FLAG_OUTPUT_SYM=-

CC_ := $(CC)
CC := $(ECHO)$(CC_) $(CC_FLAGS)
CC_DBG := $(ECHO)$(CC_) $(CC_DBG_FLAGS)
CC_DBG_LINK := $(ECHO)$(CC_) $(CC_DBG_LINKER_FLAGS) $(LIBS)
CC_LINK := $(ECHO)$(CC_) $(CC_LINKER_FLAGS) $(LIBS)
CC_SEL:=

#ifeq (,$(filter clean distclean help build watch all test rebuildauto run rebuild $(CUSTOM_COMMANDS),$(MAKECMDGOALS)))
#ifneq (,$(MAKECMDGOALS))
#$(info <error>Unknown build command was used: $(MAKECMDGOALS)</error>)
#$(error )
#endif
#endif

include ./bin/targets/*
