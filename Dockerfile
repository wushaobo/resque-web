FROM ruby:2.1

COPY ./docker/cn.list /etc/apt/sources.list
RUN rm -rf /etc/apt/sources.list.d/* && apt-get update -q && apt-get install -y curl telnet vim && apt-get clean

COPY ./docker/install_passenger.sh /tmp/install_passenger.sh
RUN /tmp/install_passenger.sh

COPY ./docker/ngx_resque_web /etc/nginx/sites-enabled/ngx_resque_web
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

RUN export RAILS_ENV=production && \
	bundle install && \
	bundle install --deployment && \
	bundle exec rake app:assets:precompile 

COPY ./test/dummy /opt/apps/resque-web/test/dummy
COPY ./vendor /opt/apps/resque-web/vendor

WORKDIR /opt/apps/resque-web/test/dummy
EXPOSE 80

CMD passenger start --min-instance 4 --port 80