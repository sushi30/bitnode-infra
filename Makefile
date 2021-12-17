MAKEFLAGS += --warn-undefined-variables
ifndef MAKECMDGOALS
MAKECMDGOALS = all
endif

no-make-warnings:
	! make -n $(MAKECMDGOALS) 2>&1 >/dev/null | grep warning

deploy: no-make-warnings
	helm upgrade -i --create-namespace -f custom_values.yaml -nbtcd btcd .