FROM alpine:3.7

RUN \
  # update packages
  apk update && apk upgrade && \
  # install ruby
  apk --no-cache add ruby ruby-dev ruby-bundler ruby-json ruby-irb ruby-rake ruby-bigdecimal && \
  # gem 'mechanize'
  apk --no-cache add zlib-dev g++ make && \
  rm -rf /var/cache/apk/*

# create WORKDIR
ENV WORKDIR /app
RUN mkdir $WORKDIR
WORKDIR $WORKDIR

# copy project
COPY . $WORKDIR
RUN bundle install
