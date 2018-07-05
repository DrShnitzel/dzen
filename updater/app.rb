require './dependences.rb'

loop do
  begin
    Publisher.new.publish
    sleep(Settings.sleep_interval)
  rescue => e
    $logger.error(e.message)
    $logger.error(e.backtrace)
    sleep(Settings.sleep_interval)
  end
end
