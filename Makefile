VERSION := $(shell jq -r '.version' deploy.json)
REPO := $(shell jq -r '.repo' deploy.json)

.PHONY: all
all: | build push

.PHONY: build
build:
	docker build . \
		--force-rm \
		-t $(REPO):latest \
		-t $(REPO):$(VERSION)

.PHONY: push
push:
	docker push $(REPO):$(VERSION)
	docker push $(REPO):latest
