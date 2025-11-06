CONTAINER_NAME=claude

#Local username, uid and gid (container will create matching user)
USER_LOGIN = $(shell whoami)
UID = $(shell id -u)
GID = $(shell id -g)

#Host directories to be shared
HOST_WORK_DIR=$(HOME)/Work

#Persistent host storage for container homes
HOST_CONTAINER_DATA_DIR=$(HOME)/.container_data

#Host mount points (need to be created so docker doesn't create as root)
HOST_CONTAINER_HOME_DIR=$(HOST_CONTAINER_DATA_DIR)/$(CONTAINER_NAME)
HOST_CONTAINER_WORK_DIR=$(HOST_CONTAINER_HOME_DIR)/Work

#Container mount points (where hosts mounts will be located inside container)
CONTAINER_HOME_DIR=$(HOME)
CONTAINER_WORK_DIR=$(CONTAINER_HOME_DIR)/Work

COMPOSE_FILE = ./files/docker-compose.yml
ENV_FILE = ./files/.env

all: setup build up

setup: env-file data-dirs

env-file:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "USER_LOGIN=$(USER_LOGIN)" > $(ENV_FILE); \
		echo "UID=$(UID)" >> $(ENV_FILE); \
		echo "GID=$(GID)" >> $(ENV_FILE); \
		echo "HOST_CONTAINER_HOME_DIR=$(HOST_CONTAINER_HOME_DIR)" >> $(ENV_FILE); \
		echo "HOST_WORK_DIR=$(HOST_WORK_DIR)" >> $(ENV_FILE); \
		echo "CONTAINER_HOME_DIR=$(CONTAINER_HOME_DIR)" >> $(ENV_FILE); \
		echo "CONTAINER_WORK_DIR=$(CONTAINER_WORK_DIR)" >> $(ENV_FILE); \
		echo "Generated .env file";\
	fi

#Ensure all required host directories exist so docker doesn't create as root
data-dirs:
	@mkdir -p $(HOST_WORK_DIR)
	@mkdir -p $(HOST_CONTAINER_DATA_DIR)
	@mkdir -p $(HOST_CONTAINER_HOME_DIR)
	@mkdir -p $(HOST_CONTAINER_WORK_DIR)

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
