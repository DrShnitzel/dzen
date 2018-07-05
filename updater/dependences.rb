# frozen_string_literal: true
ENV['APP_ENV'] ||= 'development'

require 'bundler/setup'
require 'json'
Bundler.require(:default, ENV['APP_ENV'])

files_to_load = []
files_to_load += Dir['./config/*.rb']
files_to_load += Dir['./app/parsers/*.rb']
files_to_load += Dir['./app/*.rb']
files_to_load.map { |path| require path }
