class MeduzaParser
  def initialize
    resp = RestClient.get('https://meduza.io/api/v3/stock/all')
    $logger.debug("request to meduza.io: #{resp}")
    @stock = JSON.parse(resp)
  end

  def usd
    @stock['usd']['current']
  end

  def eur
    @stock['eur']['current']
  end

  def btc
    @stock['btc']
  end
end
