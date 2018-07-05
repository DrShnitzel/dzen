require 'ostruct'
require 'logger'

Settings = OpenStruct.new

ENV['SLEEP_INTERVAL'] ||= '2'
Settings.sleep_interval = ENV['SLEEP_INTERVAL'].to_i

$logger = Logger.new(STDOUT)
ENV['LOGGER_LEVEL'] ||= '0'
$logger.level = ENV['LOGGER_LEVEL'].to_i
