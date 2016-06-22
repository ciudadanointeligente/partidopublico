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

