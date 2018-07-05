class CurencyValidator
  def self.validate!(value)
    return if value.class == Float || value.class == Integer
    # it start with digit and may contain digits, dots and spaces after that
    match = /^[1-9][0-9. ]*$/.match(value)
    raise "#{value} is not correct curency value" unless match
  end
end
