.PHONY: clean deploy help shell 

default: help

help:
			@echo "make clean   - Clean the project working directory"
			@echo "make deploy  - Deploy the site to AWS"
			@echo "make help    - Display this message"
			@echo "make shell   - Run a shell in a toolbox container"

deploy:
			docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" hugo-toolbox /var/local/deploy.sh

clean:
			if [ -d public ]; then rm -r public; fi

shell:
			docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" hugo-toolbox /bin/sh
