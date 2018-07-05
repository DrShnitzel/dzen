# Response example:
# ")]}'\n{\"CurrencyUpdate\":[[412427.802237,2]\n,[412427.802237,2]\n,\"https://www.google.com/finance/chart?q\\u003dCURRENCY:BTCRUB\\u0026chst\\u003dvkc\\u0026tkr\\u003d1\\u0026chsc\\u003d2\\u0026chs\\u003d270x94\\u0026p\\u003d5Y\"]\n}"

class GoogleBtcParser
  def initialize
    @btc = RestClient.get(
      'https://www.google.com/async/currency_update?ei=zrU8W6W4MuLe6QTRz6_QDQ&client=safari&yv=3&async=source_amount:1,source_currency:%2Fm%2F05p0rrx,target_currency:%2Fm%2F01hy_q,chart_width:270,chart_height:94,lang:en,country:ru,_fmt:jspb'
    ).body
    $logger.debug("request to btc instaforex.com: #{@btc}")
  end

  def btc
    @btc.split('[[')[1].split('.').first
  end
end
