USER_LOGIN = $(shell whoami)
UID = $(shell id -u)
GID = $(shell id -g)

WORK_DIR = $(HOME)/Work
HOME_DIR = $(HOME)/.container_data
COMPOSE_FILE = ./files/docker-compose.yml
ENV_FILE = ./files/.env

all: setup build up

setup: env-file data-dirs

env-file:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "USER_LOGIN=$(USER_LOGIN)" > $(ENV_FILE); \
		echo "UID=$(UID)" >> $(ENV_FILE); \
		echo "GID=$(GID)" >> $(ENV_FILE); \
		echo "WORK_DIR=$(WORK_DIR)" >> $(ENV_FILE); \
		echo "HOME_DIR=$(HOME_DIR)" >> $(ENV_FILE); \
		echo "Generated .env file";\
	fi

data-dirs:
	@mkdir -p $(HOME_DIR) 

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

clean: down
	docker system prune -af
	docker volume prune -f

fclean: clean
	docker compose -f $(COMPOSE_FILE) down -v --rmi all
	@rm -rf $(ENV_FILE)
	@echo "Full clean complete"

re: fclean all

logs:
	docker compose logs -f

.PHONY: all setup env-file secrets data-dirs build up down clean fclean re logs
