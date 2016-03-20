[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

[![Build Status](https://api.travis-ci.org/jbci/papu_rails.svg?branch=master)](https://travis-ci.org/jbci/papu_rails)
[![Code Climate](https://codeclimate.com/github/jbci/papu_rails/badges/gpa.svg)](https://codeclimate.com/github/jbci/papu_rails)
[![Coverage Status](https://codeclimate.com/github/jbci/papu_rails/badges/coverage.svg)](https://codeclimate.com/github/jbci/papu_rails/coverage)

[ # papu_rails ](https://guarded-ocean-48128.herokuapp.com/)

is a ruby on rails app for achieving transparency of political parties, funded by UNDEF papu_rails is developed by Fundación Ciudadano Inteligente in
collaboration with Chile Transparente.

developed in a ruby '2.3.0', rails '4.2.6' and postgresql environment, see Gemfile for additional requirements

To setup an environment for running the papu_rails app following steps are needed:
+ ruby and rvm(recommended)
+ rails
+ postgresql:(instrucions for ubuntu systems)
    + connect to database: ( in a shell prompt: sudo su - postgresql, then: psql(first time without password))
        + \qset passwordwith sql command: alter role postgres with password 'a';
    
        + default encoding must be UTF8, follow steps from [this gist](https://gist.github.com/ffmike/877447) if needed

    + udate database config file pg_hba.conf (to find its location type: sudo find / -name hb_pga.config)
        + and change \# Database administrative login by Unix domain socket from peer to md5

    + restart database with command: sudo service postgresql restart

