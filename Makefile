#!/usr/bin/make -f
export GO111MODULE = on
CURRENT_UID:=$(id -u)
CURRENT_GID:=$(id -g)

start: build
	env UID=${CURRENT_UID} GID=${CURRENT_GID} docker-compose up

startd: build
	env UID=${CURRENT_UID} GID=${CURRENT_GID} docker-compose up -d
	
stop:
	docker-compose stop

build:
	docker-compose build

update: 
	docker-compose pull

reset:
	docker-compose rm -f
	rm -rf ./data/ || true 
	mkdir -p ./data/
	cp priv_validator_state.json ./data/

restart: reset start
