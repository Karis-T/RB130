class Octal
  def initialize(string)
    @string = string
    @decimal = 0
  end

  def to_decimal
    return 0 if invalid?
    @string.to_i.digits.each_with_index { |num, idx| @decimal += num * 8 ** idx }
    @decimal
  end

  def invalid?
    @string.match?(/[a-z89]/i)
  end
end

p Octal.new('6789').to_decimal