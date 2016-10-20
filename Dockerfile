FROM ruby:2.1

COPY ./docker/cn.list /etc/apt/sources.list
RUN apt-get update -q && apt-get install -y build-essential curl telnet vim nodejs

COPY ./docker/install_passenger.sh /tmp/install_passenger.sh
RUN /tmp/install_passenger.sh

COPY ./docker/resque_web /etc/nginx/sites-enabled/resque_web
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

COPY . /opt/apps/resque-web/
WORKDIR /opt/apps/resque-web/

RUN bundle install
RUN RAILS_ENV=production bundle exec rake app:assets:precompile

EXPOSE 80

RUN service nginx start
