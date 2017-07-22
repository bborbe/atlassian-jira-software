VERSION ?= latest
REGISTRY ?= docker.io

default: build

clean:
	docker rmi $(REGISTRY)/bborbe/jira-software:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t $(REGISTRY)/bborbe/jira-software:$(VERSION) .

run:
	docker run -h example.com -p 8780:8780 -p 8709:8709 $(REGISTRY)/bborbe/jira-software:$(VERSION)

shell:
	docker run -i -t $(REGISTRY)/bborbe/jira-software:$(VERSION) /bin/bash

upload:
	docker push $(REGISTRY)/bborbe/jira-software:$(VERSION)
