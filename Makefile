# This makefile is helps to automate some of the steps needed
# to build, test, lint-check, and publish the project.

setup: upgrade_pip deps dev_deps install_project

all: setup test-unit lint

ci: setup test-unit lint

upgrade_pip:
	python -m pip install --upgrade pip

deps:
	python -m pip install -r requirements.txt

dev_deps:
	python -m pip install -r requirements-dev.txt

publish_deps:
	python -m pip install setuptools wheel twine build

install_project:
	python -m pip install -e .

test-unit:
	python -m pytest --cov=ibm_cloud_sdk_core test

lint:
	./pylint.sh

build_dist:
	rm -fr dist
	python -m build --outdir dist
	twine check --strict dist/*
