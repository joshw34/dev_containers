# Makefile for C++ Dev Container

# Variables
IMAGE_NAME = cpp-dev
IMAGE_TAG = latest
CONTAINER_NAME = cpp
CONTAINERFILE = Containerfile
ASSEMBLE_FILE = distrobox-assemble.ini

# Colors for output
GREEN = \033[0;32m
YELLOW = \033[0;33m
NC = \033[0m # No Color


all: build create


build:
	@echo "$(GREEN)Building container image: $(IMAGE_NAME):$(IMAGE_TAG)$(NC)"
	podman build -t $(IMAGE_NAME):$(IMAGE_TAG) -f $(CONTAINERFILE) .


create: build
	@echo "$(GREEN)Creating distrobox from assemble file$(NC)"
	distrobox assemble create --file $(ASSEMBLE_FILE)


enter:
	@echo "$(GREEN)Entering distrobox: $(CONTAINER_NAME)$(NC)"
	distrobox enter $(CONTAINER_NAME)


stop:
	@echo "$(YELLOW)Stopping distrobox: $(CONTAINER_NAME)$(NC)"
	distrobox stop $(CONTAINER_NAME)


remove:
	@echo "$(YELLOW)Removing distrobox: $(CONTAINER_NAME)$(NC)"
	distrobox rm $(CONTAINER_NAME) --force


fclean: remove
	@echo "$(YELLOW)Removing container image: $(IMAGE_NAME):$(IMAGE_TAG)$(NC)"
	podman rmi localhost/$(IMAGE_NAME):$(IMAGE_TAG)


re: clean build create
	@echo "$(GREEN)Rebuild complete!$(NC)"


help:
	@echo "C++ Dev Container Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make build          - Build the container image"
	@echo "  make create         - Create distrobox using assemble file"
	@echo "  make enter          - Enter the distrobox"
	@echo "  make stop           - Stop the distrobox"
	@echo "  make remove         - Remove the distrobox (keeps image)"
	@echo "  make fclean         - Remove distrobox and image"
	@echo "  make re             - Clean and rebuild everything"
	@echo "  make all            - Build and create (default)"
	@echo "  make help           - Show this help message"

.PHONY: all build create enter stop remove clean re help