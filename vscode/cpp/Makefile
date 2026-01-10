# Makefile for C++ Dev Container

# Variables
IMAGE_NAME = cpp-vscode
IMAGE_TAG = latest
CONTAINER_NAME = cpp
CONTAINERFILE = Containerfile

# Colors for output
GREEN = \033[0;32m
YELLOW = \033[0;33m
NC = \033[0m # No Color


all: build


build:
	@echo "$(GREEN)Building container image: $(IMAGE_NAME):$(IMAGE_TAG)$(NC)"
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f $(CONTAINERFILE) .

fclean:
	@echo "$(YELLOW)Removing container image: $(IMAGE_NAME):$(IMAGE_TAG)$(NC)"
	docker rmi localhost/$(IMAGE_NAME):$(IMAGE_TAG)


re: clean build create
	@echo "$(GREEN)Rebuild complete!$(NC)"


help:
	@echo "C++ Dev Container Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make build          - Build the container image"
	@echo "  make fclean         - Remove image"
	@echo "  make re             - Clean and rebuild everything"
	@echo "  make all            - Build (default)"
	@echo "  make help           - Show this help message"

.PHONY: all build fclean re help
