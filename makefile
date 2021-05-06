COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

OS_NAME := $(shell uname -s | tr A-Z a-z)

include .env
export

$(eval $(COMMAND_ARGS):;@:)
CURRENT_UID := $(shell id -u)
export CURRENT_UID

# Docker commands
start:
	CURRENT_UID=${CURRENT_UID} OS_NAME=$(OS_NAME) docker-compose up --build
stop:
	docker-compose down
enter:
	docker-exec -it $(COMMAND_ARGS) sh -l

# Composer commands for plugins
composer-install:
	docker-compose run --rm composer bash -c "composer install"
composer-update:
	docker-compose run --rm composer bash -c "composer update"
composer-require:
	docker-compose run --rm composer bash -c "composer require $(COMMAND_ARGS)"
composer-remove:
	docker-compose run --rm composer bash -c "composer remove $(COMMAND_ARGS)"

# Composer generic command
composer:
	docker-compose run --rm composer bash -c "composer $(COMMAND_ARGS)"

# Yarn commands
yarn-install:
	docker-compose run --rm yarn yarn install
yarn-upgrade:
	docker-compose run --rm yarn yarn upgrade $(COMMAND_ARGS)
yarn-add:
	docker-compose run --rm yarn yarn add $(COMMAND_ARGS)
yarn-remove:
	docker-compose run --rm yarn yarn remove $(COMMAND_ARGS)
yarn-build:
	docker-compose run --rm yarn yarn build:production

# Yarn generic command
yarn:
	docker-compose run --rm yarn yarn $(COMMAND_ARGS)

## SQL commands
sql-dump:
	docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install zip && mysqldump -uwebdev -proot $(PROJECT_NAME) | zip database/$(PROJECT_NAME)-$(shell date +%F).sql.zip -"
sql-import:
	docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install unzip && unzip -p database/$(COMMAND_ARGS) | mysql -uwebdev -proot $(PROJECT_NAME)"
