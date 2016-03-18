default: build

clean:
	docker rmi bborbe/confluence

build:
	docker build --rm=true -t bborbe/confluence .

run:
	docker run -h example.com -p 8780:8780 -p 8709:8709 bborbe/confluence:latest

bash:
	docker run -i -t bborbe/confluence:latest /bin/bash

upload:
	docker push bborbe/confluence
