VERSION ?= latest
REGISTRY ?= docker.io

default: build

clean:
	docker rmi $(REGISTRY)/bborbe/confluence:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t $(REGISTRY)/bborbe/confluence:$(VERSION) .

run:
	docker run -h example.com -p 8780:8780 -p 8709:8709 $(REGISTRY)/bborbe/confluence:$(VERSION)

shell:
	docker run -i -t $(REGISTRY)/bborbe/confluence:$(VERSION) /bin/bash

upload:
	docker push $(REGISTRY)/bborbe/confluence:$(VERSION)
