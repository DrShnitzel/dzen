class InstaforexBtcParser
  def initialize
    agent = Mechanize.new
    agent.get('https://www.instaforex.com/currency_converter.php?get_course=1&sym1=%23Bitcoin&sym2=RUB')
    @btc = agent.page.body
    $logger.debug("request to btc instaforex.com: #{@btc}")
  end

  def btc
    # remove dot
    resp = @btc.split('.').first
    resp
  end
end
