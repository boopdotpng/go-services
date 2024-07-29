# Makefile
BINARY_NAME=telegramsync
BUILD_DIR=$(CURDIR)/build

.PHONY: all build clean run test lint

all: clean build

build:
	@echo "building..."
	@go build -o $(BUILD_DIR)/$(BINARY_NAME) ./cmd/server
	@echo "built."

clean:
	@echo "cleaning..."
	@rm -rf $(BUILD_DIR)

run: build
	@echo "running..."
	@$(BUILD_DIR)/$(BINARY_NAME)

test:
	@echo "testing..."
	@go test ./...

lint:
	@echo "linting..."
	@golangci-lint run