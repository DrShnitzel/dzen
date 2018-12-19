# Publisher is used to update currencies key in redis
# and to publish currencies info to redis chanel
# wich will deliver them furuther to socket servers
# that are responseble to deliver them to clients.
class Publisher
  def publish
    currencies = Currencies.new.to_json
    $logger.info("currencies json: #{currencies}")

    return if currencies == previus_currencies

    resp = $redis.publish('currencies-chanel', currencies)
    $logger.debug("publishing to redis chanel: #{resp}")

    resp = $redis.set('currencies', currencies)
    $logger.debug("setting redis key: #{resp}")

    self.previus_currencies = currencies
  end

  private

  def previus_currencies
    $redis.get(:previus_currencies)
  end

  def previus_currencies=(value)
    $redis.set(:previus_currencies, value)
  end
end
