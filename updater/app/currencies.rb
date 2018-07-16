# Currencies class is used to accamulate currencies info from different sources
# and validates it
class Currencies
  def initialize
    @forex = InstaforexParser.new
    @google = GoogleBtcParser.new
  end

  def to_json
    CurencyValidator.validate!(@forex.usd)
    CurencyValidator.validate!(@forex.eur)
    CurencyValidator.validate!(@google.btc)
    { usd: @forex.usd, eur: @forex.eur, btc: @google.btc }.to_json
  end
end
