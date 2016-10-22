default: build

# Build Docker image
build: docker_build output

# Image can be overidden with an env var.
DOCKER_IMAGE ?= rossf7/badgerbadgerbadger
BINARY ?= badger3

# Get the latest commit.
GIT_COMMIT = $(strip $(shell git rev-parse --short HEAD))

# Set the version.
VERSION = $(shell cat VERSION)

# Use the version number as the tag.
DOCKER_TAG = $(strip $(VERSION))

SOURCES := $(shell find . -name '*.go')

clean: 
	rm $(BINARY)

test:
	go test -v ./...

get-deps:
	go get -t -v ./...

$(BINARY): $(SOURCES)
	# Compile for Linux
	GOOS=linux go build -o $(BINARY)	

docker_build: $(BINARY)
	# Build Docker image
	docker build \
  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
  --build-arg VCS_URL=`git config --get remote.origin.url` \
  --build-arg VCS_REF=$(GIT_COMMIT) \
  --build-arg VERSION=$(VERSION) \
	-t $(DOCKER_IMAGE):$(DOCKER_TAG) .

output:
	@echo Docker Image: $(DOCKER_IMAGE):$(DOCKER_TAG)
