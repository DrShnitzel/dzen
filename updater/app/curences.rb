# Curences class is used to accamulate curences info from different sources
# and validates it
class Curences
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
