FROM alpine:3.7

RUN \
  # update packages
  apk update && apk upgrade && \
  # install ruby
  apk --no-cache add ruby ruby-dev ruby-bundler ruby-json ruby-irb ruby-rake ruby-bigdecimal g++ make && \
  rm -rf /var/cache/apk/*

RUN apk --no-cache add nodejs
# create WORKDIR
ENV WORKDIR /app
RUN mkdir $WORKDIR
WORKDIR $WORKDIR

# do not install documentation for gems
COPY gemrc $HOME/.gemrc

# install gems
COPY Gemfile $WORKDIR
RUN bundle install
