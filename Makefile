.PHONY: all
all: clean build

.PHONY: build
build:
	@cd kong && make build
	@cd konga && make build

.PHONY: clean
clean:
	@git clean -fXd

.PHONY: pull
pull:
	@docker-compose pull
	@cd kong && make pull
	@cd konga && make pull

.PHONY: push
push:
	@cd kong && make push
	@cd konga && make push

.PHONY: up
up: build
	@docker-compose up
