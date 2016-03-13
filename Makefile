default: build

build:
	docker build --rm=true -t bborbe/confluence .

run:
	docker run -h example.com -p 2222:22 -v /tmp:/confluence  bborbe/confluence:latest

bash:
	docker run -i -t bborbe/confluence:latest /bin/bash

upload:
	docker push bborbe/confluence
