VERSION ?= latest
REGISTRY ?= docker.io

default: build

clean:
	docker rmi $(REGISTRY)/bborbe/atlassian-jira-software:$(VERSION)

build:
	docker build --build-arg ATLASSIAN_VERSION=$(ATLASSIAN_VERSION) --no-cache --rm=true -t $(REGISTRY)/bborbe/atlassian-jira-software:$(VERSION) .

run:
	docker run -h example.com -p 8780:8780 -p 8709:8709 $(REGISTRY)/bborbe/atlassian-jira-software:$(VERSION)

shell:
	docker run -i -t $(REGISTRY)/bborbe/atlassian-jira-software:$(VERSION) /bin/bash

upload:
	docker push $(REGISTRY)/bborbe/atlassian-jira-software:$(VERSION)
