FROM alpine:3.2
MAINTAINER Lamont Lucas <lamont@fastrobot.com>

# Update and install base packages
RUN apk update && apk upgrade && apk add curl wget bash

# Install ruby and ruby-bundler
RUN apk add ruby ruby-bundler

RUN apk --update add --virtual build_deps \
    build-base ruby-dev libc-dev linux-headers \
    openssl-dev postgresql-dev libxml2-dev libxslt-dev

#    && \
#    sudo -iu app bundle install --path vendor/bundle && \
#    apk del  build_deps

# Clean APK cache
RUN rm -rf /var/cache/apk/*

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle install

COPY . /usr/app

CMD ["./muniExporter.rb"]
