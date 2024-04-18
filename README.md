### TDD avec dbt

Ce projet sert de support à un article (tdd avec dbt, lien à venir) de présentation de la feature de dbt 1.8 [tests unitaires](https://docs.getdbt.com/docs/build/unit-tests).

On utilise un fichier *.csv* pour mimer une source *fact_emails* et nous allons construire, à travers une mise en situation l'évolution d'un modèle d'aggrégation *agg_hourly_domain_emails*. 

Chaque version du modèle se trouve sur une branche différente. J'utilise pour l'instant une connection PostgreSQL mais dès que la version dbt-duckdb 1.8 est disponible, je mettrai le repository à jour.

### Getting started 
Ce guide est fait pour un terminal linux-like. Si vous êtes sur Windows, assurez vous d'être dans un terminal WSL2.  
Asurez vous d'avoir python3 d'installé et virtualenv aussi. Si ce n'est pas le cas, vous allez peut-être devoir lancé les commandes suivantes : 
``` bash
apt update && upgrade 
apt install python3-pip
apt install python3-virtualenv
apt install libpython3-dev
```

Ensuite, pour créer votre environement virtuel, vous n'avez qu'à lancer la commande :
```bash
make install
```

Pour finir, créer un fichier *.env* ressemblant à ce qui suit. Vous mettrez vos identifiants de connections à la base PostgreSQL :
```
export POSTGRES_HOST_DEV=
export POSTGRES_USER_DEV=
export POSTGRES_PASSWORD_DEV=
export POSTGRES_DATABASE_DEV=
export POSTGRES_SCHEMA_DEV=
export DBT_PROFILES_DIR=.dbt_profiles
```

Pour charger ces variables, lancer la commande : 
``` bash
source .env
```

Pour vérifier que tout fonctionne bien, lancer la commande :
``` bash
dbt debug
```