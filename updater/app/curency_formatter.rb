class CurrencyFormatter
  def self.call(amount)
    CurencyValidator.validate!(amount)
    amount.delete!(' ') if amount.class == String
    amount = amount.to_f

    return format('%.0f', amount) if amount > 10_000

    format('%.2f', amount)
  end
end
