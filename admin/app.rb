# frozen_string_literal: true
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'json'
Bundler.require(:default, ENV['RACK_ENV'])

get '/admin' do
  @btc = '456 666'
  erb :index
end
