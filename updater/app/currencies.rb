# Currencies class is used to accamulate currencies info from different sources
# and validates it
class Currencies
  def initialize
    @parser = MeduzaParser.new
  end

  def to_json
    { usd: @parser.usd, eur: @parser.eur, btc: @parser.btc }.to_json
  end
end
