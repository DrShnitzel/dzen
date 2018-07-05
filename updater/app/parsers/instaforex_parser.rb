# Response example:
# {"USD":{"value":"63.044","change":"-0.2120","pct":"-0.34%","direction":"down"},"EUR":{"value":"73.361","change":"+0.0230","pct":"+0.03%","direction":"up"}}

class InstaforexParser
  def initialize
    resp = RestClient.get('https://www.instaforex.com/ru/chart/USDRUR/get_online_quotes').body
    $logger.debug("request to instaforex.com: #{resp}")
    @stock = JSON.parse(resp)
  end

  def usd
    @stock['USD']['value']
  end

  def eur
    @stock['EUR']['value']
  end

  def btc
    @stock['btc']
  end
end
