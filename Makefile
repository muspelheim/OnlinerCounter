SHELL := /bin/bash

args = `arg="$(filter-out $(firstword $(MAKECMDGOALS)),$(MAKECMDGOALS))" && echo $${arg:-${1}}`

#COLOURED ECHO
green  = $(shell echo -e '\x1b[32;01m$1\x1b[0m')
yellow = $(shell echo -e '\x1b[33;01m$1\x1b[0m')
red    = $(shell echo -e '\x1b[33;31m$1\x1b[0m')

format = $(shell printf "%s %-40s %s" "$(call yellow,$1)" "$(call green,$2)" $3)

#HELP COLORS
GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
RED    := $(shell tput -Txterm setaf 1)
RESET  := $(shell tput -Txterm sgr0)

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_FUN = \
    %help; \
    while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-\.]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
    print "usage: make [target]\n\n"; \
    for (sort keys %help) { \
    print "${RED}$$_:${RESET}\n"; \
    for (@{$$help{$$_}}) { \
    $$sep = " " x (32 - length $$_->[0]); ($$command = $$_->[0]) =~ s/\\//g; $$description = $$_->[1]; \
    print "  ${YELLOW}make${RESET} ${GREEN}$$command${RESET}$$sep${WHITE}$$description${RESET}\n"; \
    }; \
    print "\n"; }
#HELP COLORS END

all: $(MAKEFILE_LIST)
.PHONY: all
.DEFAULT_GOAL:=help
.SILENT:

%:
	@:

#To create new command you should use pattern as described below:
# COMMAND_NAME: ##@CATEGORY_NAME DESCRIPTION_TEXT
#Applied DOT (.) for logical separation. Example COMMAND_NAME is: setup.env
help: ##@-Other Show this help
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

start: ##@Base Start Environment
	echo "$(call yellow,'Start Environment')"; \
	docker-compose up -d

stop: ##@Base Stop Environment
	echo "$(call yellow,'Stop Environment')"; \
	docker-compose down

setup: ##@Base Build all and cp .env.dist to .env
	echo "$(call yellow,'Setup Environment')"; \
	cp ./.env.dist .env;
	docker-compose build;
	docker-compose up -d;
	docker-compose exec php composer install;
	docker-compose exec web /entry.sh;

html: ##@Base Generate HTML pages
	echo "$(call yellow,'Generate HTML pages')"; \
	docker-compose exec web /entry.sh;

watch: ##@Service Watch load on system
	@top
