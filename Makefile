CONTAINER_REPO := quay.io/croberts
CONTAINER_IMAGE := odh-operator-test-harness-cleanup

VERSION := 1.0

.PHONY: all
all: build

.PHONY: build
build:
	podman build \
	  -t $(CONTAINER_REPO)/$(CONTAINER_IMAGE):$(VERSION) \
	  -f Dockerfile .

push:
	podman push $(CONTAINER_REPO)/$(CONTAINER_IMAGE):$(VERSION)
