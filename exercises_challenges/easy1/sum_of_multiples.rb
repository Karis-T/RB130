class SumOfMultiples
  @@multiples = [3,5]

  def initialize(*multiples)
    @multiples = multiples.empty? ? [3,5] : multiples
    @sum = []
  end

  def self.to(total)
    sum = []
    @@multiples.each {|num| sum << multiples(num, total) }
    consolidate(sum)
  end

  def self.multiples(num, total)
    (num..total-1).select{|n| n % num == 0}
  end

  def self.consolidate(sum)
    sum.flatten.uniq.sum
  end

  def to(total)
    @multiples.each {|num| @sum << multiples(num, total)}
    consolidate
  end

  private

  def consolidate
    @sum.flatten.uniq.sum
  end

  def multiples(num, total)
    (num..total-1).select{|n| n % num == 0}
  end
end

