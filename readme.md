[![N|Skazy](https://zenprospect-production.s3.amazonaws.com/uploads/pictures/5c35693ff6512504e5876154/picture)](https://skazy.nc)

# Environnement Docker Scratch

### Table des matières
- [À propos](#à-propos)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Conteneurs](#conteneurs)

# À propos

Ce dépôt contient une base pour installer rapidement un site PHP sous l'architecture docker.<br>
Vous pouvez également l'utiliser pour travailler et évoluer votre projet.<br>
Notez que cette solution vous fournira des conteneurs rapides et uniques avec tous les services nécessaires au bon fonctionnement de votre site web, évitant le besoin d'installer des logiciels supplémentaires.

# Prérequis
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Git](https://git-scm.com/)
* [Make](http://gnuwin32.sourceforge.net/packages/make.htm)

# Installation

## 1 - Installer docker:

https://docs.docker.com/installation/

## 2 - Installer git:

https://git-scm.com/book/fr/v2/D%C3%A9marrage-rapide-Installation-de-Git

## 3 - Installer Make:

##### Si vous n'êtes pas sous linux/mac
Vous devez avoir la commande "make" de disponible sur votre poste, ce qui est le cas par défaut sur Linux. Pour les utilisateurs windows : <br />
Si vous utiliez Cygwin (ou bash avec commandes linux équivalent), vous ne devriez rien avoir à installer. <br/>
Si vous utilisez Git-bash, il faut télécharger le plugin [https://sourceforge.net/projects/ezwinports/files/make-4.3-without-guile-w32-bin.zip/download](https://sourceforge.net/projects/ezwinports/files/make-4.3-without-guile-w32-bin.zip/download) et copier le contenu du zip dans VOS_PROGRAMMES/Git/mingw64 <br />
Si vous utilisez un terminal classique il vous faudra installer [https://sourceforge.net/projects/gnuwin32/files/make/3.81/make-3.81.exe/download?use_mirror=nchc&download=](https://sourceforge.net/projects/gnuwin32/files/make/3.81/make-3.81.exe/download?use_mirror=nchc&download=)

## 4 - Ouvrir un terminal

Lancer les commandes git :
```
git config --global core.autocrlf false
git config --global core.filemode false

```

Cloner le projet :
```
git clone ssh://git@gitlab.skazy.name:2222/web/install-by-docker/docker-scratch.git {nomduprojet}
```

Allez à la racine du projet :
```
cd {nomduprojet}
```

Supprimer le dossier .git :
```
rm -rf .git
```

Modifiez votre fichier .env et remplacez les variables souhaitées :
```
vim .env    
```

Lancez vos conteneurs et attendez l'installation jusqu'au message : Projet prêt sur http://localhost:3000/
```
make
```

Et voila !

###### Récap :

```sh
$ git clone ssh://git@gitlab.skazy.name:2222/web/install-by-docker/docker-scratch.git {nomduprojet}
$ cd {nomduprojet}
$ rm -rf .git
$ vim .env
$ make
```

# Conteneurs
| Conteneurs | Hôte (Accès url) | Commandes |
| ------ | ------ | ------ |
| Site Web | [localhost](https://localhost/) |
| Nginx | / |
| MySQL | / | exporter votre base de données : <br><br> ``` make sql-dump ```  <br><br> importer votre base de données : <br><br> ``` make sql-import {NOM_DU_FICHIER_SQL}  ``` [dans database] |
| PhpMyAdmin | [localhost:8080](http://localhost:8080/) |
| Mailhog | [localhost:1025](http://localhost:1025/) |
| Composer | / | ``` make composer ``` [install, require, update...] ou par exemple directement ``` make composer-install ``` |
| Yarn | / | ``` make yarn ``` [add, remove, install...] ou par exemple directement ``` make yarn-install ``` |

#### Commands examples
`sudo rm -Rf logs && sudo rm -Rf database && sudo rm -Rf www/node_modules && sudo rm -Rf www/vendor && sudo rm -Rf www/composer.lock && sudo rm -Rf www/package-lock.json`

`make composer "require --dev phpstan/phpstan"`  
`make npm "install -D eslint"`  
`make package "yarn rome init"`

# TODO
- [ ] add & link to git socle
- [ ] install webpack & finish front
