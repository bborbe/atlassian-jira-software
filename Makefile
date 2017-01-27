VERSION ?= latest

default: build

clean:
	docker rmi bborbe/confluence:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t bborbe/confluence:$(VERSION) .

run:
	docker run -h example.com -p 8780:8780 -p 8709:8709 bborbe/confluence:$(VERSION)

shell:
	docker run -i -t bborbe/confluence:$(VERSION) /bin/bash

upload:
	docker push bborbe/confluence:$(VERSION)
