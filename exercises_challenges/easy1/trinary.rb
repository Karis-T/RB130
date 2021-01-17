class Trinary
  def initialize(string)
    @string = string
    @decimal = 0
  end

  def to_decimal
    return 0 if invalid?
    @string.to_i.digits.each_with_index { |num, idx| @decimal += num * 3 ** idx }
    @decimal
  end

  def invalid?
    @string.match?(/[a-z3-9]/i)
  end  
end

p Trinary.new('102012').to_decimal