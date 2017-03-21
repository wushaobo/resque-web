#!/bin/bash

bundle install
bundle install --deployment

bundle exec rake app:assets:precompile RAILS_ENV=production

docker-compose build --force-rm
