COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

include .env
export

$(eval $(COMMAND_ARGS):;@:)

UID := $(shell id -u)
export UID

GID := $(shell id -g)
export GID

# Docker commands
start:
	UID=${UID} GID=$(GID) docker-compose up --build
stop:
	UID=${UID} GID=$(GID) docker-compose down
enter:
	UID=${UID} GID=$(GID) docker-exec -it $(COMMAND_ARGS) sh -l

# Composer commands for plugins
composer-install:
	UID=${UID} GID=$(GID) docker-compose run --rm composer bash -c "composer install"
composer-update:
	UID=${UID} GID=$(GID) docker-compose run --rm composer bash -c "composer update"
composer-require:
	UID=${UID} GID=$(GID) docker-compose run --rm composer bash -c "composer require $(COMMAND_ARGS)"
composer-remove:
	UID=${UID} GID=$(GID) docker-compose run --rm composer bash -c "composer remove $(COMMAND_ARGS)"

# Composer generic command
composer:
	UID=${UID} GID=$(GID) docker-compose run --rm composer bash -c "composer $(COMMAND_ARGS)"

# Yarn commands
yarn-install:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn yarn install
yarn-upgrade:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn yarn upgrade $(COMMAND_ARGS)
yarn-add:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn yarn add $(COMMAND_ARGS)
yarn-remove:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn yarn remove $(COMMAND_ARGS)
yarn-build:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn yarn build:production

# Yarn generic command
yarn:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn yarn $(COMMAND_ARGS)

# NPM generic command
npm:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn npm $(COMMAND_ARGS)
	
# Node generic command
node:
	UID=${UID} GID=$(GID) docker-compose run --rm yarn node $(COMMAND_ARGS)

## SQL commands
sql-dump:
	UID=${UID} GID=$(GID) docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install zip && mysqldump -uwebdev -proot $(PROJECT_NAME) | zip database/$(PROJECT_NAME)-$(shell date +%F).sql.zip -"
sql-import:
	UID=${UID} GID=$(GID) docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install unzip && unzip -p database/$(COMMAND_ARGS) | mysql -uwebdev -proot $(PROJECT_NAME)"
