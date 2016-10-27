FROM ruby:2.1

COPY ./docker/cn.list /etc/apt/sources.list
RUN apt-get update -q && apt-get install -y build-essential curl telnet vim nodejs

COPY ./docker/install_passenger.sh /tmp/install_passenger.sh
RUN /tmp/install_passenger.sh
RUN apt-get clean

COPY ./docker/resque_web /etc/nginx/sites-enabled/resque_web
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

COPY . /opt/apps/resque-web/
WORKDIR /opt/apps/resque-web/

RUN gem install bundler && bundle install
RUN bundle exec rake app:assets:precompile RAILS_ENV=production

WORKDIR /opt/apps/resque-web/test/dummy
EXPOSE 80

CMD passenger start --min-instance 4 --port 80