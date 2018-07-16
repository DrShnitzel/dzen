require 'ostruct'
require 'logger'

Settings = OpenStruct.new

ENV['SLEEP_INTERVAL'] ||= '5'
Settings.sleep_interval = ENV['SLEEP_INTERVAL'].to_i

$logger = Logger.new(STDOUT)
ENV['LOGGER_LEVEL'] ||= '4'
$logger.level = ENV['LOGGER_LEVEL'].to_i
