#!/usr/bin/make -f
export GO111MODULE = on
CURRENT_UID:=$(id -u)
CURRENT_GID:=$(id -g)

start: build
	env UID=${CURRENT_UID} GID=${CURRENT_GID} docker-compose up -d

startv: build
	env UID=${CURRENT_UID} GID=${CURRENT_GID} docker-compose up
	
stop:
	docker-compose stop

build:
	docker-compose build

update: 
	docker-compose pull

reset:
	docker-compose rm -f
	rm -rf ./local/data/ || true 
	mkdir -p ./local/data/
	cp priv_validator_state.json ./local/data/

restart: reset start
