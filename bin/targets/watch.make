
ifneq (,$(SUPPORT_WATCH))
watch:
	$(info <b>Starting autobuilds... watching files</b>)
	$(info )
	@ while true; do make rebuildauto; sleep 1; done
else
watch:
	$(info <error>Dynamic rebuilding is not supported by this project.</error>)
	$(error Dynamic rebuilding is not supported by this project.)
endif
