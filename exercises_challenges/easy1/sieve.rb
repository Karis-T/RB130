class Sieve
  def initialize(total)
    @total = total
  end

  def primes
    (2..@total).reject{|num| composite?(num)}
  end

  private

  def composite?(num)
    !(2..@total).one?{|den| num % den == 0}
  end

end

Sieve.new(10).primes #== [2,3,5,7]
Sieve.new(1000).primes