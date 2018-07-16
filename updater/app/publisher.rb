# Publisher is used to update currencies key in redis
# and to publish currencies info to redis chanel
# wich will deliver them furuther to socket servers
# that are responseble to deliver them to clients.
# NOTE: Forced publish from admin has priority over publish here
class Publisher
  def initialize
    @redis = Redis.new(host: 'redis')
  end

  def publish
    currencies = Currencies.new.to_json
    $logger.info("currencies json: #{currencies}")

    resp = @redis.publish('currencies-chanel', currencies)
    $logger.debug("publishing to redis chanel: #{resp}")

    resp = @redis.set('currencies', currencies)
    $logger.debug("setting redis key: #{resp}")

    @redis.disconnect!
  end
end
