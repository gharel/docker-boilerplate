`sudo rm -Rf logs && sudo rm -Rf database && sudo rm -Rf www/node_modules && sudo rm -Rf www/vendor && sudo rm -Rf www/composer.lock && sudo rm -Rf www/package-lock.json`  
  
`make composer "require --dev phpstan/phpstan"`  
`make npm "install -D eslint"`  
`make package "yarn rome init"`  
