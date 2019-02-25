all: verify_contracts install

.PHONY: remove_limits

compile_contracts:
	python setup.py compile_contracts

verify_contracts:
	python setup.py verify_contracts

remove_limits:
	python raiden_contracts/utils/remove_limits.py \
	raiden_contracts/contracts \
	raiden_contracts/contracts_without_limits

install:
	pip install -r requirements.txt
	pip install -e .

lint:
	flake8 raiden_contracts/

mypy:
	mypy --ignore-missing-imports --check-untyped-defs raiden_contracts

clean:
	rm -rf build/ *egg-info/ dist .eggs

release: clean verify_contracts
	python setup.py sdist bdist_wheel upload
