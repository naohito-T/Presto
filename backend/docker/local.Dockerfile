# ruby:3.1.2-slim
from ruby@sha256:4c0c7fede8fed8ee35dba03cf8792e65f8d4c0eb0a4a7c21ef7f646c9e8abac1
ENV LANG C.UTF-8

ENV APP_HOME /rails_app
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock /rails_app

RUN apt update -qqy \
    && apt install -qqy --no-install-recommends make gcc git curl g++ default-libmysqlclient-dev xz-utils\
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt install -qqy --no-install-recommends nodejs \
    && npm install -g yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && gem install bundler

COPY . $APP_HOME

# # Expose assets for web container
# VOLUME $APP_HOME/public/assets

# EXPOSE 3000
# CMD bundle exec rails server -b 0.0.0.0
