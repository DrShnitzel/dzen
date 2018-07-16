# frozen_string_literal: true
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'json'
Bundler.require(:default, ENV['RACK_ENV'])

get '/admin' do
  @usd = '32.25'
  @eur = '38.40'
  @btc = '456666'
  erb :index
end

post '/admin/usd' do
  unixtime = Time.parse(params[:usd_time] + ' UTC').to_i + params[:offset].to_i
  puts Time.at(unixtime).to_s
  Time.at(unixtime).to_s
end
