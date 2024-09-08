APP_VERSION = $(shell git describe --abbrev=0 --tags)
GIT_COMMIT = $(shell git rev-parse --short HEAD)
BUILD_DATE = $(shell date -u "+%Y%m%d-%H%M")
VERSION_PKG = github.com/InjectiveLabs/coremon/version
IMAGE_NAME := gallery.ecr.aws/l9h3g6c6/coremon
VERSION_FLAGS="-X $(VERSION_PKG).GitCommit=$(GIT_COMMIT) -X $(VERSION_PKG).BuildDate=$(BUILD_DATE)"

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

cook:
	rsync -r ../coremon cooking:~/go/src/

.PHONY: install image push cook
