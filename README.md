[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

[![Build Status](https://api.travis-ci.org/ciudadanointeligente/partidopublico.svg?branch=master)](https://travis-ci.org/ciudadanointeligente/partidopublico)
[![Code Climate](https://codeclimate.com/github/ciudadanointeligente/partidopublico/badges/gpa.svg)](https://codeclimate.com/github/ciudadanointeligente/partidopublico)
[![Coverage Status](https://codeclimate.com/github/ciudadanointeligente/partidopublico/badges/coverage.svg)](https://codeclimate.com/github/ciudadanointeligente/partidopublico/coverage)

[ partidopublico ](https://guarded-ocean-48128.herokuapp.com/)

is a ruby on rails app for achieving transparency of political parties, funded by UNDEF papu_rails is developed by Fundación Ciudadano Inteligente in
collaboration with Chile Transparente.

developed in a linux ruby postgresql environment, see Gemfile for additional requirements

To setup an environment for running the papu_rails app following steps are needed:
+ ruby 2.3.0
+ rails 4.2.6
+ postgresql:(instrucions for ubuntu systems)
    + connect to database: ( in a shell prompt: sudo su - postgresql, then: psql(first time without password))
        + \qset passwordwith sql command: alter role postgres with password 'a';

        + default encoding must be UTF8, follow steps from [this gist](https://gist.github.com/ffmike/877447) if needed

    + udate database config file pg_hba.conf (to find its location type: sudo find / -name hb_pga.config)
        + and change \# Database administrative login by Unix domain socket from peer to md5

    + restart database with command: sudo service postgresql restart

## Installation
### RVM

First you need to have [RVM](https://rvm.io/) installed in your machine.

### Bundler

Then you need to have installed [bundler](http://bundler.io/).

```
gem install bundler
```


### The rest of the gems

```
bundle install
```

## Testing

We have found that it is the safest to test against PostgreSQL, so the first thing you need to do is get postgres running.

Our default testing configurations is as follow:

```
host: 127.0.0.1
user: postgres
password: a
database_name: papu_test
```

```
psql -c 'create database papu_test;' -U postgres --host=127.0.0.1 --password
```

## branch dockerized for datacampfire challenge

to start docker version of the app follow next steps:
- populate env vars :
-- SECRET_KEY_BASE=xxxxx
-- POSTGRESQL_PORT=5432
-- POSTGRESQL_USER=db_user
-- POSTGRESQL_PASSWORD=db_pass
-- RAILS_ENV=production
-- RAILS_PORT=3000

-- export SECRET_KEY_BASE
-- export POSTGRESQL_PORT
-- export POSTGRESQL_USER
-- export POSTGRESQL_PASSWORD
-- export RAILS_ENV
-- export RAILS_PORT

- docker-compose run app bash --build

<!-- inside the app container prompt:
- bundle install
- bundle exec rake db:create -->

load db dump into empty db from the host machine with command:
- zcat docker_volumes/seeds/database_papu_dump.tar.gz | docker exec -i partidopublico_db_1 psql -U papu -d papu_prod

and finally again within the container:
- bundle exec rails console
