.PHONY: clean deploy help setup 

default: help

help:
			@echo "make clean   - Clean the project working directory"
			@echo "make deploy  - Deploy the site to AWS"
			@echo "make help    - Display this message"
			@echo "make setup   - Install the development dependencies"

deploy:
			hugo build -v
			s3deploy -source=public/ -region=eu-west-2 -bucket=www.stuartellis.org

clean:
			if [ -d public ]; then rm -r public; fi

setup:
			go get -u -v github.com/bep/s3deploy

