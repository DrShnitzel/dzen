# Publisher is used to update curences key in redis
# and to publish curences info to redis chanel
# wich will deliver them furuther to socket servers
# that are responseble to deliver them to clients.
# NOTE: Forced publish from admin has priority over publish here
class Publisher
  def initialize
    @redis = Redis.new(host: 'redis')
  end

  def publish
    curences = Curences.new.to_json
    $logger.info("curences json: #{curences}")

    resp = @redis.publish('curences-chanel', curences)
    $logger.debug("publishing to redis chanel: #{resp}")

    resp = @redis.set('curences', curences)
    $logger.debug("setting redis key: #{resp}")

    @redis.disconnect!
  end
end
