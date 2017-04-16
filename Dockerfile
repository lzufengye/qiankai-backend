FROM ruby:2.1.5

RUN apt-get update && apt-get install -y nodejs && apt-get clean
RUN apt-get -y upgrade
RUN apt-get install imagemagick

COPY Gemfile* /tmp/
RUN cd /tmp/ && ls
RUN cd /tmp/ && bundle install --verbose --without=development

COPY ./ /app/
RUN cd /app/ && QINIU_ACCESS_KEY='' QINIU_SECRET_KEY='' RAILS_ENV=production rake assets:precompile

EXPOSE 8080

CMD ["/app/run"]
