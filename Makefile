.PHONY: clean deploy help serve shell 

default: help

help:
			@echo "make clean   - Clean the project working directory"
			@echo "make deploy  - Deploy the site to AWS"
			@echo "make help    - Display this message"
			@echo "make serve   - Run the Hugo server in a toolbox container"
			@echo "make shell   - Run a shell in a toolbox container"

deploy:
			docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" hugo-toolbox /var/local/deploy.sh

clean:
			if [ -d public ]; then rm -r public; fi

serve:
			docker run --rm -p 1313:1313 --mount "type=bind,source=${PWD},destination=/var/local" hugo-toolbox

shell:
			docker run --rm -it --mount "type=bind,source=${PWD},destination=/var/local" --mount "type=bind,source=${HOME}/.aws,destination=/root/.aws,readonly" hugo-toolbox /bin/sh
