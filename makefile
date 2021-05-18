COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

include .env
export

$(eval $(COMMAND_ARGS):;@:)

UID := $(shell id -u)
export UID

GID := $(shell id -g)
export GID

start:
	UID=${UID} GID=${UID} && docker-compose up --build
stop:
	UID=${UID} GID=${UID} && docker-compose down
enter:
	UID=${UID} GID=${UID} && docker-exec -it $(COMMAND_ARGS) sh -l

composer-install:
	UID=${UID} GID=${UID} && docker-compose run --rm composer bash -c "composer install"
composer-update:
	UID=${UID} GID=${UID} && docker-compose run --rm composer bash -c "composer update"
composer-require:
	UID=${UID} GID=${UID} && docker-compose run --rm composer bash -c "composer require $(COMMAND_ARGS)"
composer-remove:
	UID=${UID} GID=${UID} && docker-compose run --rm composer bash -c "composer remove $(COMMAND_ARGS)"

composer:
	UID=${UID} GID=${UID} && docker-compose run --rm composer bash -c "composer $(COMMAND_ARGS)"

vendor-phpstan:
	UID=${UID} GID=${UID} && docker-compose run --rm composer bash -c "vendor/bin/phpstan analyse --level 6 src"

vendor:
	UID=${UID} GID=${UID} && docker-compose run --rm composer bash -c "$(COMMAND_ARGS)"

yarn-install:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn yarn install
yarn-upgrade:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn yarn upgrade $(COMMAND_ARGS)
yarn-add:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn yarn add $(COMMAND_ARGS)
yarn-remove:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn yarn remove $(COMMAND_ARGS)
yarn-build:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn yarn build:production

yarn:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn yarn $(COMMAND_ARGS)

npm:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn npm $(COMMAND_ARGS)

node:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn node $(COMMAND_ARGS)

package:
	UID=${UID} GID=${UID} && docker-compose run --rm yarn $(COMMAND_ARGS)

sql-dump:
	UID=${UID} GID=${UID} && docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install zip && mysqldump -uwebdev -proot $(PROJECT_NAME) | zip database/$(PROJECT_NAME)-$(shell date +%F).sql.zip -"
sql-import:
	UID=${UID} GID=${UID} && docker-exec -i mysql sh -c "apt-get update -qqy -o Acquire::CompressionTypes::Order::=gz && apt-get install unzip && unzip -p database/$(COMMAND_ARGS) | mysql -uwebdev -proot $(PROJECT_NAME)"
