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
	CURRENT_UID=${CURRENT_UID} docker-exec -it $(COMMAND_ARGS) sh -l

# Composer commands for plugins
composer-install:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm composer bash -c "composer install"
composer-update:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm composer bash -c "composer update"
composer-require:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm composer bash -c "composer require $(COMMAND_ARGS)"
composer-remove:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm composer bash -c "composer remove $(COMMAND_ARGS)"

# Composer generic command
composer:
	docker-compose run --rm composer bash -c "composer $(COMMAND_ARGS)"

# Yarn commands
yarn-install:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn yarn install
yarn-upgrade:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn yarn upgrade $(COMMAND_ARGS)
yarn-add:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn yarn add $(COMMAND_ARGS)
yarn-remove:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn yarn remove $(COMMAND_ARGS)
yarn-build:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn yarn build:production

# Yarn generic command
yarn:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn yarn $(COMMAND_ARGS)

# NPM generic command
npm:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn npm $(COMMAND_ARGS)
	
# Node generic command
node:
	CURRENT_UID=${CURRENT_UID} docker-compose run --rm yarn node $(COMMAND_ARGS)

## SQL commands
sql-dump:
	docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install zip && mysqldump -uwebdev -proot $(PROJECT_NAME) | zip database/$(PROJECT_NAME)-$(shell date +%F).sql.zip -"
sql-import:
	docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install unzip && unzip -p database/$(COMMAND_ARGS) | mysql -uwebdev -proot $(PROJECT_NAME)"
