class MeduzaParser
  def initialize
    resp = RestClient.get('https://meduza.io/api/v3/stock/all')
    $logger.debug("request to meduza.io: #{resp}")
    @stock = JSON.parse(resp)
  end

  def usd
    CurrencyFormatter.call(@stock['usd']['current'])
  end

  def eur
    CurrencyFormatter.call(@stock['eur']['current'])
  end

  def btc
    CurrencyFormatter.call(@stock['btc'])
  end
end
