FROM ruby:2-slim-bullseye
RUN apt-get update -qq && apt-get install -y nodejs default-libmysqlclient-dev
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /myapp


COPY ./script/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8800

# Start the server on 0.0.0.0:8800
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8800"]