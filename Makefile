APP_VERSION = $(shell git describe --abbrev=0 --tags)
GIT_COMMIT = $(shell git rev-parse --short HEAD)
BUILD_DATE = $(shell date -u "+%Y%m%d-%H%M")
VERSION_PKG = github.com/InjectiveLabs/coremon/version
IMAGE_NAME := gallery.ecr.aws/l9h3g6c6/coremon
DOCKERHUB_IMAGE := injectivelabs/coremon
VERSION_FLAGS="-X $(VERSION_PKG).GitCommit=$(GIT_COMMIT) -X $(VERSION_PKG).BuildDate=$(BUILD_DATE)"

# Get the tag from environment variable or use GIT_COMMIT
TAG ?= $(GIT_COMMIT)

install:
	go install \
		-ldflags $(VERSION_FLAGS) \
		./cmd/coremon

image:
	docker build --build-arg VERSION_FLAGS=${VERSION_FLAGS} -t $(IMAGE_NAME):local -f Dockerfile .
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):$(GIT_COMMIT)
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):latest

push:
	docker push $(IMAGE_NAME):$(GIT_COMMIT)
	docker push $(IMAGE_NAME):latest

# Build image locally for current platform using Docker Buildx
buildx:
	@echo "Building image for $(DOCKERHUB_IMAGE):$(TAG)"
	docker buildx build \
		--platform linux/amd64 \
		--build-arg VERSION_FLAGS=$(VERSION_FLAGS) \
		-t $(DOCKERHUB_IMAGE):$(TAG) \
		-f Dockerfile \
		--load \
		.

# Build and push multi-arch image to DockerHub
buildx-push:
	@echo "Building and pushing multi-arch image for $(DOCKERHUB_IMAGE):$(TAG)"
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--build-arg VERSION_FLAGS=$(VERSION_FLAGS) \
		-t $(DOCKERHUB_IMAGE):$(TAG) \
		-f Dockerfile \
		--push \
		.

# Build and push multi-arch image with latest tag
buildx-push-latest:
	@echo "Building and pushing multi-arch image with latest tag"
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--build-arg VERSION_FLAGS=$(VERSION_FLAGS) \
		-t $(DOCKERHUB_IMAGE):$(TAG) \
		-t $(DOCKERHUB_IMAGE):latest \
		-f Dockerfile \
		--push \
		.

# Create buildx builder if it doesn't exist
buildx-setup:
	docker buildx create --name coremon-builder --use --bootstrap || docker buildx use coremon-builder

# Remove buildx builder
buildx-clean:
	docker buildx rm coremon-builder || true

cook:
	rsync -r ../coremon mb-external:~/go/src/

.PHONY: install image push buildx buildx-push buildx-push-latest buildx-setup buildx-clean cook
